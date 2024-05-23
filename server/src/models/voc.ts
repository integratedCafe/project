import { Schema, model } from 'mongoose';

export type TVoc = {
    userId: Schema.Types.ObjectId;
    title: string;
    content: string;
    answerTitle: string;
    answerContent: string;
};

/**
 *
 * TVoc
 * @param userId: Schema.Types.ObjectId;
 * @param title: string;
 * @param content: string;
 * @param answerTitle: string;
 * @param answerContent: string;
 */

export interface IVoc extends TVoc {}

const VocSchema: Schema = new Schema<IVoc>({
    userId: { type: Schema.Types.ObjectId, ref: 'user', required: true },
    title: { type: String, required: true },
    content: { type: String, required: true },
    answerTitle: { type: String },
    answerContent: { type: String },
});

const Voc = model<IVoc>('voc', VocSchema);

export default Voc;
