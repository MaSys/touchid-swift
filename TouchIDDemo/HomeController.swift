//
//  HomeController.swift
//  TouchIDDemo
//
//  Created by Yaser Almasri on 10/29/16.
//  Copyright © 2016 MaSys. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome!"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
