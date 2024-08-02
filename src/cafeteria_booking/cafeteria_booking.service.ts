import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from '@nestjs/common';
import { CreateCafeteriaBookingDto } from './dto/create-cafeteria_booking.dto';
import { UpdateCafeteriaBookingDto } from './dto/update-cafeteria_booking.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { CafeteriaBooking } from './entities/cafeteria_booking.entity';
import { Repository } from 'typeorm';
import { FloorDetailsService } from '../floor_details/floor_details.service';
import { GetAvailaBilityDto } from './dto/get-availability.dto';
import { OverallBookingService } from '../overall_booking/overall_booking.service';
import { UserService } from 'src/user/user.service';
import { NotificationService } from 'src/notification/notification.service';

@Injectable()
export class CafeteriaBookingService {

  constructor(
    @InjectRepository(CafeteriaBooking) private readonly repo: Repository<CafeteriaBooking>,
    private readonly floordetailsService: FloorDetailsService,
    private readonly userService: UserService,
    private readonly notificationService: NotificationService,
    @Inject(forwardRef(() => OverallBookingService))
    private overallBookingService: OverallBookingService) { }

  /*create cafeteria booking */
  async create(createCafeteriaBookingDto: CreateCafeteriaBookingDto) {
    // if the booking fails
    try {
      //convert the date into proper format
      createCafeteriaBookingDto.date = new Date(createCafeteriaBookingDto.date)
      createCafeteriaBookingDto.start_time = new Date(createCafeteriaBookingDto.start_time)
      createCafeteriaBookingDto.end_time = new Date(createCafeteriaBookingDto.end_time)

      //add to table
      let booking = await this.repo.save(createCafeteriaBookingDto)

      //add to overall booking table
      let amenity = "Cafeteria"
      let bookingID = booking.booking_id

      //add the booking details to the array
      let details = [(createCafeteriaBookingDto.start_time).toISOString(), (createCafeteriaBookingDto.end_time).toISOString()]
      let overall_booking = { amenity: amenity, bookingID: bookingID, date: createCafeteriaBookingDto.date, details: details, token: createCafeteriaBookingDto.token }


      //notification for that specific user (at the time of booked and a day before)
      console.log('token recieved  :::::::     ', createCafeteriaBookingDto.token)
      let user = await this.userService.findOne(createCafeteriaBookingDto.token)
      console.log(user)
      let notification_row = {
        date: new Date(),
        title: 'Cafeteria booked',
        message: details.join(' '),
        token: user[0].firebaseToken
      }

      const time = createCafeteriaBookingDto.start_time.toLocaleTimeString('en-US', { hour12: false })
      const date = createCafeteriaBookingDto.date.toISOString().split('T')[0];
      console.log(new Date(`${date}T${time}`))
      notification_row.date = new Date(`${date}T${time}`);
      notification_row.message = notification_row.date.toString()
      this.notificationService.createNotification(
        new Date(), notification_row.title, notification_row.message, notification_row.token
      )


      notification_row.date.setDate(notification_row.date.getDate() - 1)
      console.log(createCafeteriaBookingDto.date.toString(), '  compared with  ', notification_row.date.toString())
      notification_row.title = 'Upcoming Cafeteria booking'
      this.notificationService.createNotification(
        notification_row.date, notification_row.title, notification_row.message, notification_row.token
      )

      console.log('all completed')
      return this.overallBookingService.create({ ...overall_booking })
    } catch (er) {
      console.log(er)
      let user = await this.userService.findOne(createCafeteriaBookingDto.token)
      let notification_row = {
        date: new Date(),
        title: 'Cafeteria booking failed',
        message: 'Internal server error',
        token: user[0].firebaseToken
      }
      this.notificationService.createNotification(
        notification_row.date, notification_row.title, notification_row.message, notification_row.token
      )
    }
  }

  //get all bookings
  findAll() {
    return this.repo.find();
  }

  //get bookings by booking id
  async findOne(id: number) {
    let booking = await this.repo.findOne({ where: { booking_id: id } });
    if (!booking)
      throw new HttpException("Booking not found", HttpStatus.BAD_REQUEST)
    return booking
  }

  //update booking
  update(id: number, updateCafeteriaBookingDto: UpdateCafeteriaBookingDto) {

    //change to proper date format
    if (updateCafeteriaBookingDto.date)
      updateCafeteriaBookingDto.date = new Date(updateCafeteriaBookingDto.date)
    if (updateCafeteriaBookingDto.start_time)
      updateCafeteriaBookingDto.start_time = new Date(updateCafeteriaBookingDto.start_time)
    if (updateCafeteriaBookingDto.end_time)
      updateCafeteriaBookingDto.end_time = new Date(updateCafeteriaBookingDto.end_time)

    //update in cafeteria booking table
    let booking = this.repo.update(id, updateCafeteriaBookingDto)

    //update in overall booking table
    return this.overallBookingService.update(id, updateCafeteriaBookingDto, "Cafeteria")
  }

  remove(id: number) {
    //remove from cafeteria booking table
    let booking = this.repo.delete(id)

    //remove from overall booking table
    let overall = this.overallBookingService.deleteByID(id, "Cafeteria")
    return overall
  }

  /* Get the total available seats based on the current date */
  async getAvailDate() {
    var now = new Date(new Date()).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)
    let floor = await this.floordetailsService.getFloorDet(5)
    let bookings = this.repo.find({ where: { date: now1 } })
    return floor[0].capacity - (await bookings).length
  }

  /*Get upcoming bookings by user email */
  async getByToken(token: string) {
    var now = new Date(new Date).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)

    const bookings = await this.repo
      .createQueryBuilder('cafebooking')
      .where('cafebooking.token = :token', { token })
      .andWhere('cafebooking.date >= :currentDate', { currentDate: now1 })
      .getMany();

    if (bookings.length == 0)
      return new HttpException("Booking not found", HttpStatus.BAD_REQUEST)
    return { "cafeteriaData": bookings }
  }

  /* Get availability based on date, start time and end time */
  async getAvailDateTime(getAvailabilityDto: GetAvailaBilityDto) {
    var now = new Date(new Date).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)

    const bookings_by_date = await this.repo.createQueryBuilder('booking')
      .where('booking.date = :date', { date: now1 })
      .andWhere('(booking.start_time < :end_time AND booking.start_time >= :start_time)')
      .orWhere('(booking.end_time <= :end_time AND booking.start_time > :start_time)')
      .orWhere('(booking.start_time <= :end_time AND booking.end_time >= :start_time)')
      .setParameter('start_time', getAvailabilityDto.start_time)
      .setParameter('end_time', getAvailabilityDto.end_time)
      .getMany();

    //get total booked seats
    let booked_seats = bookings_by_date.length

    //get capacity of floor
    let floor = await this.floordetailsService.getFloorDet(5)
    return floor[0].capacity - booked_seats
  }
}



