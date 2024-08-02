import { FloorDetail } from "../../floor_details/entities/floor_detail.entity";
import { MeetingroomBooking } from "../../meetingroom_booking/entities/meetingroom_booking.entity";
import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class MeetingroomDetail {
    @PrimaryGeneratedColumn()
    room_id: number

    @Column()
    room_name: string

    @Column()
    floorId: number

    @ManyToOne(()=>FloorDetail, floor=>floor.meetingRoom)
    floor: FloorDetail

    @Column()
    capacity: number

    @OneToMany(()=>MeetingroomBooking, booking=>booking.meetingRoom)
    meetingroomBooking: MeetingroomBooking[]
}
