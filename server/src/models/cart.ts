import { Schema, model } from 'mongoose';

export type TCart = {
    userId: Schema.Types.ObjectId;
    cafeId: Schema.Types.ObjectId;
    items: { quantity: number; menuId: Schema.Types.ObjectId }[];
};

/**
 *
 * TCart
 * @param userId: Schema.Types.ObjectId;
 * @param cafeId: Schema.Types.ObjectId;
 * @param items: { quantity: number; menuId: Schema.Types.ObjectId; }[];
 */

export interface ICart extends TCart {}

const CartSchema: Schema = new Schema<ICart>({
    userId: { type: Schema.Types.ObjectId, ref: 'user', required: true },
    cafeId: { type: Schema.Types.ObjectId, ref: 'cafe', required: true },
    items: [
        {
            menuId: { type: Schema.Types.ObjectId, ref: 'menu' },
            quantity: { type: Number },
        },
    ],
});

const Cart = model<ICart>('cart', CartSchema);

export default Cart;
