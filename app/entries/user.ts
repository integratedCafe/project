import { LoginWay, SignUpType, loginType } from '@/types/user';

const initLoginState: loginType = {
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
