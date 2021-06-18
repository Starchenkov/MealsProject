//
//  FullScreenView.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 14.06.2021.
//

import UIKit

protocol IFullScreenViewDelegate: AnyObject
{
    func showYoutube()
    func showSource()
}

class FullScreenView: UIView
{
    weak var delegate: IFullScreenViewDelegate?
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = ConstantsCorol.mainGreyColor
        return scroll
    }()
    
    private var contentView: UIView = {
        let content = UIView()
        return content
    }()
    
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
    
    private var ingredientsContentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 1, height: 5.0)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 2.0
        return view
    }()
    
    private var instructionContentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 1, height: 5.0)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 2.0
        return view
    }()
    
    private var ingredientsLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 18)
        lable.textColor = .gray
        lable.numberOfLines = 0
        return lable
    }()
    
    private var instructionLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 18)
        lable.textColor = .gray
        lable.numberOfLines = 0
        return lable
    }()
    
    private var youtubeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.youtubeButtonName), for: .normal)
        button.addTarget(self, action: #selector(youtubeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var sourceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.sourceButtonName), for: .normal)
        button.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FullScreenView
{
    func set(vm: FullScreeViewModel) {
        self.mealImage.sd_setImage(with: URL(string: vm.image), completed: nil)
        self.mealNameLabel.text = vm.name
        self.mealAreaLabel.text = vm.area
        self.mealCategoryLabel.text = vm.category
        self.instructionLabel.text = vm.instructions
        self.youtubeButton.isHidden = vm.youtube
        self.sourceButton.isHidden = vm.source
        self.ingredientsLabel.text = vm.ingredients
    }
    
    private func addSubviews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(self.mealImage)
        self.contentView.addSubview(self.mealNameLabel)
        self.contentView.addSubview(self.infoContentView)
        self.infoContentView.addSubview(self.mealCategoryLabel)
        self.infoContentView.addSubview(self.mealAreaLabel)
        self.infoContentView.addSubview(self.youtubeButton)
        self.infoContentView.addSubview(self.sourceButton)
        self.contentView.addSubview(self.ingredientsContentView)
        self.ingredientsContentView.addSubview(self.ingredientsLabel)
        self.contentView.addSubview(self.instructionContentView)
        self.instructionContentView.addSubview(self.instructionLabel)
    }
    
    private func makeConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView)
        }
        
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
        }
        
        self.mealCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.infoContentView).inset(10)
            make.leading.trailing.equalTo(self.infoContentView).inset(20)
        }
        
        self.mealAreaLabel.snp.makeConstraints { make in
            make.top.equalTo(mealCategoryLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.infoContentView).inset(20)
            make.bottom.equalTo(self.infoContentView).inset(10)
        }

        self.ingredientsContentView.snp.makeConstraints { make in
            make.top.equalTo(self.infoContentView.snp.bottom).offset(10)
            make.width.equalTo(self.contentView.snp.width)
        }
        
        self.ingredientsLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.ingredientsContentView).inset(10)
            make.leading.trailing.equalTo(self.ingredientsContentView).inset(20)
        }
        
        self.instructionContentView.snp.makeConstraints { make in
            make.top.equalTo(self.ingredientsContentView.snp.bottom).offset(10)
            make.width.equalTo(self.contentView.snp.width)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }

        self.instructionLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.instructionContentView).inset(10)
            make.leading.trailing.equalTo(self.contentView).inset(20)
        }
        
        self.youtubeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(self.infoContentView.snp.width).multipliedBy(0.15)
        }
        self.sourceButton.snp.makeConstraints { make in
            make.right.equalTo(self.youtubeButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(self.infoContentView.snp.width).multipliedBy(0.15)
        }
    }
    
    @objc private func youtubeButtonTapped() {
        self.delegate?.showYoutube()
    }
    
    @objc private func sourceButtonTapped() {
        self.delegate?.showSource()
    }
    
}
