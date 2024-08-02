// auth.controller.ts
import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginUserDTO } from '../user/dto/login-user.dto';
import { ApiTags } from '@nestjs/swagger';
import { UserService } from '../user/user.service';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService, private readonly userService: UserService) { }

  @Post('login')
  async login(@Body() loginDto: LoginUserDTO) {
    const user = await this.authService.validateUser(loginDto);
    // console.log(user)
    const token = await this.authService.login(user);
    // console.log(token)
    console.log('Firebase Token recieved :: ' + loginDto.firebaseToken)
    const add = await this.userService.addToken(user.email, token.access_token, loginDto.firebaseToken)
    const { password, ...u } = add[0]
    console.log("in controller", u)
    return u;
  }
}
