//
//  FavouriteScreenViewController.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

protocol IFavouriteScreenView: AnyObject
{
    func updateUI()
}

final class FavouriteScreenViewController: UIViewController
{
    private let presenter: IFavouriteScreenPresenter
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    init(presenter: IFavouriteScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureTableView()
        self.addSubviews()
        self.makeConstraints()
        presenter.viewDidLoad(view: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewDidLoad(view: self)
    }
}

extension FavouriteScreenViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getCountFavouriteMeals()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: FavouriteScreenCell.indentifier, for: indexPath) as? FavouriteScreenCell else { return UITableViewCell() }
        self.presenter.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension FavouriteScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.showMealFull(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.deleteActionTitle) { _, _, _ in
            self.presenter.removeFavouriteMeal(at: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension FavouriteScreenViewController: IFavouriteScreenView
{
    func updateUI() {
        self.tableview.reloadData()
    }
}

private extension FavouriteScreenViewController
{
    private func addSubviews() {
        self.view.addSubview(self.tableview)
    }
    
    private func makeConstraints() {
        self.tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = Constants.titleFavouriteName
        self.view.backgroundColor = ConstantsCorol.mainGreyColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Constants.tabBarBackgroundImageName), for: UIBarMetrics.default)
    }
    
    private func configureTableView() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.backgroundColor = ConstantsCorol.mainGreyColor
        self.tableview.register(FavouriteScreenCell.self, forCellReuseIdentifier: FavouriteScreenCell.indentifier)
        self.tableview.contentInsetAdjustmentBehavior = .never
        self.tableview.separatorStyle = .none
    }
}
