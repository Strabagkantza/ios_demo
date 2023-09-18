//
//  HomeRouter.swift
//  Test
//
//  Created by Isolina Ripolles on 14/09/23.
//

import UIKit

protocol HomeRouting {
    func openPopup(titleText: String, locationText: String, priceText: String, descriptionText: String)
}

class HomeRouter {
    
    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
   
}

extension HomeRouter: HomeRouting {
    func openPopup(titleText: String, locationText: String, priceText: String, descriptionText: String) {
        let alertController = UIAlertController(title: "Popup", message: "Title: \(titleText) \n Location: \(locationText) \n Price: \(priceText) \n Description: \(descriptionText)", preferredStyle: .alert)
            let actionDismiss = UIAlertAction(title: "Close", style: .default) { (action) in
            }
            alertController.addAction(actionDismiss)
            view.present(alertController, animated: true, completion: nil)
       
    }
}
