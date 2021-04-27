//
//  HWTopBarController.swift
//  swiftExample
//
//  Created by heath wang on 2021/4/27.
//  Copyright © 2021 Heath Wang. All rights reserved.
//

import Foundation
import SnapKit
import HWPopController

class HWTopBarController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We MUST set the contentSizeInPop as we want size.
        contentSizeInPop = CGSize(width: UIScreen.main.bounds.width, height: 256)
        view.backgroundColor = UIColor(red: 0.397, green: 0.859, blue: 0.066, alpha: 1.00)
        
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        view.addGestureRecognizer(tapGes)
        
        let label = UILabel()
        label.text = "I am a Notification"
        label.textAlignment = .center
        label.textColor = .white
        
        view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
    }
    
    @objc
    func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
