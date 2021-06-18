//
//  FavouriteScreenCell.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 15.06.2021.
//

import UIKit
import SDWebImage

class FavouriteScreenCell: UITableViewCell
{
    static let indentifier = "FavouriteScreenCell"
    
    private var infoContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 1, height: 5.0)
        view.layer.shadowOpacity = 0.15
        view.layer.shadowRadius = 2.0
        return view
    }()
    
    private var mealImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var mealNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var mealCategoryLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = .gray
        lable.numberOfLines = 1
        return lable
    }()
    
    private var mealAreaLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.textColor = .gray
        lable.numberOfLines = 1
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = ConstantsCorol.mainGreyColor
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavouriteScreenCell
{
    func set(vm: FavouriteCellViewModel) {
        self.mealImage.sd_setImage(with: URL(string: vm.image), completed: nil)
        self.mealNameLabel.text = vm.name
        self.mealAreaLabel.text = vm.area
        self.mealCategoryLabel.text = vm.category
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.infoContentView)
        self.infoContentView.addSubview(self.mealImage)
        self.infoContentView.addSubview(self.mealNameLabel)
        self.infoContentView.addSubview(self.mealCategoryLabel)
        self.infoContentView.addSubview(self.mealAreaLabel)
    }
    
    private func makeConstraints() {
        self.infoContentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview()
        }

        self.mealImage.snp.makeConstraints { make in
            make.top.leading.equalTo(self.infoContentView).inset(10)
            make.height.width.equalTo(self.infoContentView.snp.width).multipliedBy(0.25)
            make.bottom.equalTo(self.infoContentView.snp.bottom).inset(10)
        }
        
        self.mealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.infoContentView.snp.top).offset(10)
            make.left.equalTo(self.mealImage.snp.right).offset(10)
            make.right.equalTo(self.infoContentView.snp.right).offset(-10)
        }
        
        self.mealCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.mealNameLabel.snp.bottom).offset(10)
            make.left.equalTo(self.mealImage.snp.right).offset(10)
        }
        
        self.mealAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.mealCategoryLabel.snp.bottom).offset(10)
            make.left.equalTo(self.mealImage.snp.right).offset(10)
        }
        
    }
}
