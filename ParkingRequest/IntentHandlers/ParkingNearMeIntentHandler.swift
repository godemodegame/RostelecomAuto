import Intents

final class ParkingNearMeIntentHandler: NSObject, ParkingRequestNearMeIntentHandling {
    func handle(
        intent: ParkingRequestNearMeIntent,
        completion: @escaping (ParkingRequestNearMeIntentResponse) -> Void
    ) {
        completion(
            ParkingRequestNearMeIntentResponse(
                code: .success,
                userActivity: .none
            )
        )
    }
}
