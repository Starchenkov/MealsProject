//
//  CategoryScreenCell.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 17.06.2021.
//

import UIKit
import SDWebImage

class CategoryScreenCell: UICollectionViewCell
{
    static let identifier = "CategoryScreenCell"
    
    private var categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var categoryNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 25)
        lable.textColor = .black
        lable.numberOfLines = 0
        return lable
    }()
    
    private var infoContentView: UIView = {
       let view = UIView()
        view.backgroundColor = ConstantsCorol.mainGreyColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5.0)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 2.0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryScreenCell
{
    func set(vm: CategoryCellViewModel) {
        self.categoryImage.sd_setImage(with: URL(string: vm.image), completed: nil)
        self.categoryNameLabel.text = vm.name
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.categoryImage)
        self.contentView.addSubview(self.infoContentView)
        self.infoContentView.addSubview(self.categoryNameLabel)
    }
    
    private func makeConstraints() {
        self.categoryImage.snp.makeConstraints { make in
            make.left.top.right.equalTo(self.contentView).inset(10)
        }
        
        self.infoContentView.snp.makeConstraints { make in
            make.top.equalTo(categoryImage.snp.bottom)
            make.width.equalTo(self.contentView.snp.width)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.categoryNameLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(self.infoContentView).inset(10)
        }
    }
}
