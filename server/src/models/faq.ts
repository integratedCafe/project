import { Schema, model } from 'mongoose';

export type TFaq = {
    title: string;
    content: string;
    date: Date;
};

/**
 *
 * TFaq
 * @param title: string;
 * @param content: string;
 * @param date: Date;
 */

export interface IFaq extends TFaq {}

const FaqSchema: Schema = new Schema<IFaq>({
    title: { type: String, required: true },
    content: { type: String, required: true },
    date: { type: Date, required: true, default: Date.now() },
});

const Faq = model<IFaq>('faq', FaqSchema);

export default Faq;
