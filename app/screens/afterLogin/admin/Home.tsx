import { useState } from 'react';
import { userState } from '@/states/user';
import { View, Text } from 'react-native';
import Checkbox from '@/components/checkbox';
import { useRecoilState, useRecoilValue } from 'recoil';

// Component
import Link from '@/components/Link';

const AdminHome = () => {
    // const user = useRecoilState(userState);
    const user = useRecoilValue(userState);
    console.log(user, ' : user');

    return (
        <View>
            <Text>This is Home!!! 유저 정보 : </Text>
            <View>
                {user &&
                    Object.entries(user).map(([key, v]) => {
                        return (
                            <Text key={key}>
                                Key: {key}, Value: {JSON.stringify(v)}
                            </Text>
                        );
                    })}
                <Link url="CafeRegister" internal>
                    <Text>카페 등록하기</Text>
                </Link>
            </View>
        </View>
    );
};

export default AdminHome;
