import { ApiProperty } from "@nestjs/swagger"

export class UpdateMeetingroomBookingDto {
    @ApiProperty()
    meetingRoomRoomId?: number

    @ApiProperty()
    room_name?: string

    @ApiProperty()
    date?: Date

    @ApiProperty()
    start_time?: Date

    @ApiProperty()
    end_time?: Date

    @ApiProperty()
    floorId?: number

    @ApiProperty()
    users?: string[]
}
