import MapKit

struct Pin: Identifiable {
    let id = UUID().uuidString
    let location: CLLocation
}
