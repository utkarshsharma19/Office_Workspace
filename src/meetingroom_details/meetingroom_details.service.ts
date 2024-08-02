import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateMeetingroomDetailDto } from './dto/create-meetingroom_detail.dto';
import { UpdateMeetingroomDetailDto } from './dto/update-meetingroom_detail.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { MeetingroomDetail } from './entities/meetingroom_detail.entity';
import { Repository } from 'typeorm';

@Injectable()
export class MeetingroomDetailsService {

  constructor(@InjectRepository(MeetingroomDetail) private readonly repo: Repository<MeetingroomDetail>) { }

  create(createMeetingroomDetailDto: CreateMeetingroomDetailDto) {
    return this.repo.save(createMeetingroomDetailDto);
  }

  findAll() {
    return this.repo.find();
  }

  async findOne(id: number) {
    console.log('finding 22 ', id)
    let room = await this.repo.findOne({ where: { room_id: id } });
    console.log('finding 24', room)
    if (!room)
      throw new HttpException("Room does not exist", HttpStatus.BAD_REQUEST)
    return room
  }

  update(id: number, updateMeetingroomDetailDto: UpdateMeetingroomDetailDto) {
    return this.repo.update(id, updateMeetingroomDetailDto);
  }

  remove(id: number) {
    return this.repo.delete(id);
  }

  //get rooms which have capacity greater than input capacity
  getRoomByCapacity(capacity: number) {
    return this.repo.createQueryBuilder('room')
      .where('room.capacity >= :capacity', { capacity })
      // .leftJoinAndSelect('room.floor_number', 'floor_number')
      .getMany()
  }

  getFloor(roomName: string) {
    return this.repo.find({ where: { room_name: roomName }, relations: ['floor_number'] })
  }

  //get room id based on room name
  async getRoomID(roomName: string) {
    let room = await this.repo.find({ where: { room_name: roomName } })
    console.log(room[0].room_id)
    return room[0].room_id
  }
}
