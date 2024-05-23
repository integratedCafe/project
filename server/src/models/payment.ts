import { Schema, model } from 'mongoose';

export type TPayment = {
    userId: Schema.Types.ObjectId;
    orderId: Schema.Types.ObjectId;
    tool: string;
    date: Date;
    creditApprovalNumber: string;
    cardType: string;
    cardNumber: string;
    installment: number;
    amount: number;
    isCanceled: boolean;
    cancelDate: Date;
    status: string;
    createdAt: Date;
    updatedAt: Date;
    remark: string;
};

/**
 *
 * TPayment
 * @param userId: Schema.Types.ObjectId;
 * @param orderId: Schema.Types.ObjectId;
 * @param tool: string;
 * @param date: Date;
 * @param creditApprovalNumber: string;
 * @param cardType: string;
 * @param cardNumber: string;
 * @param installment: number;
 * @param amount: number;
 * @param isCanceled: boolean;
 * @param cancelDate: Date;
 * @param status: string;
 * @param createdAt: Date;
 * @param updatedAt: Date;
 * @param remark: string;
 */

export interface IPayment extends TPayment {}

const PaymentSchema: Schema = new Schema<IPayment>({
    userId: { type: Schema.Types.ObjectId, required: true },
    orderId: { type: Schema.Types.ObjectId, required: true },
    tool: { type: String, required: true },
    date: { type: Date, default: Date.now(), required: true },
    creditApprovalNumber: { type: String, required: true },
    cardType: { type: String, required: true },
    cardNumber: { type: String, required: true },
    installment: { type: Number, required: true, default: 0 },
    amount: { type: Number, required: true, default: 0 },
    isCanceled: { type: Boolean, required: true, default: false },
    cancelDate: { type: Date, required: true },
    status: {
        type: String,
        enum: ['Pending', 'Completed', 'Failed'],
        required: true,
        default: 'Pending',
    },
    createdAt: { type: Date, required: true, default: Date.now() },
    updatedAt: { type: Date, required: true },
    remark: { type: String, required: true },
});

const Payment = model<IPayment>('payment', PaymentSchema);

export default Payment;
