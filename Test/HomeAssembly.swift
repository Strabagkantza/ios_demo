//
//  HomeAssembly.swift
//  Test
//
//  Created by Isolina Ripolles on 14/09/23.
//

import UIKit

class HomeAssembly {
    
    static func build() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeTableController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter(view: view)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        
        return view
    }
}
