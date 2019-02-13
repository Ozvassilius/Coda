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
            updateUser(id,dict: self.userValues )

            // il faut que je notifie une completion OK
            self.result?(true, nil)

        }
    }

    func signOut()  {
        do {
            try Auth.auth().signOut() // je l'invoque dans mon appdelegate didfinishLauching pour les tests
        } catch {
            print(error.localizedDescription)
        }
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
    func updateUser(_ id: String, dict: [String:String]){
        _databaseUser.child(id).updateChildValues(dict)
        userValues = [:]  // ensuite on le vide

    }

    func getUser(_ id: String, completion: ((BeeUser?)->Void)?) {
        _databaseUser.child(id).observe(.value) { (data) in
            print("Data utilisateur: \(data)")
            completion?(BeeUser(data: data))
        }
    }

    func usernameExists(_ username: String?, completion: ((Bool,String)->Void)?) {
        if let string = username { // si username n'est pas vide
            if string.count > 2 { // si l'username a au moins 3 caracteres

                // apres avoir rajouté une regle d'indexOn sur Firebase
                // on compare notre string (username) a ceux de la base pour voir si il existe deja ou non
                _databaseUser.queryOrdered(byChild: "username").queryEqual(toValue: string).observeSingleEvent(of: .value) { (data) in
                    if data.exists() {
                        completion?(false, "Username deja pris")
                    } else {
                        completion?(true,"")
                    }
                }
            } else {
                completion?(false, "username trop court")
            }
        } else {
            completion?(false, "username vide")
        }
    }

    // Storage
    private let _storage = Storage.storage().reference()
    private var _storageUser: StorageReference {
        return _storage.child("users")
    }


    func addProfilePicture(_ data: Data) {
        guard let id = connecte() else { return }
        let reference = _storageUser.child(id)
        reference.putData(data, metadata: nil) { (meta, error) in
            if error == nil {
                reference.downloadURL(completion: { (url, error) in
                    if let urlString = url?.absoluteString {
                        self.updateUser(id, dict: ["imageUrl" : urlString])
                    }
                })
            }
        }
    }

}
