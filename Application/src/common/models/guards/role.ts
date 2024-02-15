import { Admin, User } from '@common/database/entities';
import { Role } from '@common/enums';

export interface IRoleBody extends Admin, User {
  role: Role;
}
