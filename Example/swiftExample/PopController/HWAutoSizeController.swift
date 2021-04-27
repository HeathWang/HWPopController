//
//  HWAutoSizeController.swift
//  swiftExample
//
//  Created by heath wang on 2021/4/27.
//  Copyright © 2021 Heath Wang. All rights reserved.
//

import Foundation
import SnapKit
import HWPopController

class HWAutoSizeController: UIViewController {
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "The UIViewController class defines the shared behavior that is common to all view controllers. You rarely create instances of the UIViewController class directly. Instead, you subclass UIViewController and add the methods and properties needed to manage the view controller's view hierarchy."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var growButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Grow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.000, green: 0.590, blue: 1.000, alpha: 1.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6;
        
        button.addTarget(self, action: #selector(growAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentSizeInPop = CGSize(width: UIScreen.main.bounds.width - 80, height: 80)
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(growButton)
        
        contentView.snp.makeConstraints { (maker) in
            maker.left.top.bottom.equalTo(0)
            maker.width.equalTo(contentSizeInPop.width)
        }
        
        label.snp.makeConstraints { (maker) in
            maker.left.equalTo(15)
            maker.right.equalTo(-15)
            maker.top.equalTo(10)
        }
        
        growButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(15)
            maker.right.equalTo(-15)
            maker.height.equalTo(46)
            maker.top.equalTo(label.snp_bottomMargin).offset(20)
        }
        
        // auto size.
        view.layoutIfNeeded()
        let height = growButton.frame.maxY + 10
        contentSizeInPop = CGSize(width: self.contentSizeInPop.width, height: height)
    }
    
    @objc func growAction() {
        label.text = "\(label.text ?? "")" + "\nShow me the Code."
        
        view.layoutIfNeeded()
        let height = growButton.frame.maxY + 10
        contentSizeInPop = CGSize(width: self.contentSizeInPop.width, height: height)
    }
}
