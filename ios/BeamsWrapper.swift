import PushNotifications

@objc(BeamsWrapper)
class BeamsWrapper: NSObject {
    private var beamsClient = PushNotifications.shared
    private static var instance: PushNotifications?

    @objc(withInstanceId:)
    func startInstance(instanceId: NSString) {
        //[[PushNotifications,
          //shared] startWithInstanceId:@"4f758dae-7fb9-4314-8341-ff82ccd2b731"]        instance = PushNotifications(instanceId: instanceId as String)
        // instanceIdinstance?.start()
        
    }
    
    public func setDeviceToken(deviceToken: NSData, instanceId: String) {
        self.beamsClient.start(instanceId: instanceId);
        self.beamsClient.registerForRemoteNotifications();
        try? self.beamsClient.addDeviceInterest(interest: "test")
    }
    
    public func handleNotification(userInfo: NSDictionary) {
        NSLog("%@", userInfo);
    }
    

    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b)
    }

    @objc(connect:withToken:withInstanceId:withAuthUrl:)
    func connect(userId: NSString, token: NSString, instanceId: NSString, authUrl: NSString) {
        print("Starting connect with: ", userId, token, instanceId, authUrl)
        //self.start(instanceId: instanceId);
        //self.beamsClient.start(instanceId: instanceId as String)

        self.beamsClient.start(instanceId: instanceId as String)
        self.beamsClient.registerForRemoteNotifications()
//        self.beamsClient.registerDeviceToken(<#T##deviceToken: Data##Data#>)
        
        let tokenProvider = BeamsTokenProvider(authURL: authUrl as String) { () -> AuthData in
            let sessionToken = token as String
            let headers = ["Authorization": "Bearer \(sessionToken)"] // Headers your auth endpoint needs
            let queryParams: [String: String] = [:] // URL query params your auth endpoint needs
            return AuthData(headers: headers, queryParams: queryParams)
        }       

        self.beamsClient.setUserId(userId as String, tokenProvider: tokenProvider, completion: { error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }

            print("Successfully authenticated with Pusher Beams")
        });
        
        print("Finished connecting")
    }
}
