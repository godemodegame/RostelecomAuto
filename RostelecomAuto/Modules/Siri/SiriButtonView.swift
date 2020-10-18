import SwiftUI

struct SiriButtonView: UIViewControllerRepresentable {
    let shortcut: ShortcutManager.Shortcut

    func makeUIViewController(context: Context) -> SiriShortcutViewController {
        SiriShortcutViewController(shortcut: shortcut)
    }

    func updateUIViewController(_ uiViewController: SiriShortcutViewController, context: Context) {

    }
}
