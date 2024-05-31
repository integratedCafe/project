import { SignUpType, LoginType, UserType } from '@/types/user';
import { Apis } from '@/utils/api';
import { service } from '@/utils/service';
import { QueryFunction, QueryFunctionContext } from '@tanstack/react-query';

const userApi = {
    login: async (params: LoginType) => {
        return await Apis.post('/user/login', params);
    },
    signup: async (params: SignUpType) => {
        return await Apis.post('/user/signup', params);
    },
    getUser: async ({ queryKey }: QueryFunctionContext) => {
        try {
            const token = await service.getItem('user');

            if (token) {
                const config = {
                    headers: {
                        Authorization: `${token}`,
                    },
                };
                const res = await Apis.get(`/user`, config);

                if (!res.success) {
                    if (Object.hasOwn(res, 'success')) {
                        throw new Error('Get User API Error >>>> ');
                    } else {
                        console.log('User Token Not Exist');
                    }
                }

                return res.user as UserType;
            } else {
                return null;
            }
        } catch (err) {
            throw err;
        }
    },
};

export default userApi;
