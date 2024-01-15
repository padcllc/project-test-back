import { Body, Controller, Post } from '@nestjs/common';

import { ApiTags } from '@nestjs/swagger';

import { AuthService } from './auth.service';
import { LoginDTO } from './dto';

@ApiTags('Authentication management')
@Controller('auth')
export class AuthController {
  constructor(private readonly _authService: AuthService) {}

  @Post('login')
  login(@Body() body: LoginDTO) {
    return this._authService.login(body);
  }
}
