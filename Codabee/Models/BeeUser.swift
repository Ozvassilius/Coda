//
//  BeeUser.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

// notre utilisateur abeille de test
import Foundation
import FirebaseDatabase

class BeeUser {

    private var _ref: DatabaseReference
    private var _id: String
    private var _username: String?
    private var _imageUrl: String?

    var id: String {
        return _id
    }
    var username: String {
        return _username ?? "Anonyme"
    }
    var imageUrl: String {
        return _imageUrl ?? ""
    }

    init(data: DataSnapshot) {
        self._ref = data.ref
        self._id = data.key
        if let dict = data.value as? [String:String] {
            self._username = dict["username"]
            self._imageUrl = dict["imageUrl"]
        }
    }
}
