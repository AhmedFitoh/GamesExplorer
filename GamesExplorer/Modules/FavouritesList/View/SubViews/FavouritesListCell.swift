//
//  FavouritesListCell.swift
//  GamesExplorer
//
//  Created by AhmedFitoh on 6/2/23.
//

import Foundation
import UIKit

class FavouritesListCell: UITableViewCell {

    static let rowHeight: CGFloat = 136

    private let padding: CGFloat = 16
    private let gameImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingValueLabel = UILabel()
    private let ratingKeyLabel = UILabel()
    private let genreLabel = UILabel()
    private let containerLabelsStackView = UIStackView()
    private let ratingStackView = UIStackView()
    private let bottomStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension FavouritesListCell {
    
    private func setupUI() {
        [gameImageView,
        titleLabel,
        ratingValueLabel,
        ratingKeyLabel,
        genreLabel,
        containerLabelsStackView,
        ratingStackView,
         bottomStackView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false }

        setupGameImageView()
        setupContainerLabelsStackView()
        setupBottomStackView()
        setupRatingStackView()
        setupRatingValueLabel()
        setupRatingKeyLabel()
        setupGenreLabel()
        setupLabels()
    }

    private func setupContainerLabelsStackView() {
        addSubview(containerLabelsStackView)
        containerLabelsStackView.axis = .vertical
        containerLabelsStackView.distribution = .equalSpacing
        containerLabelsStackView.alignment = .leading

        containerLabelsStackView.addArrangedSubview(titleLabel)
        containerLabelsStackView.addArrangedSubview(bottomStackView)

        NSLayoutConstraint.activate([
            containerLabelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            containerLabelsStackView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: padding),
            containerLabelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            containerLabelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
         ])
    }

    private func setupBottomStackView() {
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .equalCentering
        bottomStackView.alignment = .leading
        bottomStackView.spacing = 8

        bottomStackView.addArrangedSubview(ratingStackView)
        bottomStackView.addArrangedSubview(genreLabel)
    }

    private func setupRatingStackView() {
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .fillProportionally
        ratingStackView.spacing = 3
        
        ratingStackView.addArrangedSubview(ratingKeyLabel)

        ratingKeyLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }

    private func setupRatingKeyLabel() {
        ratingKeyLabel.font = .get(font: .medium(size: 14))
        ratingKeyLabel.attributedText = NSMutableAttributedString(string: "metacritic:", attributes: [NSAttributedString.Key.kern: 0.38])
    }

    private func setupRatingValueLabel() {
        ratingStackView.addArrangedSubview(ratingValueLabel)
        ratingValueLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        ratingValueLabel.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.kern: 0.38])
        ratingValueLabel.textColor = UIColor(red: 0.843, green: 0, blue: 0, alpha: 1)
        ratingValueLabel.font = .get(font: .bold(size: 18))
    }

    private func setupGenreLabel() {
        genreLabel.textColor = UIColor(red: 0.541, green: 0.541, blue: 0.561, alpha: 1)
        genreLabel.font = .get(font: .regular(size: 13))
    }

    private func setupLabels() {
        if #available(iOS 13.0, *) {
            titleLabel.textColor  = UIColor.label
            ratingKeyLabel.textColor = UIColor.label
        } else {
            titleLabel.textColor = .black
            ratingKeyLabel.textColor = .black
        }
        titleLabel.font = .get(font: .bold(size: 20))
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
    }

    private func setupGameImageView() {
        addSubview(gameImageView)
        NSLayoutConstraint.activate([
            gameImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  padding),
            gameImageView.widthAnchor.constraint(equalToConstant: 120),
            gameImageView.heightAnchor.constraint(equalToConstant: 104),
        ])
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.clipsToBounds = true
    }
}

extension FavouritesListCell {
    func updateUI(with model: GameCellUIModel,
                  indexPath: IndexPath,
                  isSelected: Bool = false) {
        titleLabel.text = model.title
        genreLabel.text = model.genresText
        ratingValueLabel.text = model.ratingText
        gameImageView.loadImageUsingCache(withUrl: model.imageURL,
                                          cellIndexPathRow: indexPath.row,
                                          placeHolderImage: Constants.Images.logo)
        backgroundColor = isSelected ? AppTheme.shared.gamesSelectedBackgroundColor : .white
    }
}
