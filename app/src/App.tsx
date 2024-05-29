import {
    QueryClient,
    QueryClientProvider,
    useQuery,
} from '@tanstack/react-query';
import { StyleSheet, View } from 'react-native';
import { RecoilRoot } from 'recoil';
import { useSetRecoilState } from 'recoil';

// Navigation
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// Screen
import Login from '@/screens/beforeLogin/login';
import LoginInput from '@/screens/beforeLogin/loginInput';
import Register from '@/screens/beforeLogin/signup';

// Type, State
import { RootStackParams } from '@/types/router';
import { userState } from '@/states/user';
import { UserType } from '@/types/user';

// Style
import styled from 'styled-components/native';
import userApi from '@/api/userApi';

const queryClient = new QueryClient();
const RootStack = createNativeStackNavigator<RootStackParams>();

export default function App() {
    // const setUser = useSetRecoilState(userState);

    // const {
    //     data: user,
    //     error,
    //     isLoading,
    // } = useQuery<UserType, Error, UserType, [string, any]>({
    //     queryKey: ['user', 1], // 실제 userId 값으로 교체
    //     queryFn: userApi.getUser,
    //     staleTime: 60 * 1000,
    //     gcTime: 60 * 1000,
    // });

    return (
        <QueryClientProvider client={queryClient}>
            <RecoilRoot>
                <NavigationContainer>
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
                            name="Register"
                            component={Register}
                            options={{ title: '회원가입' }}
                        />
                    </RootStack.Navigator>
                </NavigationContainer>
            </RecoilRoot>
        </QueryClientProvider>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        alignItems: 'center',
        justifyContent: 'center',
    },
});

const screenStyle = StyleSheet.create({
    container: {},
});
