import { Schema, model } from 'mongoose';

export type TCafe = {
    menus?: Schema.Types.ObjectId[];
    location: string;
    name: string;
    ownerId: Schema.Types.ObjectId;
    orderCnt: number;
    brNumber: string;
    phone: string;
    brandId?: string;
    image?: string;
    description?: string;
    createdAt: Date;
    updatedAt?: Date;
    breakTime?: { start: string; end: string };
    openHour?: { start: string; end: string };
    dayOffWeek?: number[];
};

/**
 *
 * TCafe
 * @param menus?: Schema.Types.ObjectId[];
 * @param location: string;
 * @param name: string;
 * @param ownerId: Schema.Types.ObjectId;
 * @param orderCnt: number;
 * @param brNumber: string;
 * @param phone: string;
 * @param brandId?: string;
 * @param image?: string;
 * @param description?: string;
 * @param createdAt: Date;
 * @param updatedAt?: Date;
 * @param breakTime?: { start: string, end: string };
 * @param openHour?: { start: string, end: string };
 * @param dayOffWeek: number[];
 */

export interface ICafe extends TCafe {}

const CafeSchema: Schema = new Schema<ICafe>({
    name: { type: String, required: true },
    location: { type: String, required: true },
    orderCnt: { type: Number, required: true, default: 0 },
    brNumber: { type: String, required: true },
    phone: { type: String, required: true },
    menus: [{ type: Schema.Types.ObjectId, ref: 'menu' }],
    ownerId: { type: Schema.Types.ObjectId, ref: 'user', required: true },
    brandId: { type: String },
    image: { type: String },
    description: { type: String },
    createdAt: { type: Date, default: Date.now(), required: true },
    updatedAt: { type: Date, default: Date.now() },
    breakTime: { start: { type: String }, end: { type: String } },
    openHour: { start: { type: String }, end: { type: String } },
    dayOffWeek: { type: [Number] },
});

const Cafe = model<ICafe>('cafe', CafeSchema);

export default Cafe;
