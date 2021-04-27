//
//  HWNavigationController.swift
//  swiftExample
//
//  Created by heath wang on 2021/4/27.
//  Copyright © 2021 Heath Wang. All rights reserved.
//

import Foundation
import SnapKit
import HWPopController

class HWNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = UIScreen.main.bounds
        contentSizeInPop = CGSize(width: rect.width - 60, height: rect.height * 0.6)
        contentSizeInPopWhenLandscape = CGSize(width: rect.height - 100, height: rect.width * 0.6)
    }
}

class HWBaseChildController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "When you use UINavigationController in HWPopController, You can dynamic change the pop size."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.000, green: 0.590, blue: 1.000, alpha: 1.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6;
        
        button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let index = navigationController?.viewControllers.firstIndex(of: self) {
            self.navigationItem.title = "Page \(index)"
        }
        
        view.addSubview(label)
        view.addSubview(nextButton)
        
        label.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.right.equalTo(-20)
            maker.centerY.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalTo(0)
            maker.height.equalTo(55)
        }
        
        
    }
    
    @objc
    func clickAction() {
        let child = HWChild1Controller()
        self.navigationController?.pushViewController(child, animated: true)
    }
}

class HWChild1Controller: HWBaseChildController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Next page is here."
        
        if let index = navigationController?.viewControllers.firstIndex(of: self) {
            if index > 0 {
                let barItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissAction))
                navigationItem.rightBarButtonItem = barItem
            }
        }
    }
    
    @objc
    func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
