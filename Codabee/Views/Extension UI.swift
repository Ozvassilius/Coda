//
//  Extension UI.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

extension UITableView {

    func setup(color: UIColor) {
        backgroundColor = color
        separatorStyle = .none
        tableFooterView = UIView()
    }


}

extension UITableViewCell {
    func setup() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
}

