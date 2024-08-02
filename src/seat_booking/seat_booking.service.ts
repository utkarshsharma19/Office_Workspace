import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from '@nestjs/common';
import { CreateSeatBookingDto } from './dto/create-seat_booking.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, MoreThanOrEqual } from 'typeorm';
import { SeatBooking } from './entities/seat_booking.entity';
import { FloorDetailsService } from '../floor_details/floor_details.service';
import { OverallBookingService } from '../overall_booking/overall_booking.service';
import { UserService } from 'src/user/user.service';
import { NotificationService } from 'src/notification/notification.service';

@Injectable()
export class SeatBookingService {

  constructor(
    @InjectRepository(SeatBooking) private readonly repo: Repository<SeatBooking>,
    private readonly floordetailsService: FloorDetailsService,
    private readonly userService: UserService,
    private readonly notificationService: NotificationService,
    @Inject(forwardRef(() => OverallBookingService))
    private overallBookingService: OverallBookingService) { }

  //get all seats which are booked in the form of an array
  getBookedSeatNumbers(seat_no: string[], booking: SeatBooking[]) {
    for (const b of booking) {
      const seats = b.seat_no
      for (let sno of seats) {
        sno = sno.replace(/[\[\]\{\}]/g, '')
        seat_no.push(sno)
      }
    }
    return seat_no
  }

  //get all seat numbers present in the floor from starting and ending seat number
  async getSeatNumbersInRange(start: string, end: string): Promise<string[]> {
    const seatNumbers: string[] = [];
    const prefix = start.slice(0, -3); // Extract the prefix "WS GF "

    let currentSeat = start;
    while (currentSeat !== end && currentSeat < end) {
      seatNumbers.push(currentSeat);
      console.log(currentSeat, start, end)
      //get the number from the seat number
      const seatNumberParts = currentSeat.split(' ');
      let lastPart = parseInt(seatNumberParts[1]);
      lastPart++;
      if (lastPart < 10) {
        currentSeat = `${prefix}00${lastPart}`;
      } else if (lastPart < 100) {
        currentSeat = `${prefix}0${lastPart}`;
      } else {
        currentSeat = `${prefix}${lastPart}`;
      }
      console.log(currentSeat, start, end)
    }
    seatNumbers.push(end); // Include the end seat number
    return seatNumbers;
  }
  async getConsecutiveSeats(capacity: number, available: string[]) {
    let S = new Set<number>(); // Explicitly define the type of the set

    for (let i of available) {
      const seatNumberParts = i.split(' ');
      let lastPart = parseInt(seatNumberParts[2]);
      S.add(lastPart);
    }

    let consecutiveSeat: string[] = [];
    for (let i of available) {
      consecutiveSeat = [];
      const seatNumberParts = i.split(' ');
      let lastPart = parseInt(seatNumberParts[2]);

      if (!S.has(lastPart - 1)) {
        let j = lastPart;

        while (j <= Math.max(...Array.from(S)) - capacity + 1) {
          let currentSeat;
          if (j < 10)
            currentSeat = seatNumberParts[0] + " " + seatNumberParts[1] + " 00" + j;
          else if (j < 100)
            currentSeat = seatNumberParts[0] + " " + seatNumberParts[1] + " 0" + j;
          else
            currentSeat = seatNumberParts[0] + " " + seatNumberParts[1] + " " + j;
          consecutiveSeat.push(currentSeat);
          j++;

          if (consecutiveSeat.length >= capacity)
            break;
        }

        if (consecutiveSeat.length >= capacity)
          break;
      }
    }

    if (consecutiveSeat.length >= capacity)
      return consecutiveSeat;

    return [];
  }



