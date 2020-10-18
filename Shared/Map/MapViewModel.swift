import SwiftUI
import MapKit
import Combine

final class MapViewModel: ObservableObject {
    @Published var coordinateRegion: MKCoordinateRegion
    @Published var tracking: MapUserTrackingMode
    let manager = CLLocationManager()
    let managerDelegate = LocationDelegate()

    @Published var parkings: [Parking] = []

    private var cancellableSet: Set<AnyCancellable> = []

    init(request: MapRequest) {
        manager.delegate = managerDelegate
        coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 55.812785087524446, longitude: 37.62362480163575),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        switch request {
        case .address(let address):
            if let coordinate = address.location?.coordinate {
                coordinateRegion = MKCoordinateRegion(
                    center: coordinate,
                    latitudinalMeters: 500,
                    longitudinalMeters: 500
                )
            }
            tracking = .none
        default:
            if let coordinate = manager.location?.coordinate {
//                coordinateRegion = MKCoordinateRegion(
//                    center: coordinate,
//                    latitudinalMeters: 500,
//                    longitudinalMeters: 500
//                )
            }
            tracking = .follow
        }
    }

    func fetchParkings() {
        let coordinate = coordinateRegion.center
        cancellableSet.insert(
            RostelecomAutoAPI.parkings(
                longitude: "\(coordinate.longitude)",
                latitude: "\(coordinate.latitude)"
            ).sink(
                receiveCompletion: { status in
                    print(status)
                },
                receiveValue: { response in
                    print(response)
                    self.parkings = response
                }
            )
        )
    }
}
