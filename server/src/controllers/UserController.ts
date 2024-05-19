import bcrypt from 'bcryptjs';
import { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import config from '../config/index';
import User from '../models/user';

const { JWT_SECRET } = config;

class UserController {
    static login = async (req: Request, res: Response, next: NextFunction) => {
        const { email, password }: { email: string; password: string } =
            req.body;

        if (!email)
            return res
                .status(400)
                .json({ success: false, msg: '이메일을 작성해주세요.' });
        else if (!password)
            return res
                .status(400)
                .json({ success: false, msg: '비밀번호를 작성해주세요.' });

        User.findOne({ email }).then((user) => {
            if (!user)
                return res
                    .status(400)
                    .json({ success: false, msg: '이메일을 확인해주세요.' });

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
        const {
            name,
            email,
            password,
            phone,
            nickname,
        }: {
            name: string;
            email?: string;
            password: string;
            phone: string;
            nickname: string;
        } = req.body;

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
}

export default UserController;