  async create(createSeatBookingDto: CreateSeatBookingDto) {

    // if the booking fails
    try {
      //get all bookings based on date
      let bookings_today = await this.repo.find({ where: { date: new Date(createSeatBookingDto.date), floor_number: createSeatBookingDto.floor_number + 1 } })
      console.log(bookings_today)
      let seat_no: string[] = []

      //get all seats booked in the form of an array
      seat_no = this.getBookedSeatNumbers(seat_no, bookings_today)
      console.log(seat_no)
      let booked_seats = new Set(seat_no)

      //get the floor details
      let floorDet = await this.floordetailsService.getFloorDet(createSeatBookingDto.floor_number)
      console.log(floorDet)
      let startingSeat = floorDet[0].starting_seat_no
      let endingSeat = floorDet[0].ending_seat_no

      console.log('line 118')
      //get all the seat numbers present in the floor
      const seatNumbersInRange = await this.getSeatNumbersInRange(startingSeat, endingSeat);
      console.log(seatNumbersInRange)
      //filter them to get available seats
      const available = seatNumbersInRange.filter((seat) => !booked_seats.has(seat))
      console.log(available)
      console.log('line 125')
      //get consecutive seats based on capacity
      const to_be_booked = await this.getConsecutiveSeats(createSeatBookingDto.capacity, available)
      console.log(to_be_booked)

      if (to_be_booked.length == 0)
        throw new HttpException("Seats not found", HttpStatus.BAD_REQUEST)

      console.log('line 131')
      createSeatBookingDto.seat_no = to_be_booked
      createSeatBookingDto.date = new Date(createSeatBookingDto.date)
      createSeatBookingDto.status = true
      createSeatBookingDto.floor_number = createSeatBookingDto.floor_number + 1
      if (!createSeatBookingDto.users)
        createSeatBookingDto.users = []

      console.log('line 139')
      //add to db
      let booking = await this.repo.save(createSeatBookingDto)

      //add to overall booking table
      let amenity = "Seating"
      let booking_id = booking.booking_id
      let details = [createSeatBookingDto.floor_number.toString(), createSeatBookingDto.seat_no.toString()]
      if (createSeatBookingDto.users.length > 0)
        details.push(createSeatBookingDto.users.toString())
      let overall_booking = { bookingID: booking_id, amenity: amenity, token: createSeatBookingDto.token, details: details, date: createSeatBookingDto.date }


      //notification for that specific user (at the time of booked and a day before)
      let user = await this.userService.findOne(createSeatBookingDto.token)
      var notification_row = {
        date: createSeatBookingDto.date,
        title: 'Seat Booked',
        message: details.join(' '),
        token: user[0].firebaseToken
      }
      this.notificationService.createNotification(
        notification_row.date, notification_row.title, notification_row.message, notification_row.token
      )

      //checking if the booked day is not the current day(no need of sending a day before)
      // if (createSeatBookingDto.date.getDate() !== notification_row.date.getDate()) {
      notification_row.date.setDate(createSeatBookingDto.date.getDate() - 1)
      notification_row.title = 'Upcoming Booking'
      this.notificationService.createNotification(
        notification_row.date, notification_row.title, notification_row.message, notification_row.token
      )
      // }

      notification_row.title = 'Seat is booked for You'
      //notifying other users for booking
      let booking_users = createSeatBookingDto.users
      for (let i of booking_users) {
        user = await this.userService.findOne(i)
        notification_row.token = user[0].firebaseToken
        this.notificationService.createNotification(
          notification_row.date, notification_row.title, notification_row.message, notification_row.token
        )
      }

      return this.overallBookingService.create({ ...overall_booking })

    } catch (er) {
      let user = await this.userService.findOne(createSeatBookingDto.token)
      let notification_row = {
        date: new Date(),
        title: 'Meeting booking failed',
        message: er,
        token: user[0].firebaseToken
      }
      this.notificationService.createNotification(
        notification_row.date, notification_row.title, notification_row.message, notification_row.token
      )

    }
  }

  findAll() {
    return this.repo.find();
  }

  async findOne(id: number) {
    let booking = await this.repo.find({ where: { booking_id: id } });
    if (booking.length == 0)
      throw new HttpException("Booking not found", HttpStatus.BAD_REQUEST)
    return booking
  }

  async remove(id: number) {
    let b = this.repo.delete(id)
    return this.overallBookingService.deleteByID(id, "Seating")

  }

  async update(id: number, updateSeatBookingDto: CreateSeatBookingDto) {
    let new_booking = this.create(updateSeatBookingDto)
    let old_booking = await this.remove(id)
    console.log(old_booking)
    return new_booking
  }

  //get upcoming bookings made by the user
  async getByToken(token: string) {
    var now = new Date(new Date).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)
    let b = await this.repo.createQueryBuilder('booking')
      .andWhere('booking.date >= :date', { date: now1 })
      .getMany()
    let booking = []
    for (let i of b) {
      if (i.token == token || i.users.includes(token))
        booking.push(i)
    }
    if (booking.length == 0)
      throw new HttpException("Booking not found", HttpStatus.BAD_REQUEST)
    return { "seatsData": booking }
  }

  //get count of available seats based on current date and time
  async getAvailDate() {
    let total_capacity = await this.floordetailsService.findTotalCapacity()
    var now = new Date(new Date).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)
    // console.log(now1)
    let booking_today = await this.repo.find({ where: { date: now1 } })
    let total_booked = 0;
    for (const booking of booking_today)
      total_booked += booking.seat_no.length
    return total_capacity - total_booked
  }

  //get number of seats booked for that particular floor
  async getBookedSeatsCount(floorNumber: number, bookings: any[]): Promise<number> {
    const booking = bookings.find(booking => booking.floor_number === floorNumber);
    return await booking ? booking.seat_no : 0;
  }

  //get availability based on date and floor
  async getAvailDateFloor(date: Date) {
    var now = new Date(new Date(date).setUTCHours(0, 0, 0, 0))
    // console.log(now)
    const floors = await this.floordetailsService.findAll();
    //get floor number, capacity and floor name of all floors
    const floorDet = floors.map(({ floor_number, capacity, floor_name }) => ({
      floor_number,
      capacity,
      floor_name
    }));

    //find bookings for that day
    const bookings = await this.repo.find({ where: { date: now } });

    const combinedSeats: { [key: number]: string[] } = {};

    //store the floor numbers acc to the floor
    for (const booking of bookings) {
      const { floor_number, seat_no } = booking;
      if (combinedSeats.hasOwnProperty(floor_number)) {
        combinedSeats[floor_number].push(...seat_no);
      } else {
        combinedSeats[floor_number] = seat_no;
      }
    }

    //mao floor number eith seat number
    const result = Object.entries(combinedSeats).map(([floor_number, seat_no]) => ({
      floor_number: parseInt(floor_number, 10),
      seat_no: seat_no.map((seat) => seat.replace(/[[\]]/g, '')),
    }));

    const output = result.map((item) => ({
      floor_number: item.floor_number - 1,
      seat_no: item.seat_no.length,
    }));

    //subtract capacity with number of bookings done for each floor
    const res = await Promise.all(
      floorDet.map(async (floor) => ({
        floor_number: floor.floor_number,
        floor_name: floor.floor_name,
        available: floor.capacity - await this.getBookedSeatsCount(floor.floor_number, output),
      }))
    );

    return { "Availability": res };
  }
}
