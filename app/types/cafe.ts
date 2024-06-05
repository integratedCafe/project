interface CafeType {
    ownerId: string;
    name: string;
    location: { lat: string; lng: string };
    image: string;
    phone: string;
    brNumber: string;
    description: string;
    breakTime: { start: string; end: string };
    openHour: { start: string; end: string };
    dayOffWeek: number[];
}

export { CafeType };
