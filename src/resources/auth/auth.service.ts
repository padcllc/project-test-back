import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Admin, User } from '@common/database/entities';
import { Repository } from 'typeorm';
import { IAccessToken, ILogin } from '@common/models';
import { buildResponse } from '@common/helpers';
import { ERROR_MESSAGES } from '@common/messages';
import * as bcrypt from 'bcrypt';
import { Role } from '@common/enums';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(Admin)
    private readonly _adminRepository: Repository<Admin>,

    @InjectRepository(User)
    private readonly _userRepository: Repository<User>,

    private jwtService: JwtService,
  ) {}

  public async login(body: ILogin): Promise<IAccessToken> {
    const { login, password } = body;

    let user: User | undefined;
    let role: Role;

    const admin = await this._adminRepository.findOne({
      where: [{ phone: login }, { email: login }],
    });

    if (admin) {
      user = admin;
      role = Role.ADMIN;
    } else {
      user = await this._userRepository.findOne({
        where: [{ phone: login }, { email: login }],
      });

      if (!user || !bcrypt.compareSync(password, user.password)) {
        throw buildResponse(false, null, ERROR_MESSAGES.USER_NOT_EXISTS);
      }

      role = Role.USER;
    }

    if (!bcrypt.compareSync(password, user.password)) {
      throw buildResponse(false, null, ERROR_MESSAGES.USER_NOT_EXISTS);
    }

    const payload = { id: user.id, role };
    const accessToken = this.jwtService.sign(payload, {
      secret: process.env.PRIMARY_JWT_SECRET,
    });

    return buildResponse(true, { accessToken });
  }
}
