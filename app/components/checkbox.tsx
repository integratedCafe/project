// Checkbox.tsx
import React, { useEffect, useRef } from 'react';
import styled from 'styled-components/native';
import { TouchableOpacity, Animated, Easing } from 'react-native';
import Svg, { Path } from 'react-native-svg';

interface CheckboxProps {
    isChecked: boolean;
    onToggle: () => void;
    label?: string;
}

const CheckboxContainer = styled.View`
    flex-direction: row;
    align-items: center;
`;

const HiddenCheckbox = styled.View`
    border-radius: 3px;
    width: 24px;
    height: 24px;
    background-color: #fff;
    justify-content: center;
    align-items: center;
    border: 1px solid #4caf50;
`;

const StyledCheckmark = styled.View`
    position: absolute;
`;

const Label = styled.Text`
    margin-left: 8px;
    font-size: 16px;
    color: #333;
`;

const Checkbox: React.FC<CheckboxProps> = ({ isChecked, onToggle, label }) => {
    const strokeDashoffset = useRef(new Animated.Value(20)).current as any;

    useEffect(() => {
        Animated.timing(strokeDashoffset, {
            toValue: isChecked ? 0 : 20,
            duration: 300,
            easing: Easing.ease,
            useNativeDriver: false,
        }).start();
    }, [isChecked, strokeDashoffset]);

    return (
        <TouchableOpacity onPress={onToggle}>
            <CheckboxContainer>
                <HiddenCheckbox>
                    <StyledCheckmark>
                        <Svg
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="green"
                            strokeWidth="2"
                        >
                            <Path
                                d="M5 13l4 4L19 7"
                                strokeDasharray="20"
                                strokeDashoffset={strokeDashoffset}
                            />
                        </Svg>
                    </StyledCheckmark>
                </HiddenCheckbox>
                {label && <Label>{label}</Label>}
            </CheckboxContainer>
        </TouchableOpacity>
    );
};

export default Checkbox;
