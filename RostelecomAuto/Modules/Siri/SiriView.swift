import SwiftUI
import IntentsUI

struct SiriView: View {
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                SiriButtonView(shortcut: .nearHome)
                    .frame(height: 100)

                SiriButtonView(shortcut: .nearMe)
                    .frame(height: 100)

                SiriButtonView(shortcut: .address)
                    .frame(height: 100)

                Spacer()
            }.padding()
        }
    }
}

struct SiriView_Previews: PreviewProvider {
    static var previews: some View {
        SiriView()
    }
}
