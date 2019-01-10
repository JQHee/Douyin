//
//  UserHomePageViewController.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import UIKit


class UserHomePageViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBgAlpha = 0
        self.view.backgroundColor = UIColor.white
    }

}
