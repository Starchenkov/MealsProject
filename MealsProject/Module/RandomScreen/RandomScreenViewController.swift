//
//  RandomScreenViewController.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit

protocol IRandomScreenView: AnyObject
{
    func updateUI()
    func showAlert(message: String)
}

final class RandomScreenViewController: UIViewController
{
    private let presenter: IRandomScreenPresenter
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    init(presenter: IRandomScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.presenter.viewDidLoad(view: self)
        self.configureNavigationBar()
        self.configureTableView()
        self.addSubviews()
        self.makeConstraints()
    }
}

extension RandomScreenViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getCountMealsRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: RandomScreenCell.indentifier, for: indexPath) as? RandomScreenCell else { return UITableViewCell() }
        self.presenter.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension RandomScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.showMealFull(indexPath: indexPath)
    }
}

extension RandomScreenViewController: IRandomScreenView
{
    func updateUI() {
        self.tableview.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleRequestError, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

private extension RandomScreenViewController
{
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func configureTableView() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(RandomScreenCell.self, forCellReuseIdentifier: RandomScreenCell.indentifier)
        self.tableview.contentInsetAdjustmentBehavior = .never
        self.tableview.separatorStyle = .none
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.tapRefreshTable(sender:)), for: .valueChanged)
        self.tableview.refreshControl = refreshControl
    }
    
    @objc private func tapRefreshTable(sender: UIRefreshControl) {
        sender.endRefreshing()
        self.presenter.showNewRandom()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.tableview)
    }
    
    private func makeConstraints() {
        self.tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
