//
//  APIManager.swift
//  AlaMapRealm
//
//  Created by Dima Shvets on 9/7/17.
//  Copyright © 2017 Dima Shvets. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

class APIManager {
    static func getCars <T: Object> (type: T.Type, success:@escaping () -> Void,
                                     fail:@escaping (_ error:NSError)->Void)->Void where T:Mappable, T:Generics {
        Alamofire.request(type.url(), method: .get).responseArray { (response: DataResponse<[T]>) in
            switch response.result {
            case .success(let items):
                do {
                    let realm = try Realm()
                    try realm.write {
                        for item in items {
                            realm.add(item, update: true)
                        }
                    }
                } catch let error as NSError {
                    fail(error)
                }
                success()
            case .failure(let error):
                fail(error as NSError)
            }
        }
    }
}
