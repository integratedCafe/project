import styled from 'styled-components/native';

const TextEl = styled.Text`
    font-size: 36px;
    text-align: center;

    margin-block: 50px;
`;

const mt20 = 'margin-top: 10px;';

const kakaoStyle = `
    ${mt20}
    border: 0px;
    background-color: #FEE500;
    color: #000000D9;
`;

const naverStyle = `
    ${mt20}
    border:0px;
    background-color:#04C75A;
    color:#FFF;
`;

const loginStyle = `
    ${mt20}
    border: 0.5px solid rgb(208,211,215);
`;

export { TextEl, kakaoStyle, naverStyle, loginStyle };
