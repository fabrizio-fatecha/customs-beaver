import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';

@Injectable()
export class AppService {
  constructor(private prisma: PrismaService) {}

  async getSyncData() {
    try {
      return await this.prisma.nomenclatura_ncm.findMany({
        orderBy: {
          id: 'asc',
        },
      });
    } catch (error) {
      throw new Error('Error al obtener los datos de nomenclatura: ' + error.message);
    }
  }
}