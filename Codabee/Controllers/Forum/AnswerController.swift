//
//  AnswerController.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class AnswerController: MoveableController {

    var question : Question?

    // zone du haut
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileIV: RoundIV!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!

    // tableview
    @IBOutlet weak var tableView: UITableView!

    // zone du bas
    @IBOutlet weak var zoneDeTextView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if question != nil {
            questionLbl.text = question!.questionString
            dateLbl.text = question!.date.ilYA()
            FirebaseHelper().getUser(question!.userId) { (user) in
                DispatchQueue.main.async {
                    if let beeUser = user {
                    self.profileIV.download(string: beeUser.imageUrl)
                        self.usernameLbl.text = beeUser.username
                    }
                }
            }

        }

        // pour faire sortir le clavier quand on clique sur un message
        // on peut pas le faire quand on clique sur la tableView car ca prendrait le didselect
        topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))

        // ajouter bord arrondi a la textView
        textView.layer.cornerRadius = 15
        textView.delegate = self

    }
    

    @IBAction func cameraPressed(_ sender: Any) {
    }
    
    @IBAction func libraryPressed(_ sender: Any) {
    }
    @IBAction func validatePressed(_ sender: Any) {
    }

    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        let totalHeight = height - safeArea
        animation(totalHeight, bottomConstraint)
        }


    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, bottomConstraint)
    }
}

extension AnswerController: UITextViewDelegate {

    func animateIn(_ bool: Bool) {
        libraryBtn.isHidden =  bool
        cameraBtn.isHidden = bool
        let constant : CGFloat = bool ? 8 : 90 // si c vrai 8 sinon 90
        animation(constant, leadingConstraint)
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            // zone de texte == 40 + boutons visibles + leading a 90
            animation(40, heightConstraint)
            animateIn(false)

        } else {
            // la zone de texte s'adaptera, on cache les boutons, on met le leading a 8 pour cacher les boutons
            let textHeight = textView.text.height(textView.frame.width, font: UIFont.systemFont(ofSize: 14)) + 25
            animation(textHeight, heightConstraint)
            animateIn(true)
        }
    }
}

