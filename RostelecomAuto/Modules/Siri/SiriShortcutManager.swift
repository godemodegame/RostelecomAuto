import UIKit
import Intents

final class ShortcutManager {
    // MARK: Public properties

    static let shared = ShortcutManager()

    // MARK: Public methods

    func donate(_ intent: INIntent, id: String? = nil) {
        let interaction = INInteraction(intent: intent, response: nil)
        if let id = id {
            interaction.groupIdentifier = id
        }

        interaction.donate { error in
            if let error = error {
                print(error)
            }
        }

        if let shortcut = INShortcut(intent: intent) {
            let relevantShortcut = INRelevantShortcut(shortcut: shortcut)
            INRelevantShortcutStore.default.setRelevantShortcuts([relevantShortcut]) { error in
                if let error = error {
                    print("Error setting relevant shortcuts: \(error)")
                }
            }
        }
    }
}

// MARK: Shortcuts

extension ShortcutManager {
    enum Shortcut {
        case nearHome
        case nearMe
        case address
        
        var defaultsKey: String {
            switch self {
            case .nearHome: return "requestParkingNearHomeIntent"
            case .nearMe: return "requestParkingNearMeIntent"
            case .address: return "requestParkingIntent"
            }
        }
        
        var intent: INIntent {
            var intent: INIntent
            switch self {
            case .nearHome:
                intent = ParkingRequestNearHomeIntent()
            case .nearMe:
                intent = ParkingRequestNearMeIntent()
            case .address:
                intent = ParkingRequestIntent()
            }
            intent.suggestedInvocationPhrase = suggestedInvocationPhrase
            return intent
        }

        var suggestedInvocationPhrase: String {
            switch self {
            case .nearHome: return "Найди парковку рядом с домом"
            case .nearMe: return "Найди парковку рядом со мной"
            case .address: return "Найди парковку"
            }
        }

        func donate() {
            let interaction = INInteraction(intent: self.intent, response: nil)

            interaction.donate { error in
                if let error = error {
                    print(error)
                }
            }
            
            if let shortcut = INShortcut(intent: intent) {
                let relevantShortcut = INRelevantShortcut(shortcut: shortcut)
                INRelevantShortcutStore.default.setRelevantShortcuts([relevantShortcut]) { error in
                    if let error = error {
                        print("Error setting relevant shortcuts: \(error)")
                    }
                }
            }
        }
    }
}
