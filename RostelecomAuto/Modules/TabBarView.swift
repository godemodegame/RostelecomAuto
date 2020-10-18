import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            MapView(request: .nearMe)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }

            SiriView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Preferences")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .preferredColorScheme(.dark)
    }
}
