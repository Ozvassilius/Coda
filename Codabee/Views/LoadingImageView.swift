//
//  LoadingImageView.swift
//  Codabee
//
//  Created by Macinstosh on 08/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView {

    var timer = Timer()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup()  {
        image = UIImage(named: "darkBee")
        contentMode = .scaleAspectFit
    }

    func start() {
        timer = .scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (t) in
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        })
    }

    func stop() {
        timer.invalidate()
    }
}
