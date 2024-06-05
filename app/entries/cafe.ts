import { CafeType } from '@/types/cafe';

const initCafe: CafeType = {
    ownerId: '',
    name: '',
    location: { lat: '37.564214', lng: '127.001699' },
    image: '',
    phone: '',
    brNumber: '',
    description: '',
    breakTime: { start: '00:00', end: '00:00' },
    openHour: { start: '00:00', end: '00:00' },
    dayOffWeek: [],
};

export { initCafe };
