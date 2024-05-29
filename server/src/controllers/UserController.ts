import bcrypt from 'bcryptjs';
import { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import config from '../config/index';
import User from '../models/user';

const { JWT_SECRET } = config;

interface ILoginReq {
    password: string;
    phone: string;
}

interface IRegisterReq {
    name: string;
    email?: string;
    password: string;
    phone: string;
    nickname: string;
}

interface IUpdateReq {
    name: string;
    nickname: string;
    isMarketing: boolean;
    isAppPush: boolean;
    isLocAgreement: boolean;
}

class UserController {
    static login = async (req: Request, res: Response, next: NextFunction) => {
        const { phone, password }: ILoginReq = req.body;

        if (!phone)
            return res
                .status(400)
                .json({ success: false, msg: '휴대폰 번호를 작성해주세요.' });
        else if (!password)
            return res
                .status(400)
                .json({ success: false, msg: '비밀번호를 작성해주세요.' });

        User.findOne({ phone }).then((user) => {
            console.log('User >>>> ', user);
            if (!user)
                return res.status(400).json({
                    success: false,
                    msg: '휴대폰 번호를 확인해주세요.',
                });

            bcrypt.compare(password, user.password).then((isMatch) => {
                if (!isMatch)
                    return res.status(400).json({
                        success: false,
                        msg: '비밀번호를 확인해주세요.',
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
                    },
                );
            });
        });
    };

    static register = async (req: Request, res: Response) => {
        const { name, email, password, phone, nickname }: IRegisterReq =
            req.body;

        User.findOne({ phone }).then((user) => {
            if (user)
                return res.status(400).json({
                    success: false,
                    msg: '이미 존재하는 휴대폰 번호입니다.',
                });

            const newUser = new User({
                name: name,
                email: email,
                password: password,
                phone: phone,
                nickname: nickname,
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
                            },
                        );
                    });
                });
            });
        });
    };

    static withdrawal = async (req: Request, res: Response) => {
        try {
            await User.deleteOne({ _id: req.params.id });

            return res.status(200).json({ success: true });
        } catch (e) {
            console.log(e);
            return res.status(400).json({ error: e });
        }
    };

    static update = async (req: Request, res: Response) => {
        const {
            name,
            nickname,
            isMarketing,
            isAppPush,
            isLocAgreement,
        }: IUpdateReq = req.body;

        User.findById(req.params.id).then((user) => {
            if (!user)
                return res
                    .status(400)
                    .json({ success: false, msg: '유저를 찾을 수 없습니다.' });

            User.findByIdAndUpdate(req.params.id, {
                name,
                nickname,
                isMarketing,
                isAppPush,
                isLocAgreement,
            })
                .then((user) => {
                    res.json({ success: true, user });
                })
                .catch((err) => {
                    res.status(400).json({ success: false, msg: err.msg });
                });
        });
    };
}

export default UserController;
