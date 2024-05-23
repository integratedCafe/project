import { Schema, model } from 'mongoose';

export type TNotice = {
    title: string;
    content: string;
    date: Date;
};

/**
 *
 * TNotice
 * @param title: string;
 * @param content: string;
 * @param date: Date;
 */

export interface INotice extends TNotice {}

const NoticeSchema: Schema = new Schema<INotice>({
    title: { type: String, required: true },
    content: { type: String, required: true },
    date: { type: Date, default: Date.now(), required: true },
});

const Notice = model<INotice>('notice', NoticeSchema);

export default Notice;
