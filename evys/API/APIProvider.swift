//
//  APIProvider.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation
import RxSwift

class APIProvider {
    
    private let BASE_URL = "https://api.evys.ru/"
    
    public func sendCode(phone: String) -> Observable<Void> {
        guard phone.isEmpty, let url = URL(string: self.BASE_URL + "student/code") else {return Observable.empty()}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["phone": phone]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters,options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        return 
    }
 
}
