//
//  LogController.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class LogController: MoveableController {

    var canAdd = false

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
        setup()
        addTap()
    }

    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(logView, centerViewConstraint)
    }

    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, centerViewConstraint) // lui redonner sa valeur de base
    }

    func setup(){
        switch segmented.selectedSegmentIndex {
        case 0:
            usernameTF.isHidden = true
            connectButton.setTitle("Se Connecter", for: .normal)
        default:
            usernameTF.isHidden = false
            connectButton.setTitle("Creer un compte", for: .normal)
        }
    }

    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        setup()
    }

    @IBAction func usernameChanged(_ sender: UITextField) {
        // verifier dans la base de donnees si username existe deja
        FirebaseHelper().usernameExists(sender.text) { (bool, string) in
            DispatchQueue.main.async {
                self.canAdd = true
                self.usernameErrorLbl.text = string
            }
        }
    }

    @IBAction func connectPressed(_ sender: Any) {
        // verifier si mail et mdp
        if let mail = emailTF.text, mail != "" { // si on a un mail
            if let mdp = passwordTF.text, mdp != "" { // et un mdp

                // ON EST DANS LA PARTIE CONNECTION
                if segmented.selectedSegmentIndex == 0 { // et qu'on est sur "se connecter"
                    FirebaseHelper().signIn(mail, mdp, result: logCompletion)
                } else {
                    //ON EST DANS LA PARTIE CREATION
                    // verifie si username existe
                    if canAdd, let username = usernameTF.text {
                        FirebaseHelper().create(mail, mdp, username, result: logCompletion)
                    }
                }
            } else {
                // alerte: il n'y a pas de MDP
                AlerteHelper().erreurSimple(self, message: "Mot de passe vide")
            }
        } else {
            // alerte: il n'y a pas de mail
            AlerteHelper().erreurSimple(self, message: "Adresse mail vide")
        }
        // creer un compte ou se connecter

    }

    func logCompletion(_ bool: Bool?, _ error: Error?){
        if error != nil {   
            // montrer alerte
            AlerteHelper().erreurSimple(self, message: error!.localizedDescription)
        }
        if bool != nil, bool! == true {
            // une fois qu'on s'est connecté on revient en arriere et on continue notre application
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
