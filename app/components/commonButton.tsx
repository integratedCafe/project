import React from 'react';
import { Text } from 'react-native';
import styled from 'styled-components/native';

interface ButtonProps {
    title: string;
    disabled?: boolean;
    borderColor?: string;
    bgColor?: string;
    color?: string;
    onPress: () => void;
}

const CommonButton = ({
    title,
    disabled = false,
    borderColor,
    bgColor,
    color,
    onPress,
}: ButtonProps) => {
    return (
        <ButtonEl
            onPress={onPress}
            border={borderColor}
            bgColor={bgColor}
            color={color}
            disabled={disabled}
        >
            <Text>{title}</Text>
        </ButtonEl>
    );
};

interface ButtonType {
    border?: string;
    bgColor?: string;
    color?: string;
    disabled?: boolean;
}

const ButtonEl = styled.TouchableOpacity<ButtonType>`
    border-radius: 5px;
    align-items: center;
    justify-content: center;
    border: ${(props: ButtonType) =>
        props.border ? `1px solid ${props.border}` : '1px solid #333'};
    background-color: ${(props: ButtonType) =>
        props.bgColor ? props.bgColor : '#FFF'};

    color: ${(props: ButtonType) => (props.color ? `${props.color}` : '#333')};

    padding: 10px;
    ${(props: ButtonType) =>
        props.disabled &&
        `
        background-color: #a9a9a9;
        border: 1px solid #a9a9a9;
    `}
`;

export default CommonButton;
