//
//  HWFullDialogController.swift
//  swiftExample
//
//  Created by heath wang on 2021/4/27.
//  Copyright © 2021 Heath Wang. All rights reserved.
//

import Foundation
import SnapKit
import HWPopController

class HWFullDialogController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We MUST set the contentSizeInPop as we want size.
        contentSizeInPop = UIScreen.main.bounds.size    // make it full screen
        
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = "Make your own custom UI"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        view.addGestureRecognizer(tapGes)
        
    }
    
    @objc
    func dismissAction() {
        self.popController?.dismiss()
    }
    
    
}
