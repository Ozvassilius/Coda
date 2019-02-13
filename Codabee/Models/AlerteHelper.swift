//
//  File.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class AlerteHelper {

    func erreurSimple(_ controller: UIViewController, message: String)  {

        let alerte = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alerte.addAction(ok)
        controller.present(alerte, animated: true, completion: nil)
    }

    func askQuestion(_ controller: UIViewController) {
        let alerte = UIAlertController(title: "poser votre question", message: nil, preferredStyle: .alert)
        alerte.addTextField { (tf) in
            tf.placeholder = "Posez votre question"
        }
        let ok = UIAlertAction(title: "ok", style: .default) { (action) in
            if let textFields = alerte.textFields {
                if textFields.count > 0 {
                    let textfield = textFields[0]
                    if let texte = textfield.text, texte != "" {
                        // on va envoyer sur Firebase
                        print("texte question: \(texte)")
                        FirebaseHelper().saveQuestion(texte)
                    }
                }
            }
        }
    let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alerte.addAction(ok)
        alerte.addAction(cancel)
        controller.present(alerte, animated: true, completion: nil)
    }
}
