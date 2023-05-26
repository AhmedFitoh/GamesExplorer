//
//  FavouritesListViewController.swift
//  GamesExplorer
//
//  Created by Ahmed Fitoh on 26/05/2023.
//

import UIKit

class FavouritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
// MARK: Setup UI
    private func setupUI() {
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
