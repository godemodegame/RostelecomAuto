import SwiftUI
import MapKit

struct IntentMap: View {

    @State var coordinateRegion: MKCoordinateRegion
    var parkings: [Parking]

    var body: some View {
        Map(
            coordinateRegion: $coordinateRegion,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: .none,
            annotationItems: parkings,
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
    }
}
