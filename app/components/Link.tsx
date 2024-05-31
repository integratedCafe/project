import React from 'react';
import { Text, StyleSheet, Linking, StyleProp } from 'react-native';
import { NavigationProp, useNavigation } from '@react-navigation/native';

import { RootStackParams } from '@/types/router';
import styled, { css as styledCss } from 'styled-components/native';

type LinkProps = {
    url: string;
    children: React.ReactNode;
    css?: string;
    internal?: boolean;
};

const Link = ({ url, children, css, internal }: LinkProps) => {
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
        <LinkEl onPress={handlePress} css={css}>
            <TextEl>{children}</TextEl>
        </LinkEl>
    );
};

type LinkType = {
    css?: string;
};

const LinkEl = styled.TouchableOpacity<LinkType>`
    padding: 10px;
    color: #333;

    ${(props: LinkType) => props.css && styledCss`${props.css}`}
`;

const TextEl = styled.Text`
    color: inherit;
`;

export default Link;
