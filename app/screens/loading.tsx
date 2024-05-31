import { Container } from '@/ui/commonUi';
import { Text } from 'react-native';
import styled from 'styled-components/native';

const Loading = () => {
    return (
        <Container>
            <Content>
                <Text>로딩중 입니다...</Text>
            </Content>
        </Container>
    );
};

const Content = styled.View`
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    background-color: red;
`;

export default Loading;
