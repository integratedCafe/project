import dotenv from 'dotenv';

dotenv.config();

const env = {
    MONGO_URI: process.env.MONGO_URI!,
    PORT: process.env.PORT!,
    JWT_SECRET: process.env.JWT_SECRET!,
};

export default env;
