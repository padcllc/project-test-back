import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDTO } from './dto/create-user.dto';
import { IdDTO } from '@common/dtos';
import { RolesGuard } from '@common/guards';
import { Role } from '@common/enums';

@UseGuards(RolesGuard(Role.ADMIN))
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  create(@Body() body: CreateUserDTO) {
    return this.userService.create(body);
  }

  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @Get('/:id')
  findOne(@Param() param: IdDTO) {
    return this.userService.findOne(param.id);
  }

  @Delete('/:id')
  remove(@Param() param: IdDTO) {
    return this.userService.remove(param.id);
  }
}
