import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import BeamsWrapper from 'react-native-beams-wrapper';


export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  React.useEffect(() => {
    // BeamsWrapper.multiply(3, 7).then(setResult);
    BeamsWrapper.on('notification', function(payload) {
      console.log(payload);
    });
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
