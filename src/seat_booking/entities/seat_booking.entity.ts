import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { User } from '../../user/entities/user.entity';
import { FloorDetail } from '../../floor_details/entities/floor_detail.entity';

@Entity()
export class SeatBooking {
  @PrimaryGeneratedColumn()
  booking_id: number;

  @Column({type: 'varchar'})
  token: string;

  @Column()
  floor_number: number;

  @ManyToOne(() => FloorDetail, (floor) => floor.seatBooking, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'floor_number' })
  floor: FloorDetail;

  @Column()
  status: boolean;

  @Column({ type: 'timestamptz' })
  date: Date;

  @Column('varchar', { array: true })
  seat_no: string[];

  @Column('varchar', {array: true})
  users: string[]
}