import { JwtService } from '@nestjs/jwt';
import { Role } from '@common/enums';
import { IRoleBody } from '@common/models';
import {
  CanActivate,
  ExecutionContext,
  Injectable,
  mixin,
} from '@nestjs/common';
import { AuthUserGuard } from '@common/guards/auth.guard';

export const RolesGuard = (roles: Role | Role[]) => {
  @Injectable()
  class RolesGuardMixin extends AuthUserGuard implements CanActivate {
    constructor(public _jwtService: JwtService) {
      super(_jwtService);
    }

    async canActivate(context: ExecutionContext): Promise<boolean> {
      await super.canActivate(context);
      const requiredRoles = roles;
      if (!requiredRoles) {
        return true;
      }
      const { user } = context.switchToHttp().getRequest();
      if (Array.isArray(requiredRoles)) {
        return requiredRoles.some(
          (role: Role) => (user as IRoleBody).role === role,
        );
      } else {
        return (user as IRoleBody).role === requiredRoles;
      }
    }
  }

  return mixin(RolesGuardMixin);
};
