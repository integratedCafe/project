import { Router } from "express";

// Middleware
import { asyncHandler } from "../../middleware/asyncHandler";

// Controller
import UserController from "../../controllers/UserController";
import { checkUser } from "../../middleware/checkUser";

const router = Router();

router.get("/", [checkUser], asyncHandler(UserController.auth));
router.post("/login", asyncHandler(UserController.login));
router.post("/signup", asyncHandler(UserController.register));
router.post("/auth/phone", asyncHandler(UserController.authPhone));
router.post("/auth/email", asyncHandler(UserController.authEmail));
router.put("/nickname/:id", asyncHandler(UserController.updateNickname));
router.put("/pw/:id", asyncHandler(UserController.updateNickname));
router.delete("/:id", asyncHandler(UserController.withdrawal));

export default router;
