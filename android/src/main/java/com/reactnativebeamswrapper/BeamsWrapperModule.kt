package com.reactnativebeamswrapper

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import com.google.firebase.messaging.RemoteMessage;
import com.pusher.pushnotifications.BeamsCallback;
import com.pusher.pushnotifications.PushNotificationReceivedListener;
import com.pusher.pushnotifications.PushNotifications;
import com.pusher.pushnotifications.PusherCallbackError;
import com.pusher.pushnotifications.auth.AuthData;
import com.pusher.pushnotifications.auth.AuthDataGetter;
import com.pusher.pushnotifications.auth.BeamsTokenProvider;
import com.pusher.pushnotifications.fcm.MessagingService;
import android.util.Log;
import java.util.HashMap
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

class BeamsWrapperModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    val reactContext = reactContext;

    override fun getName(): String {
        return "BeamsWrapper"
    }

    // Example method
    // See https://facebook.github.io/react-native/docs/native-modules-android
    @ReactMethod
    fun multiply(a: Int, b: Int, promise: Promise) {

      promise.resolve(a * b)

    }

    @ReactMethod
    fun connect(userId: String, token: String, instanceId: String, authUrl: String) {
      PushNotifications.start(reactContext.getApplicationContext(), instanceId);
      Log.i("BeamsWrapper", "Connected!");
      val tokenProvider = BeamsTokenProvider(
        authUrl,
        object: AuthDataGetter {
          override fun getAuthData(): AuthData {
            return AuthData(
              // Headers and URL query params your auth endpoint needs to
              // request a Beams Token for a given user
              headers = hashMapOf(
                // for example:
                 "Authorization" to token
              ),
              queryParams = hashMapOf()
            )
          }
        }
      )

      if (userId == null) {
        Log.i("BeamsWrapper", "UserId is not defined");
      } else {
        Log.i("BeamsWrapper", "Hello!")
        PushNotifications.clearAllState();

        PushNotifications.setUserId(
          userId,
          tokenProvider,
          object : BeamsCallback<Void, PusherCallbackError> {
            override fun onFailure(error: PusherCallbackError) {
              Log.e("BeamsAuth", "Could not login to Beams: ${error.message}");
            }

            override fun onSuccess(vararg values: Void) {
              Log.i("BeamsAuth", "Beams login success");
              PushNotifications.setOnMessageReceivedListenerForVisibleActivity(reactContext.getCurrentActivity(), object: PushNotificationReceivedListener {
                override fun onMessageReceived(remoteMessage: RemoteMessage) {
                  val map: WritableMap = WritableNativeMap()
                  val notification: RemoteMessage.Notification? = remoteMessage.getNotification()
                  if (notification != null) {
                    map.putString("body", notification.getBody())
                    map.putString("title", notification.getTitle())
                    map.putString("tag", notification.getTag())
                    map.putString("click_action", notification.getClickAction())
                    map.putString("icon", notification.getIcon())
                    map.putString("color", notification.getColor())
                    // map.putString("link", notification.getLink());
                    reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
                      .emit("notification" +
                        "" +
                        "" +
                        "" +
                        "" +
                        "", map)
                    // System.out.print(remoteMessage.toString());
                    Log.d("PUSHER_WRAPPER", "Notification received: " + notification.toString())
                  } else {
                    Log.d("PUSHER_WRAPPER", "No notification received")
                  }
                } })
            }
          }
        )
      }
    }

}
