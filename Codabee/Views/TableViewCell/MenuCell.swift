//
//  MenuCell.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!

    func setup(_ string : String) {
        self.setup()
        nameLbl.text = string
    }

}
