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
  on(event: string, callback: (payload: any) => void) {
    if (Platform.OS === 'ios') {
      iosEventListener.addListener(event, (payload: any) => callback(payload));
    } else {
      DeviceEventEmitter.addListener(event, (payload: any) => callback(payload));
    }
  },
  disconnect: () => {
    return BeamsWrapper.disconnect();
  },
  removeListeners(event: string) {
    if (Platform.OS === 'ios') {
      iosEventListener.removeAllListeners(event);
    } else {
      DeviceEventEmitter.removeAllListeners(event);
    }
  }
};

