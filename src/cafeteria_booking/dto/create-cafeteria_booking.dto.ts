import { ApiProperty } from "@nestjs/swagger";

export class CreateCafeteriaBookingDto {
    @ApiProperty()
    token: string

    @ApiProperty()
    date: Date

    @ApiProperty()
    start_time: Date

    @ApiProperty()
    end_time: Date
}
