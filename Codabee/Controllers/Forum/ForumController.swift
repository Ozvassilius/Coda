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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Forum"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func showMenu(_ sender: Any) {
        showSideMenu()
    }

}
