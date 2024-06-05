import axios from 'axios';
import { WEB_SERVER_API_URL, IOS_SERVER_API_URL } from '@env';
import { Platform } from 'react-native';

const apiUrl = () => {
    console.log(IOS_SERVER_API_URL, ' : IOS_SERVER_API_URL');
    if (Platform.OS == 'ios' || Platform.OS == 'android')
        return IOS_SERVER_API_URL;
    else return WEB_SERVER_API_URL;
};

const api = axios.create({
    baseURL: `${apiUrl()}`,
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        accept: 'application/json',
    },
});

export const Apis = {
    get: (url: string, params?: any) =>
        api.get(url, params).then((res: any) => res.data),
    post: (url: string, payload?: any) =>
        api.post(url, payload).then((res: any) => res.data),
    put: (url: string, payload?: any) =>
        api.put(url, payload).then((res: any) => res.data),
    delete: (url: string, payload?: any) =>
        api.delete(url, payload).then((res: any) => res.data),
};
