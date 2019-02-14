//
//  AnswerController.swift
//  Codabee
//
//  Created by Macinstosh on 13/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class AnswerController: MoveableController {

    var question: Question?
    var answers: [Answer] = []
    var imagePicker = UIImagePickerController()

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

            FirebaseHelper().getAnswer(ref: question!.ref) { (answer) in
                DispatchQueue.main.async {
                    self.answers.append(answer)
                    self.tableView.reloadData()
                }
            }

        }

        // pour faire sortir le clavier quand on clique sur un message
        // on peut pas le faire quand on clique sur la tableView car ca prendrait le didselect
        topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))

        // ajouter bord arrondi a la textView
        textView.layer.cornerRadius = 15
        textView.delegate = self

        //
        imagePicker.delegate = self
        imagePicker.allowsEditing = false

        tableView.delegate = self
        tableView.dataSource = self

    }
    

    @IBAction func cameraPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func libraryPressed(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func validatePressed(_ sender: Any) {
        if question != nil {
            if textView.text != "" {
                FirebaseHelper().saveAnswer(ref: question!.ref, texte: textView.text, image: nil, height: nil)
                textView.text = ""
                animateIn(false)
                animation(40, heightConstraint)
                view.endEditing(true)

            }
        }
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

extension AnswerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let imageSize = image.size
            let heightRatio = imageSize.height / imageSize.width
            if let data = image.jpegData(compressionQuality: 0.4) {
                FirebaseHelper().addImageAnswer(data) { (urlString) in
                    if urlString != nil, self.question != nil {
                        FirebaseHelper().saveAnswer(ref: self.question!.ref, texte: nil, image: urlString!, height: heightRatio)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil  )
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AnswerController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as? AnswerCell {
            cell.setup(answers[indexPath.row], indexPath.row % 2 == 0)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let answer = answers[indexPath.row]
        var base: CGFloat = 100
        if answer.texte != nil {
            let heightText = answer.texte!.height(tableView.frame.width - 16, font: UIFont.systemFont(ofSize: 18))
            base += heightText
        }

        if answer.imageHeight != nil {
            let heightImage = ( tableView.frame.width - 16 ) * answer.imageHeight!
            base += heightImage
        }

        return base
    }
}
