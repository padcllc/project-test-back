import { IsPhoneNumberOrEmail } from '@common/decorators';

import { ApiProperty } from '@nestjs/swagger';
import { IsString, MinLength, MaxLength, IsNotEmpty } from 'class-validator';

export class LoginDTO {
  @IsPhoneNumberOrEmail({
    message: 'Login should be an email or phone',
  })
  @IsNotEmpty()
  @ApiProperty()
  login: string;

  @IsString()
  @MinLength(8)
  @MaxLength(60)
  @IsNotEmpty()
  @ApiProperty()
  password: string;
}
