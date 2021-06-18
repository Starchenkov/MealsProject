//
//  RandomScreenCell.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 13.06.2021.
//

import UIKit
import SDWebImage

class RandomScreenCell: UITableViewCell
{
    static let indentifier = "RandomScreenCell"
    
    private var mealImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var mealNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 30)
        lable.textColor = .black
        lable.numberOfLines = 0
        return lable
    }()
    
    private var mealCategoryLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 22)
        lable.textColor = .gray
        lable.numberOfLines = 0
        return lable
    }()
    
    private var mealAreaLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 22)
        lable.textColor = .gray
        lable.numberOfLines = 0
        return lable
    }()
    
    private var infoContentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 1, height: 5.0)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 2.0
        return view
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

extension RandomScreenCell
{
    func set(vm: RandomCellViewModel) {
        self.mealImage.sd_setImage(with: URL(string: vm.image), completed: nil)
        self.mealNameLabel.text = vm.name
        self.mealAreaLabel.text = vm.area
        self.mealCategoryLabel.text = vm.category
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.mealImage)
        self.contentView.addSubview(self.mealNameLabel)
        self.contentView.addSubview(self.infoContentView)
        self.infoContentView.addSubview(self.mealCategoryLabel)
        self.infoContentView.addSubview(self.mealAreaLabel)
    }
    
    private func makeConstraints() {
        self.mealImage.snp.makeConstraints { make in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(self.contentView.snp.width)
        }
        
        self.mealNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mealImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.contentView).inset(20)
            make.height.equalTo(self.mealImage.snp.height).multipliedBy(0.2)
           
        }
        
        self.infoContentView.snp.makeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom).offset(10)
            make.width.equalTo(self.contentView.snp.width)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(20)
        }
        
        self.mealCategoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.mealAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(mealCategoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
