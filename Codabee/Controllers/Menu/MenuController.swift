//
//  MenuController.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class MenuController: MenuViewController {

    @IBOutlet weak var tableView: UITableView!

    // outlets utilisateur
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var profileIV: RoundIV!
    

    var items = ["Fils d'actualité","Videos","Forum"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setup(color: .clear)
        // Do any additional setup after loading the view.
        view.backgroundColor = .darkGray
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // a chaque fois que la vue du menu va apparaitre
        // on va vouloir demander au FirebaseHelper
        // si on a un utilisateur connecté
        if let id = FirebaseHelper().connecte() {
            // utilisateur connecté
            logButton.setTitle("Profil", for: .normal)
        } else {
            // on a pas d'utilisateur
            logButton.setTitle("se connecter", for: .normal)
            usernameLbl.text = ""
        }
    }
    
    @IBAction func logButtonPressed(_ sender: Any) {
    }
    

}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuContainerViewController?.contentViewControllers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell {
            cell.setup(items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let main = menuContainerViewController {
            main.selectContentViewController(main.contentViewControllers[indexPath.row])
            main.hideSideMenu()
        }
    }

}
