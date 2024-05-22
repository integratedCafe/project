import { Schema, model } from 'mongoose';

export type TOrder = {
    userId: Schema.Types.ObjectId;
    cafeId: Schema.Types.ObjectId;
    menus: { cnt: number; menu: Schema.Types.ObjectId };
    totalPrice: number;
    status: string;
    payment: Schema.Types.ObjectId;
};

/**
 *
 * TOrder
 * @param userId: Schema.Types.ObjectId;
 * @param cafeId: Schema.Types.ObjectId;
 * @param menus: { cnt: number; menu: Schema.Types.ObjectId};
 * @param totalPrice: number;
 * @param status: string;
 * @param payment: Schema.Types.ObjectId;
 */

export interface IOrder extends TOrder {}

const OrderSchema: Schema = new Schema<IOrder>({
    totalPrice: { type: Number, default: 0, required: true },
    status: {
        type: String,
        enum: ['basket', 'checking', 'proceeding', 'complete'],
        default: 'basket',
        required: true,
    },
    userId: { type: Schema.Types.ObjectId, ref: 'user', required: true },
    payment: { type: Schema.Types.ObjectId, ref: 'payment' },
    cafeId: { type: Schema.Types.ObjectId, ref: 'cafe', required: true },
    menus: [
        {
            menuId: { type: Schema.Types.ObjectId, ref: 'menu' },
            cnt: { type: Number },
        },
    ],
});

const Order = model<IOrder>('order', OrderSchema);

export default Order;
