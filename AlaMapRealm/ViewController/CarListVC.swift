//
//  CarListVC.swift
//  AlaMapRealm
//
//  Created by Dima Shvets on 10/10/17.
//  Copyright © 2017 Dima Shvets. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class CarListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var cars: Results<Car>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cars = self.realm.objects(Car.self)
    }
    
    func alert(title: String, message: String) -> Void {
        let actionSheetController: UIAlertController = UIAlertController(title:title,
                                                                         message:message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }

    
}

// MARK: - IBAction
extension CarListVC {
    @IBAction func fetchCars(_ sender: UIBarButtonItem) {
        APIManager.getCars(type: Car.self, success: {
            self.cars = self.realm.objects(Car.self)
            self.tableView.reloadData()
        }, fail: { error in
            self.alert(title: "\(error)", message: "\(error.localizedDescription)")
        })
    }
}

// MARK: - UITableViewDataSource
extension CarListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell?
        let car = cars?[indexPath.row]
        cell?.textLabel?.text = car?.car
        cell?.detailTextLabel?.text = car?.model
        let data = try? Data(contentsOf: URL(string: (car?.image)!)!)
        if let imageData = data {
            let image = UIImage(data: imageData)
            cell?.imageView?.image = image
        }
        return cell!
    }
}

