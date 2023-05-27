//
//  FavouritesListViewController.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit

class FavouritesListViewController: UIViewController {

    private let favouritesListTableView = UITableView()
    private let emptyFavouritesLabel = UILabel()
    private let viewModel = FavouritesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFavouritesList()
    }

    private func refreshFavouritesList() {
        viewModel.retrieveFavourites {[weak self] isFavouritesListEmpty in
            guard let self = self else {return}
            if isFavouritesListEmpty {
                self.favouritesListTableView.isHidden = true
                self.emptyFavouritesLabel.isHidden = false
                self.navigationItem.title = Localization.FavouritesList.screenTitle
            } else {
                self.favouritesListTableView.isHidden = false
                self.emptyFavouritesLabel.isHidden = true
                self.navigationItem.title = "\(Localization.FavouritesList.screenTitle) (\(self.viewModel.favourites.count))"
                self.favouritesListTableView.reloadData()
            }
        }
    }
    
// MARK: Setup UI
    private func setupUI() {
        setupContainerView()
        setupFavouritesListTableView()
        setupEmptyFavouritesLabel()
        setupNavigationController()
    }

    private func setupContainerView() {
        view.backgroundColor = .white
    }

    private func setupFavouritesListTableView() {
        view.addSubview(favouritesListTableView)
        favouritesListTableView.frame = self.view.bounds
        favouritesListTableView.register(FavouritesListCell.self,
                                         forCellReuseIdentifier: "\(FavouritesListCell.self)")
        favouritesListTableView.dataSource = self
        favouritesListTableView.delegate = self
        favouritesListTableView.backgroundColor = .white
    }

    private func setupEmptyFavouritesLabel() {
        view.addSubview(emptyFavouritesLabel)
        emptyFavouritesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyFavouritesLabel.topAnchor.constraint(equalTo: favouritesListTableView.centerYAnchor),
            emptyFavouritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        emptyFavouritesLabel.textColor = .black
        emptyFavouritesLabel.font = .get(font: .medium(size: 18))
        emptyFavouritesLabel.text = Localization.FavouritesList.emptyFavouritesLabel
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: -  TableView Data source & delegate
extension FavouritesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameListTableCell.rowHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(FavouritesListCell.self)",
                                                       for: indexPath) as? FavouritesListCell else {return UITableViewCell()}
        cell.updateUI(with: viewModel.favourites [indexPath.row],
                      indexPath: indexPath)
        return cell
    }
}


extension FavouritesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        showRemoveFromFavouritesAlert(for: viewModel.favourites [indexPath.row])
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}


extension FavouritesListViewController {
    private func showRemoveFromFavouritesAlert(for game: Game) {
        let tailoredAlert = String(format: Localization.FavouritesList.removeFromFavouritesAlert,
                                   arguments: [game.name ?? ""])

        self.showAlert(title: nil,
                       message: tailoredAlert) {[unowned self] _ in
            self.viewModel.removeFromFavourites(id: game.id) {
                self.refreshFavouritesList()
            }
        }
    }
}
