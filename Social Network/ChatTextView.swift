import UIKit

final class ChatTextView: UITextView {

    private let customActions: [Selector] = [
        #selector(translateSelected(_:)),
        #selector(commentSelected(_:)),
        #selector(lookUpSelected(_:)),
        #selector(addSelectedToDictionary(_:))
    ]

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return customActions.contains(action)
    }

    @objc private dynamic func translateSelected(_ sender: Any) {
        extractWord(notification: .translateSelected)
    }

    @objc private dynamic func commentSelected(_ sender: Any) {
        extractWord(notification: .commentSelected)
    }

    @objc private dynamic func lookUpSelected(_ sender: Any) {
        extractWord(notification: .lookUpSelected)
    }

    @objc private dynamic func addSelectedToDictionary(_ sender: Any) {
        extractWord(qos: .userInitiated, notification: .addSelectedToDictionary)
    }

    private func extractWord(qos: DispatchQoS.QoSClass = .userInteractive, notification: NSNotification.Name) {
        guard let text = text, let selectedRange = _selectedTextRange else {
            return
        }

        DispatchQueue.global(qos: qos).async {
            guard let extractedWord = LanguageService.shared.extractWord(in: selectedRange, from: text) else { return }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: notification, object: extractedWord)
            }
        }
    }

}

// MARK: - Helper methods

private extension UITextInput {

    var _selectedTextRange: NSRange? {
        guard let range = selectedTextRange else { return nil }
        let location = offset(from: beginningOfDocument, to: range.start)
        let length = offset(from: range.start, to: range.end)
        return NSRange(location: location, length: length)
    }

}
