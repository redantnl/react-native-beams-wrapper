import { NativeModules, Platform, DeviceEventEmitter, NativeEventEmitter } from 'react-native';

const { BeamsWrapper, BeamsWrapperEventHelper } = NativeModules;

const iosEventListener = new NativeEventEmitter(
  BeamsWrapperEventHelper
);

type BeamsWrapperType = {
  multiply(a: number, b: number): Promise<number>;
};

export function on(event: string, callback: any) {
  if (Platform.OS === 'ios') {
    iosEventListener.addListener(event, payload => callback(payload));
  } else {
    DeviceEventEmitter.addListener(event, payload => callback(payload));
  }
}

BeamsWrapper as BeamsWrapperType;

export default {
  on,
};
