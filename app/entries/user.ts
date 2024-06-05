import { LoginWay, SignUpType, LoginType } from '@/types/user';

const initLoginState: LoginType = {
    phone: '',
    password: '',
};

const initSignUpState: SignUpType = {
    name: '',
    phone: '',
    password: '',
    email: '',
    nickname: '',
    marketing: false,
    appPush: false,
    locAgreement: false,
    loginway: LoginWay.Phone,
};

export { initLoginState, initSignUpState };
