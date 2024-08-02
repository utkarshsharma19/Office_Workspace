import { Module } from '@nestjs/common';
import { MeetingroomDetailsService } from './meetingroom_details.service';
import { MeetingroomDetailsController } from './meetingroom_details.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MeetingroomDetail } from './entities/meetingroom_detail.entity';

@Module({
  controllers: [MeetingroomDetailsController],
  providers: [MeetingroomDetailsService],
  imports: [TypeOrmModule.forFeature([MeetingroomDetail])],
  exports: [MeetingroomDetailsService]
})
export class MeetingroomDetailsModule {}
