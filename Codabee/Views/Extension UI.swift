//
//  Extension UI.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit
import SDWebImage

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

extension UIImageView {
    func download(string:String){
        sd_setImage(with: URL(string: string), placeholderImage: BUMBLE_IMAGE, options: SDWebImageOptions.highPriority, completed: nil)
    }
}
