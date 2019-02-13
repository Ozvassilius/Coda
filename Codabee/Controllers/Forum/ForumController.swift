//
//  ForumController.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class ForumController: UIViewController, SideMenuItemContent {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var questions: [Question] = []
    var questionTriees: [Question] = []
    var tri = false
    

    override func viewDidLoad() {
        super.viewDidLoad()



        title = "Forum"
        tableView.setup(color: HONEY_COLOR)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate  = self

        FirebaseHelper().getQuestion { (q) in
            DispatchQueue.main.async {
                self.questions.append(q)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        showSideMenu()
    }

    @IBAction func addQuestion(_ sender: Any) {
        AlerteHelper().askQuestion(self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Answer" {
            if let controller = segue.destination as? AnswerController {
                controller.question = sender as? Question
            }
        }
    }
}

extension ForumController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionCell {
            cell.setup(getQuestion(indexPath))
            return cell
        } else {
            return UITableViewCell()
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tri ? questionTriees.count : questions.count
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let question = getQuestion(indexPath)
        let height = question.questionString.height(tableView.frame.width - 40, font: UIFont.systemFont(ofSize: 20))
        return 100 + height
    }

    func getQuestion(_ indexPath: IndexPath) -> Question {
        if tri {
            return questionTriees[indexPath.row]
        } else {
            return questions[indexPath.row]
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = getQuestion(indexPath)
        performSegue(withIdentifier: "Answer", sender: question)
    }

}

extension ForumController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text != "" {
            tri = true
            questionTriees = questions.filter {
                $0.questionString.lowercased().contains(text.lowercased())
            }
        } else {
            tri = false
            
        }
        tableView.reloadData()
    }

}
