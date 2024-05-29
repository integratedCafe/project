import { NextFunction, Request, Response } from 'express';
import Cafe, { ICafe } from '../models/cafe';

class CafeController {
    static create = async (req: Request, res: Response, next: NextFunction) => {
        const {
            menus,
            location,
            name,
            ownerId,
            brNumber,
            phone,
            brandId,
            image = '',
            description = '',
            breakTime = { start: '00:00', end: '00:00' },
            openHour = { start: '00:00', end: '00:00' },
            dayOffWeek = [],
        }: ICafe = req.body;

        if (!menus)
            return res
                .status(400)
                .json({ success: false, msg: '메뉴는 필수항목입니다.' });
        if (!location)
            return res
                .status(400)
                .json({ success: false, msg: '위치는 필수항목입니다.' });
        if (!name)
            return res
                .status(400)
                .json({ success: false, msg: '업장명은 필수항목입니다.' });
        if (!ownerId)
            return res
                .status(400)
                .json({ success: false, msg: '업장주 ID값은 필수항목입니다.' });
        if (!brNumber)
            return res.status(400).json({
                success: false,
                msg: '사업자등록번호는 필수항목입니다.',
            });
        if (!phone)
            return res
                .status(400)
                .json({ success: false, msg: '휴대폰은 필수항목입니다.' });
        if (!brandId)
            return res
                .status(400)
                .json({ success: false, msg: '브랜드 ID값은 필수항목입니다.' });

        // Menu 관련 로직부터 돌려야될듯
        const newCafe = new Cafe({
            menus,
            location,
            name,
            ownerId,
            brNumber,
            phone,
            brandId,
            image,
            description,
            breakTime,
            openHour,
            dayOffWeek,
        });

        newCafe
            .save()
            .then((newcafe) => {
                res.status(200).json({ success: true, cafe: newcafe });
            })
            .catch(() => {
                res.status(400).json({
                    success: false,
                    msg: '카페를 저장하지 못했습니다.',
                });
            });
    };

    static delete = async (req: Request, res: Response) => {
        try {
            await Cafe.deleteOne({ _id: req.params.id });

            return res.status(200).json({ success: true });
        } catch (e) {
            console.log(e);
            return res.status(400).json({ error: e });
        }
    };

    static update = async (req: Request, res: Response) => {
        const {
            menus,
            location,
            name,
            ownerId,
            brNumber,
            phone,
            brandId,
            image,
            description,
            breakTime,
            openHour,
            dayOffWeek,
        }: ICafe = req.body;

        // Menu 관련 로직부터 해야될듯
        if (!menus)
            return res
                .status(400)
                .json({ success: false, msg: '메뉴는 필수항목입니다.' });
        if (!location)
            return res
                .status(400)
                .json({ success: false, msg: '위치는 필수항목입니다.' });
        if (!name)
            return res
                .status(400)
                .json({ success: false, msg: '업장명은 필수항목입니다.' });
        if (!ownerId)
            return res
                .status(400)
                .json({ success: false, msg: '업장주 ID값은 필수항목입니다.' });
        if (!brNumber)
            return res.status(400).json({
                success: false,
                msg: '사업자등록번호는 필수항목입니다.',
            });
        if (!phone)
            return res
                .status(400)
                .json({ success: false, msg: '휴대폰은 필수항목입니다.' });
        if (!brandId)
            return res
                .status(400)
                .json({ success: false, msg: '브랜드 ID값은 필수항목입니다.' });

        Cafe.findById(req.params.id).then((cafe) => {
            if (!cafe)
                return res
                    .status(400)
                    .json({ success: false, msg: '카페를 찾을 수 없습니다.' });

            Cafe.findByIdAndUpdate(req.params.id, {
                menus,
                location,
                name,
                ownerId,
                brNumber,
                phone,
                brandId,
                image,
                description,
                breakTime,
                openHour,
                dayOffWeek,
            });
        });
    };
}

export default CafeController;
