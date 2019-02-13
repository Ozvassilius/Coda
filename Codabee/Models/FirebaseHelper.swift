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

    // une completion
    var result: ((_ bool: Bool?, _ erreur: Error?) -> Void)?
    var userValues: [String:String] = [:]

    // verifier si utilisateur est connecté
    func connecte() -> String? {
       return Auth.auth().currentUser?.uid
    }

    //Authentification
    func signIn(_ mail: String, _ password: String, result: ((_ bool: Bool?, _ erreur: Error?) -> Void)?)  {
        self.result = result
        Auth.auth().signIn(withEmail: mail, password: password, completion: completion)
    }

    func create(_ mail: String, _ password: String, _ username: String, result: ((_ bool: Bool?, _ erreur: Error?) -> Void)?)  {
        self.result = result

        // quand je cree une utilisateur je veux stocker ses infos en attendant qu'une completion soit bonne
        self.userValues = ["username":username]

        Auth.auth().createUser(withEmail: mail, password: password, completion: completion)


    }
    // les 2 fonctions signIn() et create() ont la meme completion
    // si on fait la touche entre sur AuthDataResultCallBack on se rend compte que c'est la meme
    // du coup on fait une fonction completion pour factoriser cela
    func completion(_ result: AuthDataResult?, _ error: Error?) {
        if let erreur = error {
            print(erreur.localizedDescription)
            // notifier a l'utilisateur une erreur
            self.result?(false, erreur)
        }
        if let id = result?.user.uid { // si on arrive a recup un user
            // mettre a jour ma base de donnees
            updateUser(id)

            // il faut que je notifie une completion OK
            self.result?(true, nil)

        }
    }

    func signOut()  {
        Auth.auth()
    }


    // acces base de donnees
    private var _database = Database.database().reference()
    private var _databaseUser : DatabaseReference {
        return _database.child("users")
    }
    private var _databaseQuestion : DatabaseReference {
        return _database.child("questions")
    }

    // on cree pas seulement un user, on l'UPDATE, mise a jour si deja créé sinon creation
    func updateUser(_ id: String){
        _databaseUser.child(id).updateChildValues(userValues)
        userValues = [:]  // ensuite on le vide

    }

}
