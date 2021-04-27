//
//  HWBottomController.swift
//  swiftExample
//
//  Created by heath wang on 2021/4/27.
//  Copyright © 2021 Heath Wang. All rights reserved.
//

import Foundation
import SnapKit
import HWPopController

class HWBottomAuthViewController : UIViewController {
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = "Allow Your App to use Camera."
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.000, green: 0.590, blue: 1.000, alpha: 1.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6;
        
        button.addTarget(self, action: #selector(onClickAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // We MUST set the contentSizeInPop as we want size.
        let rect = UIScreen.main.bounds
        contentSizeInPop = CGSize(width: rect.width - 40, height: rect.height * 0.6)
        
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.tipLabel)
        
        self.closeButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(30)
            maker.right.equalTo(-30)
            maker.height.equalTo(60)
            maker.bottom.equalTo(-15)
        }
        
        self.tipLabel.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
    }
    
    @objc
    func onClickAction() {
        self.dismiss(animated: true) {
            
        }
    }
}
