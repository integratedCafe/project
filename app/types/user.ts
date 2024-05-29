interface UserType {
    _id: string;
    name: string;
    email: string;
    nickname: string;
    marketing: boolean;
    appPush: boolean;
    locAgreement: boolean;
    isOwner: boolean;
}

interface LoginType {
    phone: string;
    password: string;
}

interface SignUpType {
    name: string;
    phone: string;
    password: string;
    email?: string;
    nickname?: string;
    marketing?: boolean;
    appPush?: boolean;
    locAgreement?: boolean;
    loginway: LoginWay;
}

enum LoginWay {
    Phone = 'phone',
    Kakao = 'kakao',
    Google = 'google',
    Naver = 'naver',
    Apple = 'apple',
}

export { LoginType, SignUpType, LoginWay, UserType };
