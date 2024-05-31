import { UserType } from '@/types/user';
import { atom } from 'recoil';

interface IUserState extends UserType {
    token: string;
}

// export const userState = atom<IUserState>({
export const userState = atom<UserType>({
    key: 'userState',
    default: {
        _id: '',
        name: '',
        email: '',
        nickname: '',
        marketing: false,
        appPush: false,
        locAgreement: false,
        isOwner: false,
        freqCafes: [],
        likedCafes: [],
        orders: [],
        likedMenus: [],
        notifications: [],
        // token: '',
    },
});
