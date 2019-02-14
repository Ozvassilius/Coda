//
//  QuestionCell.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {


    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!

    var question: Question!

    func setup(_ question: Question) {

        setup()
        self.question = question
        dateLbl.text = self.question.date.ilYA()
        questionLbl.text = self.question.questionString
    }
}
