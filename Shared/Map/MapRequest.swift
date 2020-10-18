import MapKit

enum MapRequest {
    case nearMe
    case nearHome
    case address(_ address: CLPlacemark)
}
