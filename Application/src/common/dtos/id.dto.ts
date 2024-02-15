import { IsInt, IsNotEmpty, IsOptional } from 'class-validator';
import { Type } from 'class-transformer';

export class IdDTO {
  @IsNotEmpty()
  @IsInt()
  @Type(() => Number)
  id: number;
}

export class IdOptionalDTO {
  @IsOptional()
  @IsInt()
  @Type(() => Number)
  id?: number;
}
