import { SignUpType, LoginType, UserType } from '@/types/user';
import { Apis } from '@/utils/api';
import { QueryFunction, QueryFunctionContext } from '@tanstack/react-query';

const userApi = {
    login: async (params: LoginType) => {
        return await Apis.post('/user/login', params);
    },
    signup: async (params: SignUpType) => {
        return await Apis.post('/user/signup', params);
    },
    getUser: async ({ queryKey }: QueryFunctionContext) => {
        const [_, userId] = queryKey; // 실제로 필요한 queryKey를 사용하세요.
        const response = await Apis.get(`/user/${userId}`);
        return response.data as UserType; // 여기서 UserType으로 타입 캐스팅
    },
};

export default userApi;
