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
    var canAdd = false

    @IBOutlet weak var profileIV: RoundIV!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var validerButton: UIButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        addTap() // ajoute le gestureRecogniser
        if let user = beeUser {
            profileIV.download(string: user.imageUrl)
            usernameTF.placeholder  = user.username
        }

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
        if canAdd, usernameTF.text != nil {
            // modifier notre utilisateur
            if let user = beeUser {
                FirebaseHelper().updateUser(user.id, dict: ["username":self.usernameTF.text!])
                dismiss(animated: true, completion: nil)
            }
        }

    }

    @IBAction func logAction(_ sender: Any) {
        // se deconnecter et dismiss
        FirebaseHelper().signOut()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraAction(_ sender: Any) {
    }

    @IBAction func galleryAction(_ sender: Any) {
    }
    @IBAction func usernameEnter(_ sender: UITextField) {
        FirebaseHelper().usernameExists(sender.text) { (bool, string) in
            DispatchQueue.main.async {
                self.errorLbl.text = string
                self.canAdd = bool
            }
        }
    }

}
