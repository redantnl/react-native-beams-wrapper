import PushNotifications

@objc(BeamsWrapper)
class BeamsWrapper: NSObject {
    let beamsClient = PushNotifications.shared

    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b)
    }

    @objc
    func connect(userId: String, token: String, instanceId: String, authUrl: String) {
        self.beamsClient.start(instanceId: instanceId)

        let tokenProvider = BeamsTokenProvider(authURL: authUrl) { () -> AuthData in
            let sessionToken = token
            let headers = ["Authorization": "Bearer \(sessionToken)"] // Headers your auth endpoint needs
            let queryParams: [String: String] = [:] // URL query params your auth endpoint needs
            return AuthData(headers: headers, queryParams: queryParams)
        }

        self.beamsClient.setUserId(userId, tokenProvider: tokenProvider, completion: { error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }

            print("Successfully authenticated with Pusher Beams")
        })
    }
}
