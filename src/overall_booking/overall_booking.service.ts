import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from '@nestjs/common';
import { CreateOverallBookingDto } from './dto/create-overall_booking.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { OverallBooking } from './entities/overall_booking.entity';
import { Repository } from 'typeorm';
import { UpdateCafeteriaBookingDto } from '../cafeteria_booking/dto/update-cafeteria_booking.dto';
import { EventsService } from '../events/events.service';
import { MeetingroomBookingService } from '../meetingroom_booking/meetingroom_booking.service';
import { SeatBookingService } from '../seat_booking/seat_booking.service';
import { CafeteriaBookingService } from '../cafeteria_booking/cafeteria_booking.service';

@Injectable()
export class OverallBookingService {

  constructor(@InjectRepository(OverallBooking) private readonly repo: Repository<OverallBooking>,
  private readonly eventService: EventsService,
  @Inject(forwardRef(()=>MeetingroomBookingService))
  private meetingRoomService: MeetingroomBookingService,
  @Inject(forwardRef(()=>SeatBookingService))
  private seatService: SeatBookingService,
  @Inject(forwardRef(()=>CafeteriaBookingService))
  private cafeteriaService: CafeteriaBookingService) {}

  add(createOverallBookingDto: CreateOverallBookingDto) {
    return 'This action adds a new overallBooking';
  }

  findAll() {
    return `This action returns all overallBooking`;
  }

  findOne(id: number) {
    return `This action returns a #${id} overallBooking`;
  }

  async update(id: number, updateOverallBookingDto: UpdateCafeteriaBookingDto, amenity: string) {

    //get booking based on booking id and amenity
    let overall_booking=await this.repo.find({where: {bookingID: id, amenity: amenity}})
    // console.log(overall_booking)
    if(overall_booking)
    {
      if(updateOverallBookingDto.date){
        // updateOverallBookingDto.date=new Date()
        overall_booking[0].date=new Date(updateOverallBookingDto.date)
      }
      if(updateOverallBookingDto.start_time && updateOverallBookingDto.end_time){
        if(updateOverallBookingDto.start_time<updateOverallBookingDto.end_time){
          updateOverallBookingDto.end_time=new Date(updateOverallBookingDto.end_time)
          updateOverallBookingDto.start_time=new Date(updateOverallBookingDto.start_time)
          //convert time to ISOString to store in details[]
          overall_booking[0].details[0]=(updateOverallBookingDto.start_time).toISOString()
          overall_booking[0].details[1]=(updateOverallBookingDto.end_time).toISOString()
        } 
        else throw new HttpException("start time should be less than end time", HttpStatus.BAD_REQUEST)
      }
      overall_booking[0].amenity=amenity
      //update in table
      let b=await this.repo.save(overall_booking[0])
      return b
    }
  }

  remove(id: number){

  }

  async deleteByID(id: number, amenity: string) {
    let overall=await this.repo.find({where: {bookingID: id, amenity: amenity}})
    let overall_id=overall[0].id
    let booking=await this.repo.delete(overall_id)
    return booking
  }

  create(booking: { amenity: string; bookingID: number; date: Date; details: string[]; token: string; }){
    return this.repo.save(booking)
  }

  findByBidAmenity(id: number | undefined, amenity: string){
    return this.repo.find({where: {bookingID: id, amenity: amenity}})
  }

  updateMeetingRoom(id: number, updatedBooking: OverallBooking[]){
    return this.repo.save(updatedBooking[0])
  }

  async getAllBookingsByToken(token: string){
    var now=new Date(new Date().setUTCHours(0,0,0,0))
    let booking=this.repo.createQueryBuilder('overall_booking')
    .where('overall_booking.token = :token', {token})
    .andWhere('overall_booking.date >= :now', {now})
    .getMany()
    if((await booking).length==0)
      return []
    // console.log(booking)
    return booking
  }

  async homescreenAPI(token: string){
    //get all bookings made by an user
    let overall_booking=await this.getAllBookingsByToken(token)

    //get all upcoming events
    let events=await this.eventService.findByDate()

    //get count of available MRs, seats and cafeteria seats
    let meetingRoomCount=await this.meetingRoomService.getTotalAvailability()
    let seatsCount=await this.seatService.getAvailDate()
    let cafeteriaCount=await this.cafeteriaService.getAvailDate()
    return {'Overall_Booking': overall_booking, 'events': events, "Meeting Room": meetingRoomCount, "Seats": seatsCount, "Cafeteria": cafeteriaCount}
  }
}
