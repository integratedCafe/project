import { Schema, model } from 'mongoose';

export type TCafe = {
    menus: Schema.Types.ObjectId[];
    location: string;
    name: string;
    ownerId: Schema.Types.ObjectId;
    orderCnt: number;
    brNumber: string;
    phone: string;
    brandId: string;
    image: string;
    description: string;
    createdAt: Date;
    updatedAt: Date;
    breakTime: { start: Date; end: Date };
    openHour: { start: Date; end: Date };
    dayOffWeek: number[];
    dayOff: boolean;
};

/**
 *
 * TCafe
 * @param menus: Schema.Types.ObjectId[];
 * @param location: string;
 * @param name: string;
 * @param ownerId: Schema.Types.ObjectId;
 * @param orderCnt: number;
 * @param brNumber: string;
 * @param phone: string;
 * @param brandId: string;
 * @param image: string;
 * @param description: string;
 * @param createdAt: Date;
 * @param updatedAt: Date;
 * @param breakTime: { start: Date, end: Date };
 * @param openHour: { start: Date, end: Date };
 * @param dayOffWeek: number[];
 * @param dayOff: boolean;
 */

export interface ICafe extends TCafe {}

const CafeSchema: Schema = new Schema<ICafe>({
    name: { type: String, required: true },
    location: { type: String, required: true },
    orderCnt: { type: Number, required: true, default: 0 },
    brNumber: { type: String, required: true },
    phone: { type: String, required: true },
    menus: [{ type: Schema.Types.ObjectId, ref: 'menu' }],
    ownerId: { type: Schema.Types.ObjectId, ref: 'user' },
    brandId: { type: String, required: true },
    image: { type: String },
    description: { type: String },
    createdAt: { type: Date, default: Date.now() },
    updatedAt: { type: Date },
    breakTime: { start: { type: Date }, end: { type: Date } },
    openHour: { start: { type: Date }, end: { type: Date } },
    dayOffWeek: { type: [Number] },
});

const Cafe = model<ICafe>('cafe', CafeSchema);

export default Cafe;
