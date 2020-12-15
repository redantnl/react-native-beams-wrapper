import { NativeModules } from 'react-native';

type BeamsWrapperType = {
  multiply(a: number, b: number): Promise<number>;
  connect(
    userId: string,
    token: string,
    instanceId: string,
    authUrl: string
  ): void;
};

const { BeamsWrapper } = NativeModules;

export default BeamsWrapper as BeamsWrapperType;
