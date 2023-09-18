//
//  HomePresenter.swift
//  Test
//
//  Created by Isolina Ripolles on 14/09/23.
//

import Foundation

protocol HomePresentation {
    func didTapOpenPopup(titleText: String, locationText: String, priceText: String, descriptionText: String)
    func getLocationsData(locationText: String)
}

class HomePresenter {
    
    weak var view: HomeView?
    var interactor: HomeUseCase
    var router: HomeRouting
    
    init(view: HomeView, interactor: HomeUseCase, router: HomeRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension HomePresenter: HomePresentation {
    func getLocationsData(locationText: String) {
        self.interactor.fetchRequest(locationText: locationText) { (result) in
            switch result {
              case .success(let data):
                guard let locations = data as? [LocationResult] else {
                    return
                }
                self.view?.updateData(list: locations)
        
              case .failed(let error):
                print("error: \(error ?? "")")
            }
 
        }
    }

    func didTapOpenPopup(titleText: String, locationText: String, priceText: String, descriptionText: String) {
        self.interactor.openPopup(router: self.router, titleText: titleText, locationText: locationText, priceText: priceText, descriptionText: descriptionText)
    }
}
