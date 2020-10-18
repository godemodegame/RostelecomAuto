import Intents

final class ParkingRequestIntentHandler: NSObject, ParkingRequestIntentHandling {
    func handle(
        intent: ParkingRequestIntent,
        completion: @escaping (ParkingRequestIntentResponse) -> Void
    ) {
        completion(
            ParkingRequestIntentResponse(
                code: .success,
                userActivity: .none
            )
        )
    }

    func resolveAddress(
        for intent: ParkingRequestIntent,
        with completion: @escaping (INPlacemarkResolutionResult) -> Void
    ) {
        guard let address = intent.address else {
            completion(.needsValue())
            return
        }
        completion(.success(with: address))
    }
}
