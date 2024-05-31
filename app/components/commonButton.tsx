import React from 'react';
import styled, { css as styledCss } from 'styled-components/native';
import CSSProp from 'styled-components/native';

interface ButtonProps {
    title: string;
    disabled?: boolean;
    css?: string;
    onPress: () => void;
}

const CommonButton = ({
    title,
    disabled = false,
    css,
    onPress,
}: ButtonProps) => {
    return (
        <ButtonEl onPress={onPress} customCss={css} disabled={disabled}>
            <TextEl>{title}</TextEl>
        </ButtonEl>
    );
};

interface ButtonType {
    disabled?: boolean;
    customCss?: string;
}

const ButtonEl = styled.TouchableOpacity<ButtonType>`
    border-radius: 5px;
    align-items: center;
    justify-content: center;
    padding: 10px;
    ${(props: ButtonType) => props.customCss && styledCss`${props.customCss}`}
    ${(props: ButtonType) =>
        props.disabled &&
        `
        background-color: #a9a9a9;
        border: 1px solid #a9a9a9;
    `}
`;

const TextEl = styled.Text`
    color: inherit;
`;

export default CommonButton;
