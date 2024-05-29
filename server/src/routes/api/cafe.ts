import { Router } from 'express';

// Middleware
import { asyncHandler } from '../../middleware/asyncHandler';

// Controller
import CafeController from '../../controllers/CafeController';

const router = Router();

router.post('/', asyncHandler(CafeController.create));
router.put('/:id', asyncHandler(CafeController.update));
router.delete('/:id', asyncHandler(CafeController.delete));

export default router;
