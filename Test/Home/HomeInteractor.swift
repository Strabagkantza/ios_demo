//
//  HomeInteractor.swift
//  Test
//
//  Created by Isolina Ripolles on 14/09/23.
//

import Foundation
import Alamofire

enum ServiceResult {
    case success(data: Any?)
    case failed(error: String?)
}

typealias ServiceCompletion = (_ result: ServiceResult) -> ()

protocol HomeUseCase {
    func fetchRequest(locationText: String, callback: @escaping ServiceCompletion)
    func openPopup(router: HomeRouting, titleText: String, locationText: String, priceText: String, descriptionText: String)
}

class HomeInteractor {
    let url = "https://4ulq3vb3dogn4fatjw3uq7kqby0dweob.lambda-url.eu-central-1.on.aws/"
}

extension HomeInteractor: HomeUseCase {
    
    func fetchRequest(locationText: String, callback: @escaping ServiceCompletion) {
        AF.request(url, parameters: ["input": locationText]).validate().responseDecodable(of: [LocationResult].self) { (response) in
                     switch response.result {
                       case .success(let locations):
                           callback(ServiceResult.success(data: locations))
                       case .failure(let error):
                         print("Error \(error.localizedDescription)")
                           callback(ServiceResult.failed(error: error.localizedDescription))
                       }
            }
    }
    
    func openPopup(router: HomeRouting, titleText: String, locationText: String, priceText: String, descriptionText: String) {
        router.openPopup(titleText: titleText, locationText: locationText, priceText: priceText, descriptionText: descriptionText)
    }
    
    
}
