//
//  FoodTypeCollectionViewCell.swift
//  Besteats
//
//  Created by BH on 2022/06/22.
//

import UIKit

import SnapKit

protocol CellActionDelegate: AnyObject {
    
    func starButtonTapped(cell: RecommendFoodCell)
    
}

class RecommendFoodCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var cellDelegate: CellActionDelegate?
    
    // MARK: - UIProperties
    
    lazy var unsplashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Style.cornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.alpha = Style.alpha
        view.backgroundColor = .black
        view.layer.cornerRadius = Style.cornerRadius
        return view
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(Style.starImage, for: .normal)
        button.setImage(Style.selectedStarImage, for: .selected)
        button.tintColor = .yellow
        return button
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
        
        self.starButton.addTarget(
            self,
            action: #selector(starTapped),
            for: .touchUpInside
        )
    }
    
    @available(*, unavailable, message: "This initializer is not available.")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureConstraints()
        
    }
    
    @objc func starTapped() {
        cellDelegate?.starButtonTapped(cell: self)
    }
    
}

// MARK: - Layout extension

extension RecommendFoodCell {
    
    func setupImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.unsplashImageView.image = image
        }
    }
    
    func setupCell() {
        unsplashImageView.image = UIImage(named: "WesternFood")
        
        // TODO: [] 공공데이터 
//        unsplashImageView.load(url: URL(string: "https://ukcooyocdlvo8099722.cdn.ntruss.com/public_data/menu_images/1446334_1638842685_menu.png")!)
    }
    
    private func configureUI() {
        [unsplashImageView,
         topView,
         starButton].forEach { self.addSubview($0) }
    }
    
    private func configureConstraints() {
        unsplashImageView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
        }
        
        topView.snp.makeConstraints {
            $0.top.trailing.equalTo(unsplashImageView)
            $0.width.height.equalTo(Style.alphaViewHeight)
        }
        
        starButton.snp.makeConstraints {
            $0.center.equalTo(topView)
            $0.width.equalTo(Style.buttonHeight)
        }
    }
    
}

// MARK: - NameSpaces

extension RecommendFoodCell {
    
    private enum Style {
        static let padding: CGFloat = 16
        static let leadingPadding: CGFloat = 8
        static let trailingPadding: CGFloat = -8
        static let cornerRadius: CGFloat = 10
        static let alpha: CGFloat = 0.7
        static let alphaViewHeight: CGFloat = 48
        static let buttonHeight: CGFloat = 44
        
        static let starImage = UIImage(systemName: "star")
        static let selectedStarImage = UIImage(systemName: "star.fill")
    }
    
}
