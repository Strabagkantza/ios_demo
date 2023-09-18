//
//  ViewController.swift
//  Test
//
//  Created by Isolina Ripolles on 14/09/23.
//

import UIKit
import iOSDropDown

protocol HomeView: class {
    func updateData(list: [LocationResult])
}

class HomeViewController: UITableViewController {
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var priceText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var locationText: DropDown!
    
    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.submitButton.isHidden = true
        
        self.locationText.didSelect { selectedText, index, id in
            self.clearList()
        }
    }

    @IBAction func clickSubmit(_ sender: UIButton) {
        self.presenter?.didTapOpenPopup(titleText: titleText.text ?? "", locationText: locationText.text ?? "", priceText: priceText.text ?? "", descriptionText: descriptionText.text ?? "")
        clearData()
    }
    
    @IBAction func clickClear(_ sender: UIButton) {
        clearData()
    }
    
    @IBAction func changeTitle(_ sender: UITextField) {
        if (sender.hasText && locationText.hasText && locationText.text!.count > 2) {
            submitButton.isHidden = false
        } else {
            submitButton.isHidden = true
        }
    }
    
    @IBAction func changeLocation(_ sender: UITextField) {
        if (sender.hasText && sender.text!.count > 2 && sender.text!.count < 9) {
            self.clearList()
            self.presenter?.getLocationsData(locationText: sender.text!)
        } else if (!sender.hasText) {
            self.clearList()
        }
        if (sender.hasText && sender.text!.count > 2 && titleText.hasText) {
            submitButton.isHidden = false
        } else {
            submitButton.isHidden = true
        }
    }
    
    
}

extension HomeViewController: HomeView {
    func updateData(list: [LocationResult]) {
        self.locationText.optionArray = list.map { "\($0.mainText ?? ""), \($0.secondaryText ?? "")" }
        self.locationText.showList()
    }
    
    func clearData() {
        titleText.text = ""
        locationText.text = ""
        priceText.text = ""
        descriptionText.text = ""
        submitButton.isHidden = true
        clearList()
    }
    
    func clearList() {
        self.locationText.hideList()
        self.locationText.optionArray = []
    }
}

