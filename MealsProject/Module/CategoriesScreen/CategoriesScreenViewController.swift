//
//  CategoriesScreenViewController.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//

import UIKit

protocol ICategoriesScreenView: AnyObject
{
    func updateCategoryCollection()
    func updateMealsTable()
    func showAlert(message: String)
}

final class CategoriesScreenViewController: UIViewController
{
    private let presenter: ICategoriesScreenPresenter
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let tableview: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    init(presenter: ICategoriesScreenPresenter) {
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
        self.configureCollection()
        self.makeConstraints()
    }
}

extension CategoriesScreenViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getMealsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: MealListScreenCell.indentifier, for: indexPath) as? MealListScreenCell else { return UITableViewCell() }
        self.presenter.configureMealListCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension CategoriesScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.showMealFull(indexPath: indexPath)
    }
}

extension CategoriesScreenViewController: ICategoriesScreenView
{
    func updateCategoryCollection() {
        self.collectionView.reloadData()
    }
    
    func updateMealsTable() {
        self.tableview.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleRequestError, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

private extension CategoriesScreenViewController
{
    private func configureNavigationBar() {
        self.navigationItem.title = Constants.titleCategoriesName
        self.view.backgroundColor = ConstantsCorol.mainGreyColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: Constants.tabBarBackgroundImageName), for: UIBarMetrics.default)
    }
    
    private func configureTableView() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(MealListScreenCell.self, forCellReuseIdentifier: MealListScreenCell.indentifier)
        self.tableview.contentInsetAdjustmentBehavior = .never
        self.tableview.separatorStyle = .none
    }
    
    private func configureCollection() {
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = true
        self.collectionView.register(CategoryScreenCell.self, forCellWithReuseIdentifier: CategoryScreenCell.identifier)
    
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(collectionView.snp.width).multipliedBy(0.5)
        }
    }
    
    private func addSubviews() {
        self.view.addSubview(self.tableview)
    }
    
    private func makeConstraints() {
        self.tableview.snp.makeConstraints { make in
            make.top.equalTo(self.collectionView.snp.bottom)
            make.left.bottom.right.equalTo(self.view)
        }
    }
}

extension CategoriesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getCategoryCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryScreenCell.identifier, for: indexPath) as? CategoryScreenCell else { return UICollectionViewCell() }
        
        presenter.configureCategoryCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeW = UIScreen.main.bounds.width
        let sizeH = sizeW * 0.5
        return CGSize(width: sizeW, height: sizeH)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let selecteedCategory = collectionView.visibleCells.first {
            guard let index = collectionView.indexPath(for: selecteedCategory) else { return }
            self.presenter.selecteedCategory(indexPath: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
