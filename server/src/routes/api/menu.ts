import { Router } from 'express';

// Middleware
import { asyncHandler } from '../../middleware/asyncHandler';

// Controller
import MenuController from '../../controllers/MenuController';

const router = Router();

router.post('/', asyncHandler, MenuController.create);
router.put('/:id', asyncHandler, MenuController.update);
router.delete('/:id', asyncHandler, MenuController.delete);

export default router;
