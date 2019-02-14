//
//  AnswerCell.swift
//  Codabee
//
//  Created by Macinstosh on 14/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var profileIV: RoundIV!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var answerIV: UIImageView!
    

    var answer: Answer!

    func setup(_ answer: Answer, _ yellow: Bool) {
        answerIV.isHidden = true
        answerLbl.isHidden = true
        self.answer = answer

        // une fois une cell jaune/ une fois grise
        usernameLbl.textColor = yellow ? .darkGray : HONEY_COLOR
        answerLbl.textColor = yellow ? .darkGray : HONEY_COLOR
        contentView.backgroundColor = yellow ? HONEY_COLOR : .darkGray

        dateLbl.text = self.answer.date.ilYA()
        FirebaseHelper().getUser(self.answer.userId) { (user) in
            DispatchQueue.main.async {
                if let bee = user {
                    self.profileIV.download(string: bee.imageUrl)
                    self.usernameLbl.text = bee.username
                }
            }
        }

        if let string = self.answer.texte {
            answerLbl.isHidden  = false
            answerLbl.text = string
        }

        if let image = self.answer.imageUrl {
            answerIV.isHidden = false
            answerIV.download(string: image)
        }

    }
}
