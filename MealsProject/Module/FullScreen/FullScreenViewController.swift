//
//  FullScreenViewController.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 14.06.2021.
//

import UIKit

protocol IFullScreenView: AnyObject
{
    func set(vm: FullScreeViewModel)
    func setFavouriteImage(state inFavorites: Bool)
}

final class FullScreenViewController: UIViewController
{
    private let presenter: IFullScreenPresenter
    private let customView: FullScreenView
    
    init(presenter: IFullScreenPresenter) {
        self.presenter = presenter
        self.customView = FullScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: self)
        self.customView.delegate = self.presenter
        self.configureNavigationBar()
    }
}

extension FullScreenViewController: IFullScreenView
{
    func set(vm: FullScreeViewModel) {
        self.customView.set(vm: vm)
        self.setFavouriteImage(state: vm.inFavorites)
    }
    
    func setFavouriteImage(state inFavorites: Bool) {
        let nameImage = inFavorites ? Constants.barItemFavouriteImageFillName : Constants.barItemFavouriteImageEmptyName
        let rightBarItem = UIBarButtonItem(image: UIImage(systemName: nameImage), style: .done, target: self, action: #selector(self.favoritesButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
}

private extension FullScreenViewController
{
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = ConstantsCorol.mainYellowColor
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: Constants.barItemBackImageName), style: .done, target: self, action: #selector(self.closeTapped))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func closeTapped() {
        self.presenter.close()
    }
    
    @objc private func favoritesButtonTapped() {
        self.presenter.saveInFavorite()
    }
}
