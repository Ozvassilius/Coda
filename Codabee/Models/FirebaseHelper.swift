//
//  FirebaseHelper.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class FirebaseHelper {


    // verifier si utilisateur est connecté
    func connecte() -> String? {
       return Auth.auth().currentUser?.uid
    }


}
