import { Schema, model } from 'mongoose';

export type TCafe = {
    menus: Schema.Types.ObjectId[];
    location: string;
    name: string;
    ownerId: Schema.Types.ObjectId;
    orderCnt: number;
    brNumber: string;
    phone: string;
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
 */

export interface ICafe extends TCafe {}

const CafeSchema: Schema = new Schema<ICafe>({
    name: {
        type: String,
        required: true,
    },
    location: {
        type: String,
        required: true,
    },
    orderCnt: {
        type: Number,
        required: true,
        default: 0,
    },
    brNumber: {
        type: String,
        required: true,
    },
    phone: {
        type: String,
        required: true,
    },
    menus: [{ type: Schema.Types.ObjectId, ref: 'menu' }],
    ownerId: { type: Schema.Types.ObjectId, ref: 'user' },
});

const Cafe = model<ICafe>('cafe', CafeSchema);

export default Cafe;
