//
//  MonRootController.swift
//  Codabee
//
//  Created by Macinstosh on 07/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit
import InteractiveSideMenu

// Container qui va contenir notre menu ainsi que les autres elements
// et Root de notre application

class RootController: MenuContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1) transition
        transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: 50)
        // duration: duree a laquelle l'animation se fait
        // visibleContentWidth: largeur du menu

        // 2) MenuController
        // on instantie un storyboard
        // on verifie que menu est bien notre intialviewController
        if let menu = getInitial(string: "Menu") as? MenuViewController {
        menuViewController = menu
        }

        // Contenu
        contentViewControllers = [
            getInitial(string: "Actus"),
            getInitial(string: "Videos"),
            getInitial(string: "Forum")
        ]

        // Selectionner le 1ier du contenu comme visible au départ
        if contentViewControllers.count > 0 {
            selectContentViewController(contentViewControllers.first!)
        }


    }
    
    func getInitial(string: String) -> UIViewController {
        let storyboard = UIStoryboard(name: string, bundle: nil)
        return storyboard.instantiateInitialViewController() ?? UIViewController()
    }


}
