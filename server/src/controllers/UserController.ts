import bcrypt from "bcryptjs";
import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import config from "../config/index";
import { CustomRequest } from "../middleware/checkUser";
import User from "../models/user";
const { coolsms } = require("coolsms-node-sdk");

// import * as PortOne from "@portone/browser-sdk/v2";

const {
    JWT_SECRET,
    COOLSMS_APIKEY,
    COOLSMS_APIKEY_SECRET,
    STORE_ID,
    CHANNEL_KEY,
} = config;

interface ILoginReq {
    password: string;
    phone: string;
}
interface IRegisterReq {
    email?: string;
    password: string;
    phone: string;
    nickname?: string;
}
interface IUpdateNicknameReq {
    nickname: string;
}
interface IUpdatePasswordReq {
    password: string;
}

class UserController {
    static auth = async (req: Request, res: Response, next: NextFunction) => {
        try {
            let id = (req as CustomRequest).token.payload.id;

            const user = await User.findById(id).select("-password");

            if (!user) {
                return res
                    .status(400)
                    .json({ msg: "유저가 존재하지 않습니다." });
            }

            res.json({ success: true, user });
        } catch (e) {
            res.status(400).json({
                success: false,
                msg: "유저를 찾을 수 없습니다.",
            });
        }
    };

    static login = async (req: Request, res: Response, next: NextFunction) => {
        const { phone, password }: ILoginReq = req.body;

        if (!phone)
            return res
                .status(400)
                .json({ success: false, msg: "휴대폰 번호를 작성해주세요." });
        else if (!password)
            return res
                .status(400)
                .json({ success: false, msg: "비밀번호를 작성해주세요." });

        User.findOne({ phone }).then((user) => {
            if (!user)
                return res.status(400).json({
                    success: false,
                    msg: "휴대폰 번호 또는 비밀번호를 확인해주세요.",
                });

            bcrypt.compare(password, user.password).then((isMatch) => {
                if (!isMatch)
                    return res.status(400).json({
                        success: false,
                        msg: "휴대폰 번호 또는 비밀번호를 확인해주세요.",
                    });

                jwt.sign(
                    { id: user.id },
                    JWT_SECRET,
                    { expiresIn: 36000000 },
                    (err, token) => {
                        if (err)
                            return res
                                .status(400)
                                .json({ success: false, msg: err });

                        res.json({
                            success: true,
                            token,
                            user,
                        });
                    }
                );
            });
        });
    };

    static register = async (req: Request, res: Response) => {
        const { email, password, phone, nickname }: IRegisterReq = req.body;

        User.findOne({ phone }).then((user) => {
            if (user)
                return res.status(400).json({
                    success: false,
                    msg: "이미 존재하는 휴대폰 번호입니다.",
                });

            const newUser = new User({
                email,
                password,
                phone,
                nickname,
            });

            bcrypt.genSalt(10, (err, salt) => {
                bcrypt.hash(newUser.password, salt, (err, hash) => {
                    if (err) return res.status(400).json({ err });

                    newUser.password = hash;
                    newUser.save().then((user) => {
                        jwt.sign(
                            { id: user.id },
                            JWT_SECRET,
                            { expiresIn: 36000000 },
                            (err, token) => {
                                if (err) return res.status(400).json({ err });

                                res.json({
                                    success: true,
                                    token,
                                    user,
                                });
                            }
                        );
                    });
                });
            });
        });
    };

    static updateNickname = async (req: Request, res: Response) => {
        const { nickname }: IUpdateNicknameReq = req.body;

        User.findById(req.params.id)
            .then((foundUser) => {
                if (!foundUser)
                    return res.status(400).json({
                        success: false,
                        msg: "유저를 찾을 수 없습니다.",
                    });

                User.findByIdAndUpdate(
                    req.params.id,
                    {
                        nickname,
                    },
                    { new: true }
                )
                    .select("-password")
                    .then((user) => {
                        res.json({ success: true, user });
                    })
                    .catch((err) => {
                        res.status(400).json({ success: false, msg: err.msg });
                    });
            })
            .catch((err) => {
                let errMsg = err.message;

                if (err.name === "CastError")
                    errMsg = "유저를 찾을 수 없습니다.";

                res.status(400).json({ success: false, msg: errMsg });
            });
    };

    static updatePassword = async (req: Request, res: Response) => {
        const { password }: IUpdatePasswordReq = req.body;

        User.findById(req.params.id)
            .then((foundUser) => {
                if (!foundUser)
                    return res.status(400).json({
                        success: false,
                        msg: "유저를 찾을 수 없습니다.",
                    });

                bcrypt.genSalt(10, (err, salt) => {
                    bcrypt.hash(password, salt, (err, hash) => {
                        if (err) return res.status(400).json({ err });

                        User.findByIdAndUpdate(
                            req.params.id,
                            {
                                password: hash,
                            },
                            { new: true }
                        )
                            .select("-password")
                            .then((result) => {
                                res.json({ success: true, user: result });
                            })
                            .catch((err) => {
                                res.status(400).json({
                                    success: false,
                                    msg: err.msg,
                                });
                            });
                    });
                });
            })
            .catch((err) => {
                let errMsg = err.message;

                if (err.name === "CastError")
                    errMsg = "유저를 찾을 수 없습니다.";

                res.status(400).json({ success: false, msg: errMsg });
            });
    };

    static withdrawal = async (req: Request, res: Response) => {
        try {
            await User.deleteOne({ _id: req.params.id })
                .then(() => {
                    res.status(200).json({ success: true });
                })
                .catch((err) => {
                    let errMsg = err.message;

                    if (err.name === "CastError")
                        errMsg = "ID 값을 확인해주세요.";

                    res.status(400).json({ success: false, msg: errMsg });
                });

            return;
        } catch (err) {
            return res.status(400).json({ success: false, msg: err });
        }
    };

    static authPhone = async (req: Request, res: Response) => {
        // PortOne.requestIdentityVerification({
        //     // 고객사 storeId로 변경해주세요.
        //     storeId: STORE_ID,
        //     identityVerificationId: `identity-verification-${crypto.randomUUID()}`,
        //     // 연동 정보 메뉴의 채널 관리 탭에서 확인 가능합니다.
        //     channelKey: CHANNEL_KEY,
        // });

        // const response = await PortOne.requestIdentityVerification();
        //   // 프로세스가 제대로 완료되지 않은 경우 에러 코드가 존재합니다
        //   if (response.code != null) {
        //     return alert(response.message);
        //   }

        //   const verificationResult = await fetch("{서버의 인증 정보를 받는 endpoint}", {
        //     method: "POST",
        //     headers: { "Content-Type": "application/json" },
        //     body: JSON.stringify({
        //       identityVerificationId,
        //     }),
        //   });

        const { phone } = req.body;

        let authNum = "";
        for (let i = 0; i < 6; i++) {
            authNum += Math.floor(Math.random() * 10);
        }

        const mysms = coolsms.default;
        const messageService = new mysms(COOLSMS_APIKEY, COOLSMS_APIKEY_SECRET);
        const result = await messageService.sendOne({
            to: phone,
            from: "01056294023",
            text: `인증번호 [${authNum}]를 입력해주세요.`,
        });

        if (result.statusCode === "2000")
            return res.status(200).json({ success: true, msg: authNum });

        return res
            .status(400)
            .json({ success: false, msg: "인증 문자 전송 실패" });
    };
}

export default UserController;
