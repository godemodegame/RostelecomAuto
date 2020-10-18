import MapKit
import Combine

final public class LocationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var pins: [Pin] = []

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }

    public func locationManager(_: CLLocationManager, didUpdateLocations _: [CLLocation]) {

    }
}
