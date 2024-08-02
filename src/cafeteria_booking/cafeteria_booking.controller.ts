import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { CafeteriaBookingService } from './cafeteria_booking.service';
import { CreateCafeteriaBookingDto } from './dto/create-cafeteria_booking.dto';
import { UpdateCafeteriaBookingDto } from './dto/update-cafeteria_booking.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { GetAvailaBilityDto } from './dto/get-availability.dto';
import { AccessTokenGuard } from '../auth/access-token-guard';

@ApiTags('Cafeteria Booking')
@ApiBearerAuth('access-token')
@UseGuards(AccessTokenGuard)
@Controller('cafeteria-booking')

export class CafeteriaBookingController {
  constructor(private readonly cafeteriaBookingService: CafeteriaBookingService) {}

  @Post()
  create(@Body() createCafeteriaBookingDto: CreateCafeteriaBookingDto) {
    return this.cafeteriaBookingService.create(createCafeteriaBookingDto);
  }

  @Get()
  findAll() {
    return this.cafeteriaBookingService.findAll();
  }

  //get by booking id
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.cafeteriaBookingService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCafeteriaBookingDto: UpdateCafeteriaBookingDto) {
    return this.cafeteriaBookingService.update(+id, updateCafeteriaBookingDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.cafeteriaBookingService.remove(+id);
  }

  //get availability by date
  @Get('total_availability/date')
  getAvailDate(){
    return this.cafeteriaBookingService.getAvailDate()
  }

  //get booking by token
  @Get('booking/:token')
  getByToken(@Param('token') token: string){
    return this.cafeteriaBookingService.getByToken(token)
  }

  //get availability based on date, start time and end time
  @Post('availability/datetime')
  getAvailDateTime(@Body() getavailability: GetAvailaBilityDto){
    return this.cafeteriaBookingService.getAvailDateTime(getavailability)
  }
}
