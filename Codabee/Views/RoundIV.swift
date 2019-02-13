//
//  RoundIV.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class RoundIV: UIImageView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = frame.height / 2 // tech pour avoir une image ronde
        layer.borderColor = HONEY_COLOR.cgColor
        layer.borderWidth = 2



    }
}
