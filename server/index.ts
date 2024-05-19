import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import hpp from 'hpp';
import mongoose from 'mongoose';
import morgan from 'morgan';
import config from './src/config/index';
import routes from './src/routes/api/index';

const app = express();

app.use(hpp());
app.use(helmet());

app.use(
    cors({
        origin: true,
        credentials: true,
    }),
);

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

const { MONGO_URI, PORT } = config;

let mongo_url: string = '';
let port: string = '';

if (process.env.NODE_ENV === 'production') {
    mongo_url = process.env.MONGO_URI!;
    port = process.env.PORT!;
} else {
    port = PORT;
    mongo_url = MONGO_URI;
}

mongoose
    .set('strictQuery', true)
    .connect(mongo_url)
    .then(() => {
        console.log('mongodb connecting success');
    })
    .catch((err: any) => {
        console.log(err);
    });

app.use('/', routes);

app.listen(port, () => {
    console.log(`Server started on ${PORT} port`);
});
