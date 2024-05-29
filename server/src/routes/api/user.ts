import { Router } from 'express';

// Middleware
import { asyncHandler } from '../../middleware/asyncHandler';

// Controller
import UserController from '../../controllers/UserController';
import { checkUser } from '../../middleware/checkUser';

const router = Router();

router.post('/login', asyncHandler(UserController.login));
router.post('/signup', asyncHandler(UserController.register));
router.put('/:id', asyncHandler(UserController.update));
router.delete('/:id', asyncHandler(UserController.withdrawal));
router.get('/', [checkUser], asyncHandler(UserController.auth));

export default router;
