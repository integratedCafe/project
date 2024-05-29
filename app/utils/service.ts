import AsyncStorage from '@react-native-async-storage/async-storage';

const service = {
    /**
     * @name service.getItem(key)
     * @descr Async Storage에 있는 데이터 가져오기
     * @param {string} key 가져올 Key 값
     * @returns any
     */
    getItem: async function (key: string) {
        let token = null;
        try {
            if (key) token = await AsyncStorage.getItem(key);
            if (token) if (/[\[\]\{\}]/i.test(token)) token = JSON.parse(token);
        } catch (err) {
            console.error('Get item error in AsyncStorage >>>> ', err);
        }

        return token;
    },

    /**
     * @name service.setItem(key,value)
     * @descr Async Storage에 데이터 저장
     * @param {string} key 저장할 Key 값
     * @param {any} value 저장할 데이터
     * @returns null
     */
    setItem: async function (key: string, value: any) {
        try {
            let val = value;
            if (typeof value === 'object') val = JSON.stringify(value);

            await AsyncStorage.setItem(key, value);
        } catch (err) {
            console.error('Set item error in AsyncStorage  >>>> ', err);
        }
    },

    /**
     * @name service.removeItem(key)
     * @descr Async Storage에 존재하는 데이터 삭제
     * @param {string} key 삭제할 Key 값
     * @returns null
     */
    removeItem: async function (key: string) {
        try {
            if (key) await AsyncStorage.removeItem(key);
        } catch (err) {
            console.error('Remove item error in AsyncStorage >>>> ', err);
        }
    },

    /**
     * @name service.removeItem(key)
     * @descr 필수 필드 체크
     * @param {({key, value})} fields 검색할 필드 체크
     * @param {({key, value}, {key, label})} reqFields 체크할 필드 값
     * @returns string[] ||  'pass'
     */
    reqVaildMulti: (fields: any, reqFields: any) => {
        let returnValue = [] as string[];

        reqFields.forEach((x: string) => {
            if (!fields[x]) returnValue.push(x);
        });

        return returnValue.length ? returnValue : 'pass';
    },
};

export { service };
