//
//  FoodDetailViewController.swift
//  Besteats
//
//  Created by BH on 2022/02/28.
//

import UIKit

import SnapKit

class FoodDetailViewController: UIViewController {
    
    // MARK: Properties
    lazy var typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var likeTypeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var curiousTypeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    lazy var TypeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        setUpUI()
        
    }
    
    // MARK: Methods
    
    private func setUpUI() {
        
    }

}
