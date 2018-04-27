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
    
    public let actionSubject: PublishSubject<ErrorModel> = PublishSubject.init()
    
    func initProvider(token: String){
        self.token = token
    }
    
    public func sendCode(phone: String) -> Observable<Void> {
        let url = URL(string: self.BASE_URL + "student/code")
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
                    print(error, "ERRORR!!!")
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
        return Observable.create({ observer in
            Alamofire.request(url!, method: .get, headers: headers).responseData { response in
                switch response.result {
                case .success:
                    let result = response.result
                    do {
                        let baseResponse = try JSONDecoder().decode(BaseResponse<[Course]>.self, from: result.value!)
                        if let courses = baseResponse.data {
                            observer.onNext(courses)
                        }
                        if let errors = baseResponse.error {
                            print("onERROR", errors)
                            self.actionSubject.onNext(errors)
                        }
                    } catch(let error) {
                        print("cant decode base response", error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    public func getThemes(courseId: Int) -> Observable<[ThemeModel]>{
        let url = URL(string: self.BASE_URL + "student/course/\(courseId)/themes")
        guard let unwrappedToken = self.token
            else {return Observable.empty()}
        let headers = [
            "Authorization": "Student " + unwrappedToken
        ]
        return Observable.create({observer in
            Alamofire.request(url!, method: .get, headers: headers).responseData {
                response in
                switch response.result {
                case .success:
                    let result = response.result
                    do {
                        let baseResponse = try JSONDecoder().decode(BaseResponse<[ThemeModel]>.self, from: result.value!)
                        if let themes = baseResponse.data {
                          observer.onNext(themes)
                        }
                        if let errors = baseResponse.error {
                            print("onERROR", errors)
                            
                        }
                    } catch(let error) {
                        print("cant decode base response", error)
                    }
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    public func generateTest(themeId: Int) -> Observable<Int>{
        let url = URL(string: self.BASE_URL + "student/theme/\(themeId)/start_testing")
        print("GENERATETEST", url!)
        guard let unwrappedToken = self.token
            else {return Observable.empty()}
        let headers = [
            "Authorization": "Student " + unwrappedToken
        ]
        return Observable.create({ observer in
            Alamofire.request(url!, method: .get, headers: headers).responseJSON {
                response in
                switch response.result {
                case .success:
                    let result = response.result
                    print(result)
                    if let rootDict = result.value as? [String: AnyObject] {
                        if let testBlockObj = rootDict["data"] as? [String: AnyObject] {
                            if let tbId = testBlockObj["id"] as? Int{
                                observer.onNext(tbId)
                            }
                        }
                        if let errorObj = rootDict["error"] as? [String: AnyObject] {
                            print(errorObj, "ERROR")
                        }
                    }
                case .failure(let error):
                    print("generate test", error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    public func getQuestion(themeId: Int, testBlockId: Int) -> Observable<TaskModel> {
        let url = URL(string: self.BASE_URL + "student/theme/\(themeId)/question?test_block=\(testBlockId)")
        guard let unwrappedToken = self.token
            else {return Observable.empty()}
        let headers = [
            "Authorization": "Student " + unwrappedToken
        ]
        return Observable.create({ observer in
            Alamofire.request(url!, method: .get, headers: headers).responseData{
                response in
                switch response.result {
                case .success:
                    let result = response.result
                    do {
                        let baseResponse = try JSONDecoder().decode(BaseResponse<TaskModel>.self, from: result.value!)
                        if let task = baseResponse.data {
                            observer.onNext(task)
                        }
                        if let errors = baseResponse.error {
                            print("onERROR", errors)
                        }
                    } catch(let error) {
                         print("cant decode base response", error)
                    }
                case .failure(let error):
                    print("get question", error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    public func answerQuestion(themeId: Int, testBlockId: Int, timeSpent: Int, answer: String) -> Observable<AnswerResponseModel> {
        let url = URL(string: self.BASE_URL + "student/theme/\(themeId)/answer")
        guard let unwrappedToken = self.token
            else {return Observable.empty()}
        let headers = [
            "Authorization": "Student " + unwrappedToken
        ]
        let parameters: Parameters = [
            "test_block": testBlockId,
            "answer": answer,
            "time_spent": timeSpent
        ]
        return Observable.create({ observer in
            Alamofire.request(url!, method:.post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData {
                response in
                switch response.result {
                case .success:
                    let result = response.result
                    do {
                        let baseResponse = try JSONDecoder().decode(BaseResponse<AnswerResponseModel>.self, from: result.value!)
                        if let task = baseResponse.data {
                            observer.onNext(task)
                        }
                        if let errors = baseResponse.error {
                            print("onERROR", errors)
                        }
                    } catch(let error) {
                        print("cant decode base response", error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
}
