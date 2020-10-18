import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {

    @ObservedObject var viewModel: MapViewModel

    init(request: MapRequest) {
        viewModel = MapViewModel(request: request)
    }

    var body: some View {
        Map(
            coordinateRegion: $viewModel.coordinateRegion,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $viewModel.tracking,
            annotationItems: viewModel.parkings,
            annotationContent: { parking in
                MapAnnotation(
                    coordinate: CLLocationCoordinate2D(
                        latitude: parking.lat,
                        longitude: parking.long
                    )
                ) {
                    ZStack {
                        Circle()
                            .foregroundColor(.blue)
                        
                        Text("\(parking.free_places)")
                            .padding()
                    }
                }
            }
        )
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.viewModel.fetchParkings()
        }
    }
}
