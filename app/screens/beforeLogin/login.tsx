import CommonButton from '@/components/commonButton';
import { RootStackParams } from '@/types/router';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { Container } from '@/ui/commonUi';

type loginProps = NativeStackScreenProps<RootStackParams, 'Login'>;

const Login: React.FunctionComponent<loginProps> = ({ navigation }) => {
    return (
        <Container>
            <CommonButton
                title="휴대폰으로 로그인하기"
                onPress={() => navigation.navigate('LoginInput')}
            ></CommonButton>
        </Container>
    );
};

export default Login;
