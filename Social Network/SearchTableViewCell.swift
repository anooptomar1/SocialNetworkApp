import UIKit

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var onlineLabel: UILabel!
    @IBOutlet private weak var languagesStackView: UIStackView!

    func configure(with user: User) {
        if true {
            nameLabel.isHidden = false
            nameLabel.text = "Lorem Ipsum"
        }

        if let name = user.name {
            nameLabel.isHidden = false
            nameLabel.text = name
        }

        if let country = user.country?.localized {
            countryLabel.isHidden = false
            countryLabel.text = country
        }

        onlineLabel.isHidden = !user.online!

        if let languages = user.languages {
            languagesStackView.isHidden = false
            for subview in languagesStackView.arrangedSubviews {
                languagesStackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
            for language in languages {
                let stackView = makeStackView(for: language)
                languagesStackView.addArrangedSubview(stackView)
            }
        }
    }

    private func makeStackView(for language: Language) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally

        let nameLabel = UILabel()
        nameLabel.text = language.name.localized
        nameLabel.font = countryLabel.font
        stackView.addArrangedSubview(nameLabel)

        let levelLabel = UILabel()
        levelLabel.text = language.level.localized
        levelLabel.font = countryLabel.font
        levelLabel.textColor = .darkGray
        stackView.addArrangedSubview(levelLabel)

        return stackView
    }

}
