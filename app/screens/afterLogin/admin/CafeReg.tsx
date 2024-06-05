import { useState } from 'react';
import {
    NativeSyntheticEvent,
    TextInputChangeEventData,
    View,
} from 'react-native';

// Type, State
import { CafeType } from '@/types/cafe';
import { initCafe } from '@/entries/cafe';

// Component
import CommonInput from '@/components/commonInput';
import DatePicker from 'react-native-modal-datetime-picker';

const CafeRegister = () => {
    /**
     * ownerId
        name
        location
        image
        phone
        brNumber
        description
        breakTime
        openHour
        dayOffWeek
     */
    const [data, setData] = useState<CafeType>(initCafe);
    const [visible, setVisible] = useState<boolean>(false);
    const [date, onChangeDate] = useState<Date>(new Date());

    const handleChange = (
        name: string,
        e: NativeSyntheticEvent<TextInputChangeEventData>,
    ) => {
        setData((prev) => ({ ...prev, [name]: e.nativeEvent.text }));
        setVisible(true);
    };

    const onConfirm = (e: Date) => {
        console.log(e, ' : E');
    };
    const onCancel = () => {
        setVisible(false);
    };

    return (
        <View>
            <CommonInput
                label="매장 이름"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="위치"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="이미지"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="매장 번호"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="사업자 번호"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="매장에 대한 설명"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="매장에 대한 설명"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <DatePicker
                isVisible={true}
                mode="time"
                onConfirm={onConfirm}
                onCancel={onCancel}
                date={date}
            ></DatePicker>
            <CommonInput
                label="오픈 시간"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
            <CommonInput
                label="휴일"
                onChange={(e) => handleChange('', e)}
            ></CommonInput>
        </View>
    );
};

export default CafeRegister;
