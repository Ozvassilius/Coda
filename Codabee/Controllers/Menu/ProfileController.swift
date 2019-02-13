//
//  ProfileController.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class ProfileController: MoveableController {

    var beeUser: BeeUser?

    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var validerButton: UIButton!

    @IBOutlet weak var centerConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        addTap() // ajoute le gestureRecogniser

    }

    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(validerButton, centerConstraint)
    }

    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, centerConstraint) // lui redonner sa valeur de base
    }
    

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func validateAction(){
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func logAction(_ sender: Any) {
        // se deconnecter et dismiss
    }

    @IBAction func cameraAction(_ sender: Any) {
    }

    @IBAction func galleryAction(_ sender: Any) {
    }

}
