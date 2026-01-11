import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaService } from './prisma/prisma.service';
import { PassportModule } from '@nestjs/passport';
import { BasicStrategy } from './strategies/basic.strategy';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [PassportModule, ConfigModule.forRoot({isGlobal: true}),],
  controllers: [AppController],
  providers: [AppService, PrismaService,BasicStrategy],
})
export class AppModule {}
