import { PartialType } from '@nestjs/swagger';
import { CreateOverallBookingDto } from './create-overall_booking.dto';

export class UpdateOverallBookingDto extends PartialType(CreateOverallBookingDto) {}
