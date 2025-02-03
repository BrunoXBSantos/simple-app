import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Dotmoovs Interview - Simple App is running!';
  }
}
