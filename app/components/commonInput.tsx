import React from 'react';
import { TextInputProps } from 'react-native';
import styled from 'styled-components/native';

// 보더 영역 추가 작업 필요.
interface CommonInputProps extends TextInputProps {
    label?: string;
    error?: string;
    name?: string;
    isPassword?: boolean;
}

const CommonInput = ({
    label,
    error,
    name,
    isPassword = false,
    ...textInputProps
}: CommonInputProps) => {
    return (
        <ContainerEl>
            {label && <LabelEl>{label}</LabelEl>}
            <InputEl
                name={name}
                secureTextEntry={isPassword}
                {...textInputProps}
            />
            {error && <ErrorEl>{error}</ErrorEl>}
        </ContainerEl>
    );
};

const ContainerEl = styled.View`
    width: 100%;
    margin-bottom: 16px;
`;

const InputEl = styled.TextInput`
    width: 100%;
    height: 40px;
    border: 1px solid gray;
    border-radius: 5px;
    padding-inline: 10px;
    background-color: #fff;
`;

const LabelEl = styled.Text`
    font-size: 14px;
    margin-bottom: 8px;
`;

const ErrorEl = styled.Text`
    color: #e75050;
    padding-left: 8px;
    margin-top: 3px;
    margin-bottom: 8px;
`;

export default CommonInput;
