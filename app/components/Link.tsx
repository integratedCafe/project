import React from 'react';
import { Text, StyleSheet, Linking, StyleProp } from 'react-native';
import { NavigationProp, useNavigation } from '@react-navigation/native';

import { RootStackParams } from '@/types/router';
import styled from 'styled-components/native';

type LinkProps = {
    url: string;
    children: React.ReactNode;
    color?: string;
    internal?: boolean;
};

const Link = ({ url, children, color, internal }: LinkProps) => {
    const navigation = useNavigation<NavigationProp<RootStackParams>>();

    const handlePress = async () => {
        if (internal) {
            if (url) navigation.navigate(url as keyof RootStackParams);
        } else {
            const supported = await Linking.canOpenURL(url);
            if (supported) {
                await Linking.openURL(url);
            } else {
                console.log(`Link URL Error : ${url}`);
            }
        }
    };

    return (
        <LinkEl onPress={handlePress} color={color}>
            <Text>{children}</Text>
        </LinkEl>
    );
};

type LinkType = {
    color?: string;
};

const LinkEl = styled.TouchableOpacity`
    padding: 10px;
    color: #333;

    Text {
        color: ${(props: LinkType) => (props.color ? props.color : '#333')};
    }
`;

export default Link;
