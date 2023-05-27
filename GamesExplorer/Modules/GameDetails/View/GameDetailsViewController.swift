//
//  GameDetailsViewController.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import Foundation
import UIKit

class GameDetailsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let backgroundImage = UIImageView()
    private let titleLabel = UILabel()
    private let keyGameDescriptionLabel = UILabel()
    private let valueGameDescriptionLabel = UILabel()
    private let buttonsStackView = UIStackView()
    private let redditButton = ButtonView(title: Localization.GameDetails.visitReddit, hasBottomDivider: false)
    private let websiteButton = ButtonView(title: Localization.GameDetails.visitWebsite, hasBottomDivider: true)
    private let padding: CGFloat = 16
    
    private var favoriteButton = UIBarButtonItem()
    private var activityIndicator = UIActivityIndicatorView()
    
    private let viewModel: GameDetailsViewModel
    
    init(viewModel: GameDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchGameDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }
}

// MARK: Setup UI
extension GameDetailsViewController {
    private func setupUI() {
        setupContainerView()
        setupScrollView()
        setupStackView()
        setupBackgroundImage()
        setupTitleLabel()
        setupKeyDescriptionLabel()
        setupValueDescriptionLabel()
        setupButtons()
        setupActivityIndicator()
        setupNavigationBar()
    }
    
    private func setupContainerView() {
        view.backgroundColor = .white
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBackgroundImage() {
        scrollView.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.heightAnchor.constraint(equalToConstant: 291),
            backgroundImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor) ,
            backgroundImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ])
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.image = Constants.Images.logo
        backgroundImage.addOverlay()
    }

    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -padding),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .get(font: .bold(size: 36))
        titleLabel.text = viewModel.selectedGame.name
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }

    private func setupKeyDescriptionLabel() {
        scrollView.addSubview(keyGameDescriptionLabel)
        keyGameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyGameDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            keyGameDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            keyGameDescriptionLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: padding),
            keyGameDescriptionLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        keyGameDescriptionLabel.font = .get(font: .regular(size: 17))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        keyGameDescriptionLabel.attributedText = NSMutableAttributedString(string: Localization.GameDetails.gameDescription,
                                                                           attributes: [.kern: -0.41,
                                                                                        .paragraphStyle: paragraphStyle])
    }
    
    private func setupValueDescriptionLabel() {
        scrollView.addSubview(valueGameDescriptionLabel)
        NSLayoutConstraint.activate([
            valueGameDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            valueGameDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            valueGameDescriptionLabel.topAnchor.constraint(equalTo: keyGameDescriptionLabel.bottomAnchor, constant: padding),
            
        ])
        
        valueGameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        valueGameDescriptionLabel.font = .get(font: .regular(size: 10))
        valueGameDescriptionLabel.lineBreakMode = .byWordWrapping
        valueGameDescriptionLabel.textColor =  UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        valueGameDescriptionLabel.numberOfLines = 4
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(readMoreAction))
        valueGameDescriptionLabel.addGestureRecognizer(tapGesture)
        valueGameDescriptionLabel.isUserInteractionEnabled = true
    }
    
    @objc
    private func readMoreAction() {
        if valueGameDescriptionLabel.numberOfLines == 4 {
            valueGameDescriptionLabel.numberOfLines = 0
        } else {
            valueGameDescriptionLabel.numberOfLines = 4
        }
        scrollView.setNeedsLayout()
    }

    private func setGameDescription(_ description: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        let descriptionAttributedText = NSMutableAttributedString(string: description.html2String,
                                                                  attributes: [.kern: -0.41,
                                                                               .paragraphStyle: paragraphStyle,
                                                                               .font: UIFont.get(font: .regular(size: 15))
                                                                  ])
        valueGameDescriptionLabel.attributedText = descriptionAttributedText
    }
    
    private func setupStackView() {
        scrollView.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 0
        buttonsStackView.alignment = .leading
        buttonsStackView.distribution = .fill
    }

    private func setupButtons() {
        buttonsStackView.addArrangedSubview(redditButton)
        buttonsStackView.addArrangedSubview(websiteButton)
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            buttonsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            buttonsStackView.topAnchor.constraint(equalTo: valueGameDescriptionLabel.bottomAnchor, constant: (padding * 2)),
            buttonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -(padding * 4))
        ])
        redditButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redditButtonAction)))
        websiteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteButtonAction)))
        redditButton.isHidden = true
        websiteButton.isHidden = true
    }

    private func setupActivityIndicator() {
        if #available(iOS 13, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        }
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
    }

    func setupNavigationBar() {
        favoriteButton = UIBarButtonItem(title: Localization.GameDetails.favourite,
                                         style: .plain,
                                         target: self,
                                         action: #selector(favoriteButtonAction(_:)))
        navigationItem.rightBarButtonItem = favoriteButton
        updateFavouriteButton()
    }

    private func updateFavouriteButton() {
        if viewModel.isFavourite {
            favoriteButton.title = Localization.GameDetails.favourited
        } else {
            favoriteButton.title = Localization.GameDetails.favourite
        }
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
extension GameDetailsViewController {
    
    private func fetchGameDetails(){
        activityIndicator.startAnimating()
        viewModel.fetchGameDetails {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let gameDetails):
                    self?.setGameDescription(gameDetails.gameDescription ?? "")
                    self?.backgroundImage.loadImageUsingCache(withUrl: gameDetails.backgroundImage,
                                                              placeHolderImage: Constants.Images.logo)
                    self?.updateWebsitesButtons()
                case .failure(let error):
                    self?.showAlert(title: nil, message: error.rawValue)
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func updateWebsitesButtons() {
        if let _ = viewModel.redditLink {
            redditButton.isHidden = false
        }
        if let _ = viewModel.websiteLink {
            websiteButton.isHidden = false
        }
    }
    private func showRemoveFromFavouritesAlert() {
        let tailoredAlert = String(format: Localization.FavouritesList.removeFromFavouritesAlert,
                                   arguments: [viewModel.selectedGame.name ?? ""])
        self.showAlert(title: nil,
                       message: tailoredAlert) {[unowned self] _ in
            self.viewModel.favouritesAction()
            self.updateFavouriteButton()
        }
    }
}

//MARK: - Actions
extension GameDetailsViewController {
    @objc
    func favoriteButtonAction(_ sender: UIBarButtonItem) {
        if viewModel.isFavourite {
            showRemoveFromFavouritesAlert()
        } else {
            viewModel.favouritesAction()
            updateFavouriteButton()
        }
    }
    
    @objc
    func redditButtonAction() {
        guard let url = viewModel.redditLink else { return }
        presentSafariVC(with: url)
    }
    
    @objc
    func websiteButtonAction() {
        guard let url = viewModel.websiteLink else { return }
        presentSafariVC(with: url)
    }
}
