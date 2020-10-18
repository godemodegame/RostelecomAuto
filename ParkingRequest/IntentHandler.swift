import Intents

final class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any? {
        switch intent {
        case is ParkingRequestNearMeIntent:
            return ParkingNearMeIntentHandler()
        case is ParkingRequestNearHomeIntent:
            return ParkingNearHomeIntentHandler()
        case is ParkingRequestIntent:
            return ParkingRequestIntentHandler()
        default:
            return .none
        }
    }
}
