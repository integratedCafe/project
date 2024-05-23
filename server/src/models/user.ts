import { Schema, model } from 'mongoose';

export type TUser = {
    name: string;
    nickname: string;
    email?: string;
    password: string;
    phone: string;
    loginWay: string;
    marketing?: boolean;
    appPush?: boolean;
    locAgreement?: boolean;
    isOwner?: boolean;
    freqCafes?: Schema.Types.ObjectId[];
    likedCafes?: Schema.Types.ObjectId[];
    cart?: Schema.Types.ObjectId;
    orders?: Schema.Types.ObjectId[];
    likedMenus?: Schema.Types.ObjectId[];
    notifications: Schema.Types.ObjectId[];
};

/**
 *
 * TUser
 * @param name: string;
 * @param nickname: string;
 * @param email?: string;
 * @param password: string;
 * @param phone: string;
 * @param loginWay: string;
 * @param marketing?: boolean;
 * @param appPush?: boolean;
 * @param locAgreement?: boolean;
 * @param isOwner?: boolean;
 * @param freqCafes?: Schema.Types.ObjectId;
 * @param likedCafes?: Schema.Types.ObjectId;
 * @param cart?: Schema.Types.ObjectId;
 * @param orders?: Schema.Types.ObjectId;
 * @param likedMenus?: Schema.Types.ObjectId;
 * @param notifications: Schema.Types.ObjectId[];
 */

export interface IUser extends TUser {}

const UserSchema: Schema = new Schema<IUser>({
    name: { type: String, required: true, unique: true },
    nickname: { type: String, required: true },
    email: { type: String, unique: true },
    password: { type: String, required: true },
    phone: { type: String, required: true, unique: true },
    loginWay: {
        type: String,
        enum: ['phone', 'kakao', 'google', 'apple', 'naver'],
        default: 'phone',
    },
    marketing: { type: Boolean, default: false },
    appPush: { type: Boolean, default: false },
    locAgreement: { type: Boolean, default: false },
    isOwner: { type: Boolean, default: false },
    freqCafes: [{ type: Schema.Types.ObjectId, ref: 'cafe' }],
    likedCafes: [{ type: Schema.Types.ObjectId, ref: 'cafe' }],
    cart: { type: Schema.Types.ObjectId, ref: 'cart' },
    orders: [{ type: Schema.Types.ObjectId, ref: 'order' }],
    likedMenus: [{ type: Schema.Types.ObjectId, ref: 'menu' }],
    notifications: [{ type: Schema.Types.ObjectId, ref: 'notification' }],
});

const User = model<IUser>('user', UserSchema);

export default User;
