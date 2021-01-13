import { NativeModules } from 'react-native';

type BeamsWrapperType = {
  multiply(a: number, b: number): Promise<number>;
};

const { BeamsWrapper } = NativeModules;

export default BeamsWrapper as BeamsWrapperType;
