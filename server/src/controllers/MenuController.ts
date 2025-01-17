import { Request, Response } from "express";
import Cafe from "../models/cafe";
import Menu, { IMenu } from "../models/menu";

class MenuController {
    static create = async (req: Request, res: Response) => {
        try {
            const { name, price, image = "", options = [], description = "", cafeId }: IMenu = req.body;

            if (!name) return res.status(400).json({ success: false, msg: "업장명은 필수항목입니다." });
            if (!price) return res.status(400).json({ success: false, msg: "가격은 필수항목입니다." });
            if (!cafeId) return res.status(400).json({ success: false, msg: "카페 ID값은 필수항목입니다." });

            const newMenu = new Menu({
                name,
                price,
                image,
                options,
                description,
                cafeId,
            });

            const newmenu = await newMenu.save();
            await Cafe.findByIdAndUpdate(cafeId, { $push: { menus: newmenu._id } });

            return res.status(200).json({ success: true, menu: newMenu });
        } catch (err) {
            console.error(err);
            return res.status(400).json({
                success: false,
                msg: "메뉴를 저장하지 못했습니다.",
            });
        }
    };

    static delete = async (req: Request, res: Response) => {
        try {
            let { id } = req.params;

            let menu = await Menu.findById(id);
            if (!menu) return res.status(400).json({ success: false, msg: "해당 메뉴를 찾지 못했습니다." });

            await Menu.deleteOne({ _id: id });
            await Cafe.findByIdAndUpdate(menu.cafeId, {
                $pull: {
                    menus: { _id: id },
                },
            });

            res.status(200).json({ success: true });
        } catch (err) {
            console.error(err);
            return res.status(400).json({ success: false, msg: "해당 메뉴를 삭제하지 못했습니다." });
        }
    };

    static update = async (req: Request, res: Response) => {
        try {
            const { name, price, image = "", options = [], description = "" }: IMenu = req.body;

            if (!name) return res.status(400).json({ success: false, msg: "업장명은 필수항목입니다." });
            if (!price) return res.status(400).json({ success: false, msg: "가격은 필수항목입니다." });

            let menu = await Menu.findById(req.params.id);
            if (!menu) return res.status(400).json({ success: false, msg: "메뉴를 찾을 수 없습니다." });

            let updatedAt = Date.now();

            await Menu.findByIdAndUpdate(req.params.id, {
                name,
                price,
                image,
                options,
                description,
                updatedAt,
            });

            res.status(200).json({ success: true });
        } catch (err) {
            console.error(err);
            return res.status(400).json({ success: false, msg: "해당 메뉴를 수정하지 못했습니다." });
        }
    };
}

export default MenuController;
