import CommonButton from '@/components/commonButton';
import { RootStackParams } from '@/types/router';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { Container } from '@/ui/commonUi';
import {
    TextEl,
    kakaoStyle,
    naverStyle,
    loginStyle,
} from '@/styles/loginStyle';

type loginProps = NativeStackScreenProps<RootStackParams, 'Login'>;

const Login: React.FunctionComponent<loginProps> = ({ navigation }) => {
    return (
        <Container>
            <TextEl>Integrated Cafe</TextEl>
            <CommonButton
                title="카카오 로그인"
                css={kakaoStyle}
                onPress={() => 'KKAO'}
            ></CommonButton>
            <CommonButton
                title="네이버 로그인"
                css={naverStyle}
                onPress={() => 'Naver'}
            ></CommonButton>
            <CommonButton
                // 글꼴 Roboto Medium, Text 왼족 및 오른쪽 여백 8dp, 로고 18dp, 로고 텍스트 사이 24dp
                title="Google 계정으로 로그인"
                css={loginStyle}
                onPress={() => 'Goolge'}
            ></CommonButton>
            <CommonButton
                title="Apple로 로그인"
                css={loginStyle}
                onPress={() => 'Apple'}
            ></CommonButton>
            <CommonButton
                title="휴대폰으로 로그인하기"
                css={loginStyle}
                onPress={() => navigation.navigate('LoginInput')}
            ></CommonButton>
        </Container>
    );
};

export default Login;
