import { Request, Response } from "express";
import Cafe, { ICafe } from "../models/cafe";

interface ICafeRequest extends Request {
    body: ICafe;
}

class CafeController {
    static getCafe = async (req: Request, res: Response) => {
        try {
            let { id } = req.params;

            const cafe = await Cafe.findById(id);

            if (cafe) {
                res.status(200).json({
                    success: true,
                    cafe,
                });
            } else {
                res.status(400).json({
                    success: false,
                    msg: "해당 카페를 찾을 수 없습니다.",
                });
            }
        } catch (err) {
            res.status(400).json({ success: false, msg: err });
        }
    };

    static getCafes = async (req: Request, res: Response) => {
        try {
            let page = (Number(req.params.page) - 1) * 20;

            const cafeCount = await Cafe.countDocuments();
            const cafeFindResult = await Cafe.find()
                .skip(page)
                .limit(20)
                .sort({ date: -1 });

            res.status(200).json({
                success: true,
                total: cafeCount,
                cafes: cafeFindResult,
            });
        } catch (err) {
            res.status(400).json({ success: false, msg: err });
        }
    };

    static create = async (req: Request, res: Response) => {
        const { location, name, ownerId, brNumber, phone }: ICafe = req.body;

        if (!location)
            return res
                .status(400)
                .json({ success: false, msg: "위치는 필수항목입니다." });
        if (!name)
            return res
                .status(400)
                .json({ success: false, msg: "업장명은 필수항목입니다." });
        if (!ownerId)
            return res
                .status(400)
                .json({ success: false, msg: "업장주 ID값은 필수항목입니다." });
        if (!brNumber)
            return res.status(400).json({
                success: false,
                msg: "사업자등록번호는 필수항목입니다.",
            });
        if (!phone)
            return res
                .status(400)
                .json({ success: false, msg: "휴대폰은 필수항목입니다." });

        const createdData: Partial<ICafeRequest["body"]> = {};
        for (const key in req.body) {
            if (key in req.body) {
                createdData[key as keyof ICafeRequest["body"]] = req.body[key];
            }
        }

        const newCafe = new Cafe(createdData);

        newCafe
            .save()
            .then((newcafe) => {
                res.status(200).json({ success: true, cafe: newcafe });
            })
            .catch(() => {
                res.status(400).json({
                    success: false,
                    msg: "카페를 저장하지 못했습니다.",
                });
            });
    };

    static delete = async (req: Request, res: Response) => {
        try {
            // 해당 카페 삭제 시, 로직 추가 필요
            await Cafe.deleteOne({ _id: req.params.id });

            return res.status(200).json({ success: true });
        } catch (e) {
            console.log(e);
            return res.status(400).json({ error: e });
        }
    };

    static update = async (req: Request, res: Response) => {
        const { location, name, ownerId, brNumber, phone, brandId }: ICafe =
            req.body;

        if (!location)
            return res
                .status(400)
                .json({ success: false, msg: "위치는 필수항목입니다." });
        if (!name)
            return res
                .status(400)
                .json({ success: false, msg: "업장명은 필수항목입니다." });
        if (!ownerId)
            return res
                .status(400)
                .json({ success: false, msg: "업장주 ID값은 필수항목입니다." });
        if (!brNumber)
            return res.status(400).json({
                success: false,
                msg: "사업자등록번호는 필수항목입니다.",
            });
        if (!phone)
            return res
                .status(400)
                .json({ success: false, msg: "휴대폰은 필수항목입니다." });
        if (!brandId)
            return res
                .status(400)
                .json({ success: false, msg: "브랜드 ID값은 필수항목입니다." });

        const updates: Partial<ICafeRequest["body"]> = {};
        for (const key in req.body) {
            if (key in req.body) {
                updates[key as keyof ICafeRequest["body"]] = req.body[key];
            }
        }

        Cafe.findById(req.params.id).then((cafe) => {
            if (!cafe)
                return res
                    .status(400)
                    .json({ success: false, msg: "카페를 찾을 수 없습니다." });

            let updatedAt = Date.now();

            Cafe.findByIdAndUpdate(req.params.id, { ...updates, updatedAt });
        });
    };
}

export default CafeController;
