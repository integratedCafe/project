import { Router } from "express";

// Middleware
import { asyncHandler } from "../../middleware/asyncHandler";

// Controller
import CafeController from "../../controllers/CafeController";

const router = Router();

router.get("/skip/:page", asyncHandler(CafeController.getCafes));
router.get("/:id", asyncHandler(CafeController.getCafe));
router.post("/", asyncHandler(CafeController.create));
router.put("/:id", asyncHandler(CafeController.update));
router.delete("/:id", asyncHandler(CafeController.delete));

export default router;
