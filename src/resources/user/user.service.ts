import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '@common/database/entities';
import { Repository } from 'typeorm';
import { ISuccess, IUser } from '@common/models';
import { buildResponse } from '@common/helpers';
import { ERROR_MESSAGES } from '@common/messages';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly _userRepository: Repository<User>,
  ) {}

  public async create(body: IUser): Promise<ISuccess> {
    const user = await this._userRepository.findOne({
      where: [{ email: body.email }, { phone: body.phone }],
    });

    if (user) {
      throw buildResponse(false, null, ERROR_MESSAGES.USER_ALREADY_EXISTS);
    }

    await this._userRepository.save({
      ...body,
      password: await bcrypt.hash(body.password, 10),
    });

    return buildResponse(true, {
      success: true,
    });
  }

  public async findAll(): Promise<User[]> {
    const users = await this._userRepository.find();
    return buildResponse(true, users);
  }

  public async findOne(id: number): Promise<User> {
    const user = await this._userRepository.findOne({
      where: { id },
    });

    if (!user) {
      throw buildResponse(false, null, ERROR_MESSAGES.USER_NOT_EXISTS);
    }

    return buildResponse(true, user);
  }

  public async remove(id: number): Promise<ISuccess> {
    const user = await this._userRepository.findOne({
      where: { id },
    });

    if (!user) {
      throw buildResponse(false, null, ERROR_MESSAGES.USER_NOT_EXISTS);
    }

    await this._userRepository.delete(id);

    return buildResponse(true, {
      success: true,
    });
  }
}
