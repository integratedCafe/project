import { Schema, model } from 'mongoose';

export type TNotification = {
    userId: Schema.Types.ObjectId;
    title: string;
    content: string;
    date: Date;
};

/**
 *
 * TNotification
 * @param userId: Schema.Types.ObjectId;
 * @param title: string;
 * @param content: string;
 * @param date: Date;
 */

export interface INotification extends TNotification {}

const NotificationSchema: Schema = new Schema<INotification>({
    userId: { type: Schema.Types.ObjectId, ref: 'user', required: true },
    title: { type: String, required: true },
    content: { type: String, required: true },
    date: { type: Date, default: Date.now(), required: true },
});

const Notification = model<INotification>('notification', NotificationSchema);

export default Notification;
