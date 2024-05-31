import { useState } from 'react';
import { userState } from '@/states/user';
import { View, Text } from 'react-native';
import Checkbox from '@/components/checkbox';
import { useRecoilState, useRecoilValue } from 'recoil';

const Home = () => {
    // const user = useRecoilState(userState);
    const user = useRecoilValue(userState);
    const [isChecked, setIsChecked] = useState<boolean>(false);
    console.log(user, ' : user');
    const handleChecked = () => {
        setIsChecked(!isChecked);
        console.log(isChecked, ' : checked');
    };
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
            </View>
            <Checkbox isChecked={isChecked} onToggle={handleChecked}></Checkbox>
        </View>
    );
};

export default Home;
