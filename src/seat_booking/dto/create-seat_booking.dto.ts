import { ApiProperty } from "@nestjs/swagger";

export class CreateSeatBookingDto {
    @ApiProperty()
    date: Date

    @ApiProperty()
    floor_number: number

    @ApiProperty()
    users?: string[]

    @ApiProperty()
    token: string

    @ApiProperty()
    capacity: number

    @ApiProperty()
    seat_no?: string[]

    @ApiProperty()
    status: boolean
}
