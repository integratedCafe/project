import { Request, Response } from 'express';
import Menu, { IMenu } from '../models/menu';

class MenuController {
    static create = async (req: Request, res: Response) => {
        const {
            name,
            price,
            image = '',
            options = [],
            description = '',
            cafeId,
        }: IMenu = req.body;

        if (!name)
            return res
                .status(400)
                .json({ success: false, msg: '업장명은 필수항목입니다.' });
        if (!price)
            return res
                .status(400)
                .json({ success: false, msg: '가격은 필수항목입니다.' });
        if (!cafeId)
            return res
                .status(400)
                .json({ success: false, msg: '카페 ID값은 필수항목입니다.' });

        const newMenu = new Menu({
            name,
            price,
            image,
            options,
            description,
            cafeId,
        });

        newMenu
            .save()
            .then((newMenu) => {
                res.status(200).json({ success: true, menu: newMenu });
            })
            .catch(() => {
                res.status(400).json({
                    success: false,
                    msg: '메뉴를 저장하지 못했습니다.',
                });
            });
    };

    static delete = async (req: Request, res: Response) => {
        try {
            await Menu.deleteOne({ _id: req.params.id });

            return res.status(200).json({ success: true });
        } catch (e) {
            console.log(e);
            return res.status(400).json({ error: e });
        }
    };

    static update = async (req: Request, res: Response) => {
        const { name, price, image, options, description }: IMenu = req.body;

        if (!name)
            return res
                .status(400)
                .json({ success: false, msg: '업장명은 필수항목입니다.' });
        if (!price)
            return res
                .status(400)
                .json({ success: false, msg: '가격은 필수항목입니다.' });

        Menu.findById(req.params.id).then((menu) => {
            if (!menu)
                return res
                    .status(400)
                    .json({ success: false, msg: '메뉴를 찾을 수 없습니다.' });

            let updatedAt = Date.now();

            Menu.findByIdAndUpdate(req.params.id, {
                name,
                price,
                image,
                options,
                description,
                updatedAt,
            });
        });
    };
}

export default MenuController;
