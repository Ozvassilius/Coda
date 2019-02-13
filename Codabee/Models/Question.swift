//
//  Question.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Question {

    private var _ref: DatabaseReference
    private var _id: String
    private var _date: String
    private var _userId: String // utilisateur qui pose la question
    private var _quesionString: String

    var ref: DatabaseReference { return _ref }
    var id: String { return _id }
    var date: String { return _date }
    var userId: String { return _userId }
    var questionString: String { return _quesionString }

    init(ref: DatabaseReference, id: String, date: String, userId: String, questionString: String) {
        self._ref = ref
        self._id = id
        self._date = date
        self._userId = userId
        self._quesionString = questionString
    }
}
