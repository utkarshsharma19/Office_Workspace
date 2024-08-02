import { User } from 'src/user/entities/user.entity';
import { Entity, PrimaryGeneratedColumn, Column, Unique, ManyToOne, OneToMany } from 'typeorm';

@Entity()
@Unique('composite-key', ['bookingID', 'amenity'])
export class OverallBooking {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  token: string;

  @Column()
  amenity: string;

  @Column()
  bookingID: number;

  @Column()
  date: Date;

  @Column('text', { array: true })
  details: string[];
}