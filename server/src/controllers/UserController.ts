import bcrypt from "bcryptjs";
import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";
import config from "../config/index";
import { CustomRequest } from "../middleware/checkUser";
import User from "../models/user";

const { coolsms } = require("coolsms-node-sdk");

// import * as PortOne from "@portone/browser-sdk/v2";

const { JWT_SECRET, COOLSMS_APIKEY, COOLSMS_APIKEY_SECRET, STORE_ID, CHANNEL_KEY, NODEMAILER_USER, NODEMAILER_PASS } = config;

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
                return res.status(400).json({ msg: "유저가 존재하지 않습니다." });
            }

            res.json({ success: true, user });
        } catch (err) {
            console.error(err);
            res.status(400).json({
                success: false,
                msg: "유저를 찾을 수 없습니다.",
            });
        }
    };

    static login = async (req: Request, res: Response, next: NextFunction) => {
        try {
            const { phone, password }: ILoginReq = req.body;

            if (!phone) return res.status(400).json({ success: false, msg: "휴대폰 번호를 작성해주세요." });
            else if (!password) return res.status(400).json({ success: false, msg: "비밀번호를 작성해주세요." });

            let user = await User.findOne({ phone });
            if (!user)
                return res.status(400).json({
                    success: false,
                    msg: "휴대폰 번호 또는 비밀번호를 확인해주세요.",
                });

            let isMatch = await bcrypt.compare(password, user.password);
            if (!isMatch)
                return res.status(400).json({
                    success: false,
                    msg: "휴대폰 번호 또는 비밀번호를 확인해주세요.",
                });

            jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: 36000000 }, (err, token) => {
                if (err) return res.status(400).json({ success: false, msg: err });

                res.json({
                    success: true,
                    token,
                    user,
                });
            });
        } catch (err) {
            console.error(err);
            res.status(400).json({
                success: false,
                msg: "로그인에 실패했습니다.",
            });
        }
    };

    static register = async (req: Request, res: Response) => {
        try {
            const { email, password, phone, nickname }: IRegisterReq = req.body;

            let user = await User.findOne({ phone });

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
                bcrypt.hash(newUser.password, salt, async (err, hash) => {
                    if (err) return res.status(400).json({ err });

                    newUser.password = hash;
                    let savedUser = await newUser.save();
                    jwt.sign({ id: savedUser.id }, JWT_SECRET, { expiresIn: 36000000 }, (err, token) => {
                        if (err) return res.status(400).json({ err });

                        res.json({
                            success: true,
                            token,
                            user,
                        });
                    });
                });
            });
        } catch (err) {
            console.error(err);
            res.status(400).json({
                success: false,
                msg: "회원가입에 실패했습니다.",
            });
        }
    };

    static updateNickname = async (req: Request, res: Response) => {
        try {
            const { nickname }: IUpdateNicknameReq = req.body;

            let foundUser = await User.findById(req.params.id);

            if (!foundUser)
                return res.status(400).json({
                    success: false,
                    msg: "유저를 찾을 수 없습니다.",
                });

            let user = await User.findByIdAndUpdate(
                req.params.id,
                {
                    nickname,
                },
                { new: true }
            ).select("-password");

            return res.status(200).json({ success: true, user });
        } catch (err) {
            console.error(err);
            return res.status(400).json({
                success: false,
                msg: "닉네임 변경에 실패했습니다.",
            });
        }
    };

    static updatePassword = async (req: Request, res: Response) => {
        try {
            const { password }: IUpdatePasswordReq = req.body;

            let foundUser = await User.findById(req.params.id);
            if (!foundUser)
                return res.status(400).json({
                    success: false,
                    msg: "유저를 찾을 수 없습니다.",
                });

            bcrypt.genSalt(10, (err, salt) => {
                bcrypt.hash(password, salt, async (err, hash) => {
                    if (err) return res.status(400).json({ err });

                    let result = await User.findByIdAndUpdate(
                        req.params.id,
                        {
                            password: hash,
                        },
                        { new: true }
                    ).select("-password");
                    res.status(200).json({ success: true, user: result });
                });
            });
        } catch (err) {
            console.error(err);
            return res.status(400).json({
                success: false,
                msg: "비밀번호 변경에 실패했습니다.",
            });
        }
    };

    static withdrawal = async (req: Request, res: Response) => {
        try {
            await User.deleteOne({ _id: req.params.id });
            return res.status(200).json({ success: true });
        } catch (err) {
            console.error(err);
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

        if (result.statusCode === "2000") return res.status(200).json({ success: true, msg: authNum });

        return res.status(400).json({ success: false, msg: "인증 문자 전송 실패" });
    };

    static authEmail = async (req: Request, res: Response) => {
        try {
            const { email } = req.body;

            let user = User.findOne({ email });
            if (!user)
                return res.status(400).json({
                    success: false,
                    msg: "등록되지 않은 이메일입니다.",
                });

            let authNum = "";
            for (let i = 0; i < 6; i++) {
                authNum += Math.floor(Math.random() * 10);
            }

            let transporter = nodemailer.createTransport({
                service: "gmail",
                host: "smtp.gmlail.com",
                port: 587,
                secure: false,
                auth: {
                    user: NODEMAILER_USER,
                    pass: NODEMAILER_PASS,
                },
            });

            let mailOptions = {
                from: NODEMAILER_USER,
                to: email,
                subject: "[카페통합] 비밀번호 찾기 인증번호",
                html: `<div>비밀번호 찾기를 위해 아래 인증번호를 입력해주세요.</div><br/><div>[${authNum}]</div>`,
            };

            transporter.sendMail(mailOptions, function (error, info) {
                if (error) {
                    console.log("emailError:::", error);
                    return res.status(400).json({
                        success: false,
                        msg: "인증번호를 보내는데 실패했습니다.",
                    });
                }

                res.send({ success: true, msg: authNum });
                transporter.close();
            });
        } catch (err) {
            console.error(err);
            return res.status(400).json({ success: false, msg: "이메일 인증에 실패했습니다." });
        }
    };
}

export default UserController;
