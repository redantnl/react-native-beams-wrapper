import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import BeamsWrapper from 'react-native-beams-wrapper';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  const accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC93d3cuY29wYWFuLm5sIiwiYXVkIjoiaHR0cDpcL1wvd3d3LmNvcGFhbi5ubCIsImlhdCI6MTYxMjUxNjkyMywiZGF0YSI6eyJpZCI6NjUsImVtYWlsIjoibWFrZWxhYXJAcHJvbG9jby5ubCIsInJvbGUiOiJhZ2VudCIsInR5cGUiOiJub3JtYWwiLCJyZWdpb24iOjQsImFnZW50IjoxLCJzdGF0dXMiOiJhY3RpZWYifSwiZXhwIjoxNjEyNTE4NzIzfQ.bU-IYM05sGpBVNAPOgtB_BVqnmUx3nfcbriZdbIalOw";
  const authUrl = "http://192.168.2.14/Redant/proloco-api/public/index.php/app/auth/pusher"
  const instanceId = "4f758dae-7fb9-4314-8341-ff82ccd2b731";

  React.useEffect(() => {
    BeamsWrapper.multiply(3, 7).then(setResult);

    BeamsWrapper.connect('65', accessToken, instanceId, authUrl)

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
