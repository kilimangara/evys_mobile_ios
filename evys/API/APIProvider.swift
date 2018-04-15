//
//  APIProvider.swift
//  evys
//
//  Created by Nikita Zlain on 14.04.18.
//  Copyright © 2018 Nikita Zlain. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class APIProvider {
    
    static let sharedInstance: APIProvider = {
        let instance = APIProvider()
        return instance
    }()
    
    private let BASE_URL = "https://api.evys.ru/"
    
    private var token: String? = nil
    
    func initProvider(token: String){
        self.token = token
    }
    
    public func sendCode(phone: String) -> Observable<Void> {
        let url = URL(string: self.BASE_URL + "student/code")
        print(url!)
        return Observable<Void>.create({observer in
            let parameters: Parameters = ["phone": phone]
            Alamofire.request(url!, method: .post, parameters: parameters).responseJSON{ response in
                print(response.result)
                switch response.result {
                case .success:
                    observer.onNext(Void())
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }

    public func authStudent(phone: String, code: String) -> Observable<AuthModel> {
        let url = URL(string: self.BASE_URL + "student/auth")
        return Observable.create({observer in
            let parameters: Parameters = ["phone": phone, "code": code]
            Alamofire.request(url!, method:.post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    let result = response.result
                    if let dict = result.value as? [String: AnyObject] {
                        let innerDict = dict["data"] as! [String: AnyObject]
                        print(innerDict)
                        guard let id = innerDict["user_id"] as? Int,
                              let token = innerDict["token"] as? String,
                              let is_new = innerDict["is_new"] as? Bool
                        else {return }
                        print(id, token, is_new)
                        observer.onNext(AuthModel(is_new: is_new, id: id, token: token))
                    }
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    public func getSubjects() -> Observable<[Course]> {
        let url = URL(string: self.BASE_URL + "student/courses")
        guard let unwrappedToken = self.token
            else {return Observable.empty()}
        let headers = [
            "Authorization": "Student " + unwrappedToken
        ]
        print(headers)
        return Observable.create({ observer in
            Alamofire.request(url!, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    let result = response.result
                    print(result)
                    var courses = [Course]()
                    if let dict = result.value as? [String: AnyObject] {
                        guard let innerArr = dict["data"] as? [[String: AnyObject]]
                            else {return}
                        innerArr.forEach {
                            item in
                            guard let id = item["id"] as? Int,
                                let type = item["type"] as? String,
                                let target = item["target"] as? Int8,
                                let progress = item["progress"] as? Int8,
                                let subjectName = (item["subject"]!)["subject"] as? String
                                else {return}
                            courses.append(Course(type: type, id: id, progress: progress, target: target, subjectName: subjectName))
                        }
                    }
                    observer.onNext(courses)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
}
