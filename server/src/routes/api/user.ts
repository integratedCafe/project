import { Router } from 'express';

// Middleware
import UserController from '../../controllers/UserController';
import { asyncHandler } from '../../middleware/asyncHandler';

const router = Router();

router.post('/login', [asyncHandler(UserController.login)]);
router.post('/signup', [], asyncHandler(UserController.register));

export default router;
