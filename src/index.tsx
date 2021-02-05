import {
  NativeModules,
  Platform,
  DeviceEventEmitter,
  NativeEventEmitter,
} from 'react-native';

const { BeamsWrapper, BeamsWrapperEventHelper } = NativeModules;

const iosEventListener = new NativeEventEmitter(BeamsWrapperEventHelper);

export default {
  multiply: (a: number, b: number): Promise<number> => {
    return BeamsWrapper.multiply(a, b);
  },
  connect: (
    userId: string,
    token: string,
    instanceId: string,
    authUrl: string
  ) => {
    return BeamsWrapper.connect(userId, token, instanceId, authUrl);
  },
  on(event: string, callback: Function) {
    if (Platform.OS === 'ios') {
      iosEventListener.addListener(event, (payload) => callback(payload));
    } else {
      DeviceEventEmitter.addListener(event, (payload) => callback(payload));
    }
  },
};