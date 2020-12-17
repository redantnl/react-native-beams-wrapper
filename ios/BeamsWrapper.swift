import PushNotifications

@objc(BeamsWrapper)
class BeamsWrapper: NSObject {
    let beamsClient = PushNotifications.shared

    @objc
    func start(instanceId: NSString) {
        self.beamsClient.start(instanceId: instanceId as String)
        self.beamsClient.registerForRemoteNotifications()
    }

    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b)
    }

    @objc(connect:withToken:withInstanceId:withAuthUrl:)
    func connect(userId: NSString, token: NSString, instanceId: NSString, authUrl: NSString) {
        print("STARTING CONNECTION")
        self.start(instanceId: instanceId);
        //self.beamsClient.start(instanceId: instanceId as String)

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
        })
        
        print("Finished connecting")
    }
}
