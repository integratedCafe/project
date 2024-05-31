import { View } from 'react-native';
import { useState } from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { useRecoilState } from 'recoil';

// Component
import CommonInput from '@/components/commonInput';
import Link from '@/components/Link';
import CommonButton from '@/components/commonButton';
import { Container } from '@/ui/commonUi';

// Type, State
import { LoginType } from '@/types/user';
import { initLoginState } from '@/entries/user';
import { userState } from '@/states/user';

// Util
import { service } from '@/utils/service';

// API
import userApi from '@/api/userApi';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { RootStackParams } from '@/types/router';

type routerProps = NativeStackScreenProps<
    RootStackParams,
    'LoginInput' | 'Login' | 'Home'
>;

const LoginInput = ({ navigation }: routerProps) => {
    const queryClient = useQueryClient();

    const [user, setUser] = useRecoilState(userState);
    const [state, setState] = useState<LoginType>(initLoginState);

    const loginMutation = useMutation({
        mutationFn: userApi.login,
        onError: (Error, variable, context) => {
            console.error('Login API Error >>>> ', Error);
        },
        onSuccess: (data, variables, context) => {
            console.log('Login Suceess >>>> ', data);
            if (data.success) {
                console.log('Success???');
                setUser({ ...data.user, token: data.token });
                service.setItem('user', data.token);
                queryClient.invalidateQueries({ queryKey: ['user'] });
            }
        },
    });

    const onLogin = async () => {
        console.log('LOGIN!!! >>>> ', state);
        loginMutation.mutate(state);
    };

    return (
        <Container>
            <CommonInput
                label="Phone"
                onChangeText={(text) =>
                    setState((prevState) => ({ ...prevState, phone: text }))
                }
            />
            <CommonInput
                label="Password"
                isPassword={true}
                onChangeText={(text) =>
                    setState((prevState) => ({ ...prevState, password: text }))
                }
            />
            <CommonButton title="Login" onPress={onLogin}></CommonButton>
            <Link url="SignUp" internal>
                계정이 없으신가요?
            </Link>
        </Container>
    );
};

export default LoginInput;
