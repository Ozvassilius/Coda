//
//  MoveableController.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

// deplacer une vue et observer le clavier et ajouter un tap
import UIKit

class MoveableController: UIViewController {

    var height : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // notif showKeyboard
        NotificationCenter.default.addObserver(self, selector: #selector(showKey), name: UIWindow.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(hideKey), name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    @objc func showKey(notification : Notification) {
        // renvoyer un CGFloat pour deplacer l'ecran
        if let keyHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height  {
            height = keyHeight
        }
    }

    @objc func hideKey(notification : Notification) {
        // rien pour l'instant
    }

    func addTap() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }

    @objc func tap() {
        view.endEditing(true)
    }

    func animation(_ constante: CGFloat, _ constraint:NSLayoutConstraint ){
        UIView.animate(withDuration: 0.5) {
            constraint.constant = constante
        }
    }

    func checkHeight(_ view: UIView, _ contrainte: NSLayoutConstraint) {
        let bottom = view.frame.maxY // recuperer le point le plus bas de la view
        let screenHeight = UIScreen.main.bounds.height // haute de l'ecran
        let remain = screenHeight - bottom - 20 // 20 par aisance entre le clavier et la vue
        if height > remain {
            let constante = remain - height
            animation(constante, contrainte)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
