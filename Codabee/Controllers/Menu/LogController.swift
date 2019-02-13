//
//  LogController.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class LogController: UIViewController {

    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameErrorLbl: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var logView: CustomView!
    @IBOutlet weak var centerViewConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
    }

    @IBAction func usernameChanged(_ sender: UITextField) {
    }

    @IBAction func connectPressed(_ sender: Any) {
    }
    
}
