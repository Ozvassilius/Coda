//
//  Nav.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class Nav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .darkGray
        navigationBar.tintColor = HONEY_COLOR
        navigationBar.titleTextAttributes = [
            .foregroundColor: HONEY_COLOR,
            .font: UIFont.italicSystemFont(ofSize: 20)
        ]
    }
    



}
