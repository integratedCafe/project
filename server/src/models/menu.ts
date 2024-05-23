import { Schema, model } from 'mongoose';

interface IMenuOption {
    id: string;
    name: string;
    price: number;
}

export type TMenu = {
    cafeId: Schema.Types.ObjectId;
    name: string;
    price: number;
    image: string;
    options: IMenuOption[];
    createdAt: Date;
    updatedAt: Date;
    description: string;
};

/**
 *
 * TMenu
 * @param cafeId: Schema.Types.ObjectId;
 * @param name: string;
 * @param price: number;
 * @param image: string;
 * @param options: IMenuOption[];
 * @param createdAt: Date;
 * @param updatedAt: Date;
 * @param description: string;
 */

export interface IMenu extends TMenu {}

const MenuSchema: Schema = new Schema<IMenu>({
    name: { type: String, required: true },
    cafeId: { type: Schema.Types.ObjectId, ref: 'cafe' },
    price: { type: Number, required: true, default: 0 },
    image: { type: String },
    options: [
        {
            id: { type: String },
            name: { type: String, required: true },
            price: { type: Number, required: true, default: 0 },
        },
    ],
    createdAt: { type: Date, default: Date.now() },
    updatedAt: { type: Date },
    description: { type: String },
});

const Menu = model<IMenu>('menu', MenuSchema);

export default Menu;
