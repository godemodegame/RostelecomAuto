import IntentsUI
import SwiftUI
import MapKit

final class IntentViewController: UIViewController {

    // MARK: Private properties

    lazy var mapViewController: UIViewController = {
        let mapVC = UIHostingController(
            rootView: IntentMap(
                coordinateRegion: MKCoordinateRegion(
                    center: coordinates,
                    latitudinalMeters: 500,
                    longitudinalMeters: 500
                ),
                parkings: parkings
            )
        )
        view.addSubview(mapVC.view)
        addChild(mapVC)
        mapVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            mapVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return mapVC
    }()

    var request: MapRequest = .nearMe
    var coordinates: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    var parkings: [Parking] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - INUIHostedViewControlling

extension IntentViewController: INUIHostedViewControlling {
    func configureView(
        for parameters: Set<INParameter>,
        of interaction: INInteraction,
        interactiveBehavior: INUIInteractiveBehavior,
        context: INUIHostedViewContext,
        completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void
    ) {
        guard let parkingRequestIntent = interaction.intent as? ParkingRequestIntent, let location = parkingRequestIntent.address?.location else {
            completion(false, parameters, desiredSize)
            return
        }
        let url = URL(string: "http://63b232058096.ngrok.io/geocontroller/coords?long=\(location.coordinate.longitude)&lat=\(location.coordinate.latitude)&max_radius=400")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            self.parkings = (try? JSONDecoder().decode([Parking].self, from: data)) ?? []
            
            self.mapViewController.view.setNeedsLayout()
            self.mapViewController.view.layoutIfNeeded()
        }.resume()
        completion(true, parameters, CGSize(width: desiredSize.width, height: 300))
    }

    var desiredSize: CGSize {
        extensionContext!.hostedViewMaximumAllowedSize
    }
}
