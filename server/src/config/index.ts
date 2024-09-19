import dotenv from "dotenv";

dotenv.config();

const env = {
    MONGO_URI: process.env.MONGO_URI!,
    PORT: process.env.PORT!,
    JWT_SECRET: process.env.JWT_SECRET!,
    COOLSMS_APIKEY: process.env.COOLSMS_APIKEY!,
    COOLSMS_APIKEY_SECRET: process.env.COOLSMS_APIKEY_SECRET!,
    STORE_ID: process.env.STORE_ID!,
    CHANNEL_KEY: process.env.CHANNEL_KEY!,
    NODEMAILER_USER: process.env.NODEMAILER_USER!,
    NODEMAILER_PASS: process.env.NODEMAILER_PASS!,
};

export default env;
