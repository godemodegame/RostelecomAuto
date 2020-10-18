import UIKit
import Intents
import IntentsUI

final class SiriShortcutViewController: UIViewController {

    // MARK: Private properties

    private let shortcut: ShortcutManager.Shortcut?

    // MARK: Lifecycle

    init(shortcut: ShortcutManager.Shortcut) {
        self.shortcut = shortcut
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSiriButton(to: view)
    }

    // MARK: Private methods

    private func addSiriButton(to view: UIView) {
        #if !targetEnvironment(macCatalyst)
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        setupShortcut(to: button)
        #endif
    }
    
    private func setupShortcut(to button: INUIAddVoiceShortcutButton?) {
        if let shortcut = shortcut {
            button?.shortcut = INShortcut(intent: shortcut.intent)
            button?.delegate = self
        }
    }
}

// MARK: - INUIAddVoiceShortcutViewControllerDelegate

extension SiriShortcutViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(
        _ controller: INUIAddVoiceShortcutViewController,
        didFinishWith _: INVoiceShortcut?,
        error: Error?
    ) {
        controller.dismiss(animated: true, completion: nil)
    }
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - INUIAddVoiceShortcutButtonDelegate

extension SiriShortcutViewController: INUIAddVoiceShortcutButtonDelegate {
    func present(
        _ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController,
        for _: INUIAddVoiceShortcutButton
    ) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }

    func present(
        _ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController,
        for _: INUIAddVoiceShortcutButton
    ) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

// MARK: - INUIEditVoiceShortcutViewControllerDelegate

extension SiriShortcutViewController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(
        _ controller: INUIEditVoiceShortcutViewController,
        didUpdate _: INVoiceShortcut?,
        error: Error?
    ) {
        controller.dismiss(animated: true, completion: nil)
    }

    func editVoiceShortcutViewController(
        _ controller: INUIEditVoiceShortcutViewController,
        didDeleteVoiceShortcutWithIdentifier _: UUID
    ) {
        controller.dismiss(animated: true, completion: nil)
    }
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
