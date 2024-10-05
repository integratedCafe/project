import { Request, Response } from "express";
import Cafe from "../models/cafe";
import Menu, { IMenu } from "../models/menu";

class MenuController {
    static create = async (req: Request, res: Response) => {
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

        newMenu
            .save()
            .then((newMenu) => {
                Cafe.findByIdAndUpdate(cafeId, { $push: { menus: newMenu._id } })
                    .then(() => {
                        res.status(200).json({ success: true, menu: newMenu });
                    })
                    .catch((err) => {
                        console.error(err);
                        res.status(400).json({
                            success: false,
                            msg: "메뉴를 저장하지 못했습니다.",
                        });
                    });
            })
            .catch(() => {
                res.status(400).json({
                    success: false,
                    msg: "메뉴를 저장하지 못했습니다.",
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

        if (!name) return res.status(400).json({ success: false, msg: "업장명은 필수항목입니다." });
        if (!price) return res.status(400).json({ success: false, msg: "가격은 필수항목입니다." });

        Menu.findById(req.params.id).then((menu) => {
            if (!menu) return res.status(400).json({ success: false, msg: "메뉴를 찾을 수 없습니다." });

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

    static addAllItems = async (req: Request, res: Response) => {
        let cafes = [
            "66e536884b578b4dfbfbf75a",
            "66e535904b578b4dfbfbf74a",
            "66e534af4b578b4dfbfbf73e",
            "66e535e64b578b4dfbfbf756",
            "66e535ad4b578b4dfbfbf74e",
            "66e535054b578b4dfbfbf746",
            "66e536a14b578b4dfbfbf75c",
            "66e5346d4b578b4dfbfbf738",
            "66e535a04b578b4dfbfbf74c",
            "66e534c64b578b4dfbfbf740",
            "66e535da4b578b4dfbfbf754",
            "66e535bc4b578b4dfbfbf750",
            "66e534f74b578b4dfbfbf744",
            "66e535f34b578b4dfbfbf758",
            "66e534994b578b4dfbfbf73c",
            "66e5357a4b578b4dfbfbf748",
            "66e5343a4b578b4dfbfbf736",
            "66e5347e4b578b4dfbfbf73a",
            "66e534e74b578b4dfbfbf742",
            "66e535c94b578b4dfbfbf752",
        ];

        cafes.map((cafe) => {
            const newMenu = new Menu({
                name: "초코칩쿠키",
                price: 3000,
                cafeId: cafe,
                description: "초코칩쿠키",
                image: "",
                options: [],
            });

            newMenu
                .save()
                .then((newMenu) => {
                    Cafe.findByIdAndUpdate(cafe, { $push: { menus: newMenu._id } })
                        .then(() => {})
                        .catch((err) => {
                            console.error(err);
                            res.status(400).json({
                                success: false,
                                msg: "메뉴를 저장하지 못했습니다.",
                            });
                        });
                })
                .catch(() => {
                    res.status(400).json({
                        success: false,
                        msg: "메뉴를 저장하지 못했습니다.",
                    });
                });
        });
    };
}

export default MenuController;
