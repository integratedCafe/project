import { Router } from 'express';
import cafe from './cafe';
import menu from './menu';
import user from './user';

const routes = Router();

routes.use('/user', user);
routes.use('/cafe', cafe);
routes.use('/menu', menu);

export default routes;
