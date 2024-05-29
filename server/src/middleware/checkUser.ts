import { NextFunction, Request, Response } from 'express';

import { JwtPayload, verify } from 'jsonwebtoken';
import config from '../config/index';

const { JWT_SECRET } = config;

export interface CustomRequest extends Request {
    token: JwtPayload;
}

export const checkUser = (req: Request, res: Response, next: NextFunction) => {
    const token = <string>req.headers['authorization'];

    if (!token) {
        return res
            .status(401)
            .json({ msg: '토큰이 존재하지 않아 인증이 거부되었습니다.' });
    }

    try {
        const decoded = <any>verify(token, JWT_SECRET, {
            complete: true,
            algorithms: ['HS256'],
            clockTolerance: 0,
            ignoreExpiration: false,
            ignoreNotBefore: false,
        });

        (req as CustomRequest).token = decoded;

        next();
    } catch (e) {
        res.status(400).json({
            success: false,
            msg: 'Missing or Invalid Token',
        });
    }
};
