import { Router } from 'express';
import cafe from './cafe';
import user from './user';

const routes = Router();

routes.use('/user', user);
routes.use('/cafe', cafe);

export default routes;
