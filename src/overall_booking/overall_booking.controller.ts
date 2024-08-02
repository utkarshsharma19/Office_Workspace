import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { OverallBookingService } from './overall_booking.service';
import { CreateOverallBookingDto } from './dto/create-overall_booking.dto';
import { ApiTags } from '@nestjs/swagger';
import { UpdateCafeteriaBookingDto } from '../cafeteria_booking/dto/update-cafeteria_booking.dto';

@ApiTags('Overall Booking')
@Controller('overall-booking')
export class OverallBookingController {
  constructor(private readonly overallBookingService: OverallBookingService) {}

  @Post()
  create(@Body() createOverallBookingDto: CreateOverallBookingDto) {
    return this.overallBookingService.add(createOverallBookingDto);
  }

  @Get()
  findAll() {
    return this.overallBookingService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.overallBookingService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateOverallBookingDto: UpdateCafeteriaBookingDto, amenity: string) {
    return this.overallBookingService.update(+id, updateOverallBookingDto, amenity);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.overallBookingService.remove(+id);
  }

  @Get('homescreen_api/:token')
  homescreenAPI(@Param('token') token: string){
    return this.overallBookingService.homescreenAPI(token)
  }
}
