import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from '@nestjs/common';
import { CreateMeetingroomBookingDto } from './dto/create-meetingroom_booking.dto';
import { UpdateMeetingroomBookingDto } from './dto/update-meetingroom_booking.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { MeetingroomBooking } from './entities/meetingroom_booking.entity';
import { Repository } from 'typeorm';
import { MeetingroomDetailsService } from '../meetingroom_details/meetingroom_details.service';
import { FloorDetailsService } from '../floor_details/floor_details.service';
import { OverallBookingService } from '../overall_booking/overall_booking.service';
import { UserService } from '../user/user.service';
import { GetAvailabilityDto } from './dto/get-availability.dto';
import * as moment from 'moment-timezone'
import { NotificationService } from 'src/notification/notification.service';

@Injectable()
export class MeetingroomBookingService {

  constructor(@InjectRepository(MeetingroomBooking) private readonly repo: Repository<MeetingroomBooking>,
    private readonly meetingRoomService: MeetingroomDetailsService,
    private readonly floorDetail: FloorDetailsService,
    private readonly userService: UserService,
    private readonly notificationService: NotificationService,
    @Inject(forwardRef(() => OverallBookingService))
    private overallBookingService: OverallBookingService) { }

  //post meeting room boking
  async create(createMeetingroomBookingDto: CreateMeetingroomBookingDto) {
    // if the booking fails
    try {
      if (createMeetingroomBookingDto.end_time <= createMeetingroomBookingDto.start_time)
        throw new HttpException('Please enter valid start and end time', HttpStatus.BAD_REQUEST)
      console.log('Check 1')
      //convert date and time to proper format
      createMeetingroomBookingDto.date = new Date(createMeetingroomBookingDto.date)
      createMeetingroomBookingDto.start_time = new Date(createMeetingroomBookingDto.start_time)
      createMeetingroomBookingDto.end_time = new Date(createMeetingroomBookingDto.end_time)
      createMeetingroomBookingDto.status = true
      console.log('Check 2 ', createMeetingroomBookingDto)
      //get the room and floor details
      const meetingRoom = await this.meetingRoomService.findOne(createMeetingroomBookingDto.room_id)
      console.log(meetingRoom)
      const floor = await this.floorDetail.findOne(createMeetingroomBookingDto.floorId - 1)
      console.log(floor)
      const booking = this.repo.create(createMeetingroomBookingDto)
      console.log(booking)
      console.log('Check 3')
      //assign them to booking 
      booking.meetingRoom = meetingRoom
      if (floor) {
        booking.floorId = floor.floor_number
        booking.floor = floor
      }
      //add to meetign room booking table
      let b = await this.repo.save(booking)
      console.log('Check 3')
      //add to overall booking table
      let amenity = "Meeting Room"
      let bookingID = b.booking_id
      let details = [(createMeetingroomBookingDto.start_time).toISOString(), (createMeetingroomBookingDto.end_time).toISOString(), b.floorId.toString(), b.room_name, b.users.toString()]
      let overall_booking = { amenity: amenity, date: createMeetingroomBookingDto.date, bookingID: bookingID, token: createMeetingroomBookingDto.token, details: details }
      console.log('Check 4')
      //notification for that specific user (at the time of booked and a day before)
      let user = await this.userService.findOne(createMeetingroomBookingDto.token)
      let notification_row = {
        date: new Date(),
        title: 'Meeting Booked',
        message: (createMeetingroomBookingDto.start_time).toString(),
        token: user[0].firebaseToken
      }
      this.notificationService.createNotification(
        notification_row.date, notification_row.title, notification_row.message, notification_row.token
      )
      console.log('Check 5')

      console.log('Users for the meeting :::::: ', createMeetingroomBookingDto)

      // const date = createMeetingroomBookingDto.date;
      // date.setHours(createMeetingroomBookingDto.start_time.getHours());
      // date.setMinutes(createMeetingroomBookingDto.start_time.getMinutes());
      // date.setSeconds(createMeetingroomBookingDto.start_time.getSeconds());
      // date.setDate(createMeetingroomBookingDto.date.getDate())
      // date.setMilliseconds(0);

      const time = createMeetingroomBookingDto.start_time.toLocaleTimeString('en-US', { hour12: false })
      const date = createMeetingroomBookingDto.date.toISOString().split('T')[0];
      console.log(new Date(`${date}T${time}`))
      const upDate = new Date(`${date}T${time}`);

      console.log('83  ', upDate)
      // upDate.setDate(createMeetingroomBookingDto.date.getDate() - 1)
      console.log('85', upDate)
      notification_row.title = 'Upcoming Meeting'
      console.log('Upcoming Meeting time :::::::::::::::  ', notification_row)
      this.notificationService.createNotification(
        upDate, notification_row.title, notification_row.message, notification_row.token
      )
      console.log('Check 6')


      notification_row.title = 'Meeting is booked for You'
      //notifying other users for booking
      let booking_users = createMeetingroomBookingDto.users
      for (let i of booking_users) {
        user = await this.userService.findOne(i)
        if (user) {
          notification_row.token = user[0].firebaseToken
          this.notificationService.createNotification(
            notification_row.date, 'Meeting is booked for You', notification_row.message, notification_row.token
          )
          this.notificationService.createNotification(
            upDate, 'Upcoming : Meeting is booked for You', notification_row.message, notification_row.token
          )
        }
      }
      return this.overallBookingService.create({ ...overall_booking })
    } catch (er) {
      console.log(er)
      let user = await this.userService.findOne(createMeetingroomBookingDto.token)
      let notification_row = {
        date: new Date(),
        title: 'Meeting booking failed',
        message: 'Internal Server Error',
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

  //find booking by booking id
  async findOne(id: number) {
    let booking = await this.repo.findOne({ where: { booking_id: id } });
    if (!booking)
      throw new HttpException("Booking not found", HttpStatus.BAD_REQUEST)
    return booking
  }

  //find upcoming bookings of user
  async findByToken(token: string) {
    var now = new Date(new Date).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)
    let b = await this.repo.createQueryBuilder('booking')
      .andWhere('booking.date >= :date', { date: now1 })
      .getMany()
    let booking = []
    let user = await this.userService.findOne(token)
    let email = user[0].email
    for (let i of b) {
      if (i.token == token || i.users.includes(email))
        booking.push(i)
    }
    if (booking.length == 0)
      throw new HttpException("Booking not found", HttpStatus.BAD_REQUEST)
    return { "seatingData": booking }
  }

  //update booking
  async update(id: number, updateMeetingroomBookingDto: UpdateMeetingroomBookingDto) {
    let booking = await this.repo.findOne({ where: { booking_id: id } })
    let bookingID = booking?.booking_id
    let amenity = "Meeting Room"
    let overall_booking = await this.overallBookingService.findByBidAmenity(bookingID, amenity)

    //convert date to appropriate format
    if (updateMeetingroomBookingDto.date) {
      updateMeetingroomBookingDto.date = new Date(updateMeetingroomBookingDto.date)
      overall_booking[0].date = updateMeetingroomBookingDto.date
    }
    if (updateMeetingroomBookingDto.start_time) {
      updateMeetingroomBookingDto.start_time = new Date(updateMeetingroomBookingDto.start_time)
      overall_booking[0].details[0] = updateMeetingroomBookingDto.start_time.toISOString()
    }
    if (updateMeetingroomBookingDto.end_time) {
      updateMeetingroomBookingDto.end_time = new Date(updateMeetingroomBookingDto.end_time)
      overall_booking[0].details[1] = updateMeetingroomBookingDto.end_time.toISOString()
    }
    if (updateMeetingroomBookingDto.start_time && updateMeetingroomBookingDto.end_time)
      if (updateMeetingroomBookingDto.start_time >= updateMeetingroomBookingDto.end_time)
        throw new HttpException("Please enter valid start time and end time", HttpStatus.BAD_REQUEST)

    //add floor id
    if (updateMeetingroomBookingDto.floorId)
      overall_booking[0].details[2] = updateMeetingroomBookingDto.floorId.toString()

    //add room name
    if (updateMeetingroomBookingDto.room_name)
      overall_booking[0].details[3] = updateMeetingroomBookingDto.room_name

    //add users
    if (updateMeetingroomBookingDto.users)
      overall_booking[0].details[4] = updateMeetingroomBookingDto.users.toString()

    //update in meeting room booking table
    let updatedBooking = await this.repo.update(id, updateMeetingroomBookingDto)
    //update in overall booking table
    let b = await this.overallBookingService.updateMeetingRoom(id, overall_booking)
    return updatedBooking
  }

  remove(id: number) {
    //remove from mr booking and overall booking table
    let booking = this.repo.delete(id)
    return this.overallBookingService.deleteByID(id, "Meeting Room")
  }

  //get number of MRs available based on current date and time
  async getTotalAvailability() {
    let total_rooms = (await this.meetingRoomService.findAll()).length
    let date = moment.utc(new Date().toISOString());
    // console.log(date)
    const bookings_by_date = await this.repo.createQueryBuilder('booking')
      .where('(booking.start_time < :end_time AND booking.start_time >= :start_time)')
      .orWhere('(booking.end_time <= :end_time AND booking.start_time > :start_time)')
      .orWhere('(booking.start_time <= :end_time AND booking.end_time >= :start_time)')
      .setParameter('start_time', date)
      .setParameter('end_time', date)
      .getMany();
    console.log(bookings_by_date)
    return total_rooms - bookings_by_date.length
  }

  //get MRs available based on date, time and capacity
  async getAvailabilityByTime(getAvailability: GetAvailabilityDto) {
    var now = new Date(getAvailability.date).setUTCHours(0, 0, 0, 0)
    let now1 = new Date(now)
    if (getAvailability.start_time >= getAvailability.end_time)
      throw new HttpException("Please enter valid start time and end time", HttpStatus.BAD_REQUEST)

    //get rooms booked for current date and time
    const bookings_by_date = await this.repo.createQueryBuilder('booking')
      .where('(booking.start_time < :end_time AND booking.start_time >= :start_time)')
      .where('date = :date')
      .orWhere('(booking.end_time <= :end_time AND booking.start_time > :start_time)')
      .orWhere('(booking.start_time <= :end_time AND booking.end_time >= :start_time)')
      .setParameter('start_time', getAvailability.start_time)
      .setParameter('end_time', getAvailability.end_time)
      .setParameter('date', now1)
      .leftJoinAndSelect('booking.floor', 'floor')
      .getMany();

    //get all rooms which have capacity greater than input capacity
    const allRooms = await this.meetingRoomService.getRoomByCapacity(getAvailability.capacity)

    //filter for available rooms
    const available = allRooms.filter((all) => {
      return !bookings_by_date.some((item1) => item1.room_name === all.room_name)
    })
    return available
  }
}
