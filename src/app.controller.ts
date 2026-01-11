import { Controller, Get, UseInterceptors, ClassSerializerInterceptor, UseGuards, Logger } from '@nestjs/common';
import { AppService } from './app.service';
import { BasicAuthGuard } from './guards/basic-auth.guard';

@Controller('sync')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('download-db')
  @UseGuards(BasicAuthGuard)
  async downloadDb() {
    const data = await this.appService.getSyncData();
    return {
      count: data.length,
      timestamp: new Date().toISOString(),
      data: data,
    };
  }
}