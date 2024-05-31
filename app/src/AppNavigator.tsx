import { useQuery } from '@tanstack/react-query';
import { useSetRecoilState } from 'recoil';
import { useEffect } from 'react';

// Navigation
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// Screen
import Login from '@/screens/beforeLogin/login';
import LoginInput from '@/screens/beforeLogin/loginInput';
import SignUp from '@/screens/beforeLogin/signup';
import Home from '@/screens/afterLogin/Home';
import Loading from '@/screens/loading';

// Type, State
import { RootStackParams } from '@/types/router';
import { userState } from '@/states/user';
import { UserType } from '@/types/user';

// API
import userApi from '@/api/userApi';

const RootStack = createNativeStackNavigator<RootStackParams>();

const AppNavigator = () => {
    const setUser = useSetRecoilState(userState);

    const {
        data: user,
        error,
        isLoading,
    } = useQuery<UserType | null, Error, UserType, [string, any]>({
        queryKey: ['user', 1],
        queryFn: userApi.getUser,
        staleTime: 30 * 1000,
        gcTime: 60 * 1000,
    });

    useEffect(() => {
        if (user) {
            setUser(user);
        }
    }, [user, setUser]);

    if (isLoading) {
        return <Loading />;
    }

    return (
        <NavigationContainer>
            {user ? (
                <RootStack.Navigator initialRouteName="Home">
                    <RootStack.Screen
                        name="Home"
                        component={Home}
                        options={{ title: 'ICafe' }}
                    />
                </RootStack.Navigator>
            ) : (
                <RootStack.Navigator initialRouteName="Login">
                    <RootStack.Screen
                        name="Login"
                        component={Login}
                        options={{ title: '로그인' }}
                    />

                    <RootStack.Screen
                        name="LoginInput"
                        component={LoginInput}
                        options={{ title: '로그인' }}
                    />

                    <RootStack.Screen
                        name="SignUp"
                        component={SignUp}
                        options={{ title: '회원가입' }}
                    />
                </RootStack.Navigator>
            )}
        </NavigationContainer>
    );
};

export default AppNavigator;
