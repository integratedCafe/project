import { useState, useEffect } from 'react';
import {
    View,
    Pressable,
    NativeSyntheticEvent,
    TextInputChangeEventData,
} from 'react-native';
import { useMutation } from '@tanstack/react-query';
import { useRecoilState } from 'recoil';

// Type, State
import { SignUpType } from '@/types/user';
import { userState } from '@/states/user';

// Util
import { service } from '@/utils/service';
import { initSignUpState } from '@/entries/user';

// API
import userApi from '@/api/userApi';

// Components
import CommonButton from '@/components/commonButton';
import CommonInput from '@/components/commonInput';
import { Container } from '@/ui/commonUi';

const SignUp: React.FC = () => {
    const [user, setUser] = useRecoilState(userState);

    const [state, setState] = useState<SignUpType>(initSignUpState);
    const [errField, setErrField] = useState<SignUpType>(initSignUpState);
    const requiredField = ['name', 'phone', 'password'];
    const errLabel = {
        name: '이름',
        phone: '휴대전화',
        password: '비밀번호',
    };

    const signupMutation = useMutation({
        mutationFn: userApi.signup,
        onError: (Error, variable, context) => {
            console.error('Sign Up API Error >>>> ', Error);
        },
        onSuccess: (data, variables, context) => {
            console.log('Sign Up Suceess >>>> ', data, variables, context);
            if (data.success) {
                setUser({ ...data.user, token: data.token });
                service.setItem('user', data.token);
            }
        },
    });

    const handleChange = (
        name: string,
        e: NativeSyntheticEvent<TextInputChangeEventData>,
    ) => {
        setState((prev) => ({ ...prev, [name]: e.nativeEvent.text }));
        setErrField((prev) => ({ ...prev, [name]: '' }));
    };

    const onSignUp = async () => {
        // await API
        const isPass = service.reqVaildMulti(state, requiredField);

        if (isPass === 'pass') {
            console.log(state);
            signupMutation.mutate(state);
        } else {
            isPass.forEach((key: string) => {
                setErrField((prev) => ({
                    ...prev,
                    [key]: `${(errLabel as any)[key]}를 입력해주세요.`,
                }));
            });
        }
    };

    return (
        <Container>
            <CommonInput
                label="이름"
                value={state.name}
                error={errField.name}
                onChange={(e) => handleChange('name', e)}
            />
            <CommonInput
                label="휴대폰번호"
                value={state.phone}
                error={errField.phone}
                onChange={(e) => handleChange('phone', e)}
            />
            <CommonInput
                label="비밀번호"
                value={state.password}
                error={errField.password}
                onChange={(e) => handleChange('password', e)}
            />
            <CommonInput
                label="이메일"
                value={state.email}
                onChange={(e) => handleChange('email', e)}
            />
            <CommonInput
                label="닉네임"
                value={state.nickname}
                onChange={(e) => handleChange('nickname', e)}
            />
            {/* <Pressable></Pressable> */}

            <CommonButton title="회원가입" onPress={onSignUp}></CommonButton>
        </Container>
    );
};

export default SignUp;
