//
//  GamesListViewController.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit

class GamesListViewController: UIViewController {

    private let emptySearchLabel = UILabel()
    private let searchController = UISearchController()
    private let viewModel = GamesListViewModel()
    private var activityIndicator = UIActivityIndicatorView()
    lazy var gamesListCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: gameListViewFlowLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        loadGames()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }

// MARK: Setup UI

    private func setupUI() {
        setupContainerView()
        setupGamesListCollectionView()
        setupSearchController()
        setupActivityIndicator()
        setupEmptySearchLabel()
    }

    private func setupContainerView() {
        view.backgroundColor = AppTheme.shared.gamesBackgroundColor
    }

    private func setupGamesListCollectionView() {
        view.addSubview(gamesListCollectionView)
        gamesListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gamesListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gamesListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gamesListCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gamesListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        gamesListCollectionView.register(GameListTableCell.self, forCellWithReuseIdentifier: "\(GameListTableCell.self)")
        gamesListCollectionView.dataSource = self
        gamesListCollectionView.delegate = self
        gamesListCollectionView.backgroundColor = .white
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Localization.GamesList.searchBarPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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

    private func setupEmptySearchLabel() {
        view.addSubview(emptySearchLabel)
        emptySearchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptySearchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            emptySearchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        emptySearchLabel.textColor = .black
        emptySearchLabel.font = .get(font: .medium(size: 18))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.91
    }


    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - View Model - Binding & init

extension GamesListViewController {

    func setupViewModel() {
        viewModel.showAlertAction = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(title: nil, message: errorMessage)
            }
        }

        viewModel.reloadGamesTableAction = { [weak self] newIndices in
            DispatchQueue.main.async {
                if let newIndices = newIndices {
                    self?.gamesListCollectionView.insertItems(at: newIndices)
                } else {
                    self?.gamesListCollectionView.reloadData()
                }
                self?.updateActivityIndicator()
            }
        }
    }

    private func loadGames() {
        viewModel.fetchMoreGames()
        updateActivityIndicator()
    }

    private func updateActivityIndicator() {
        if viewModel.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    private func gameListViewFlowLayout () -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2.0
        layout.minimumLineSpacing = 8.0
        return layout
    }
}

//MARK: -  CollectionView DataSource & Delegate
extension GamesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.games.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GameListTableCell.self)",
                                                       for: indexPath) as? GameListTableCell else {return UICollectionViewCell()}
        cell.updateUI(with: viewModel.games [indexPath.row],
                      indexPath: indexPath,
                      isSelected: viewModel.didUserOpenGame(at: indexPath.row))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userDidOpenGame(at: indexPath.row)
        openDetailsScreen(for: viewModel.games [indexPath.row])
        collectionView.reloadItems(at: [indexPath])
    }
}

extension GamesListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: 0.44 * view.frame.width, height: 0.32 * view.frame.height)
        } else {
            return CGSize(width: view.frame.width, height: 0.166 * view.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if UIDevice.current.orientation.isLandscape {
            return .init(top: safeAreaInsets.top,
                         left: safeAreaInsets.left,
                         bottom: safeAreaInsets.bottom,
                         right: safeAreaInsets.right)
        } else {
            return .zero
        }
    }
}

extension GamesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, (filter.count > 3) else {
            return
        }
        viewModel.setSearchTitle(filter)
        loadGames()
    }
}

//MARK: -  Pagination
extension GamesListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            loadGames()
        }
    }
}

//MARK: -  Navigation
extension GamesListViewController {
    private func openDetailsScreen(for game: Game) {
            let detailsViewController = GameDetailsViewController(viewModel:
                                                                    GameDetailsViewModel(selectedGame: game))
            navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
