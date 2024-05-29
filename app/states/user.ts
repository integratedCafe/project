import { UserType } from '@/types/user';
import { atom } from 'recoil';

interface IUserState extends UserType {
    token: string;
}

export const userState = atom<IUserState>({
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
        token: '',
    },
});
