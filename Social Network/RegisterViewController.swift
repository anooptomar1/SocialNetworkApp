import UIKit

final class RegisterViewController: UIViewController {

    // MARK: - Typealiases

    private typealias Key = ClientConstants.ParameterKeys

    // MARK: - IBOutlets

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signupButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    // MARK: - Private properties

    private let client = SocialNetworkClient.default

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        indicator.isHidden = true
    }

    // MARK: - IBActions

    @IBAction private func signup(_ sender: Any) {
        setUI(enabled: false)
        
        func warn(with warning: WarningMessage) {
            warningLabel.text = warning.rawValue
            setUI(enabled: true)
        }
        
        func validate(string: String, pattern: ValidationPattern) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern.rawValue)
            return predicate.evaluate(with: string)
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
            validate(string: name, pattern: .name) else {
            warn(with: .incorrectName)
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
            validate(string: email, pattern: .email) else {
            warn(with: .incorrectEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
            validate(string: password, pattern: .password) else {
            warn(with: .weakPassword)
            return
        }
        
        let parameters = [
            Key.Name: name,
            Key.Email: email,
            Key.Password: password
        ]
        
        client.register(parameters: parameters) { [weak self] response in
            guard let response = response, response == .success else {
                warn(with: .unknownError)
                return
            }

            guard let this = self else {
                return
            }

            guard let vc = this.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.CompleteRegister) else {
                return
            }

            this.present(vc, animated: true) {
                //this.dismiss(animated: false, completion: nil)
            }
        }
    }

    @IBAction private func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    private func setUI(enabled: Bool) {
        DispatchQueue.main.async {
            self.signupButton.isEnabled = enabled
            self.signupButton.isHidden = !enabled
            self.cancelButton.isEnabled = enabled
            self.warningLabel.isHidden = !enabled
            self.indicator.isHidden = enabled
            self.nameTextField.isEnabled = enabled
            self.emailTextField.isEnabled = enabled
            self.passwordTextField.isEnabled = enabled
        }
    }

}
