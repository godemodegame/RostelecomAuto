import Intents

final class ParkingNearHomeIntentHandler: NSObject, ParkingRequestNearHomeIntentHandling {
    func handle(
        intent: ParkingRequestNearHomeIntent,
        completion: @escaping (ParkingRequestNearHomeIntentResponse) -> Void
    ) {
        let response = ParkingRequestNearHomeIntentResponse(
            code: .success,
            userActivity: .none
        )
        completion(response)
    }
}
