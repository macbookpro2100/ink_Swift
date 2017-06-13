//
//  Service.swift
//  LoginWithRx
//
//  Created by tiantengfei on 2016/11/29.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa


/// handle our TextFiled text in RegisterViewController
class ValidationService {
    static let instance = ValidationService()
    
    private init() {}
    
    let minCharactersCount = 6
    
    func validateUsername(_ username: String) -> Observable<InkResult> {
        
        if username.characters.count == 0 {
            return .just(.empty)
        }
        
        if username.characters.count < minCharactersCount {
            return .just(.failed(message: "号码长度至少6个字符"))
        }
        
        if usernameValid(username) {
            return .just(.failed(message: "账户已存在"))
        }
        
        return .just(.ok(message: "用户名可用"))
    }
    
    func validatePassword(_ password: String) -> InkResult {
        if password.characters.count == 0 {
            return .empty
        }
        
        if password.characters.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        
        return .ok(message: "密码可用")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPasswordword: String) -> InkResult {
        if repeatedPasswordword.characters.count == 0 {
            return .empty
        }
        
        if repeatedPasswordword == password {
            return .ok(message: "密码可用")
        }
        
        return .failed(message: "两次密码不一样")
    }
    
    func register(_ username: String, password: String) -> Observable<InkResult> {
        let userDic = [username: password]
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        
        if (userDic as NSDictionary).write(toFile: filePath, atomically: true) {
            return .just(.ok(message: "注册成功"))
        }
        return .just(.failed(message: "注册失败"))
    }
    
    func usernameValid(_ username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        if userDic == nil {
           return false
        }
        let usernameArray = userDic!.allKeys as NSArray
        if usernameArray.contains(username) {
            return true
        } else {
            return false
        }
    }
    
    func loginUsernameValid(_ username: String) -> Observable<InkResult> {
        if username.characters.count == 0 {
            return .just(.empty)
        }
        
        if usernameValid(username) {
            return .just(.ok(message: "用户名可用"))
        }
        return .just(.failed(message: "用户名不存在"))
    }
    
    func login(_ username: String, password: String) -> Observable<InkResult> {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        
        if let userPass = userDic?.object(forKey: username) as? String {
            if  userPass == password {
                return .just(.ok(message: "登录成功"))
            }
        }
        return .just(.failed(message: "密码错误"))
    }
}


class SearchService {
    static let shareInstance = SearchService()
    
    private init() {}
    
    func getHeros() -> Observable<[Hero]> {
        let herosString = Bundle.main.path(forResource: "heros", ofType: "plist")
        let herosArray = NSArray(contentsOfFile: herosString!) as! Array<[String: String]>
        var heros = [Hero]()
        for heroDic in herosArray {
            let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
            heros.append(hero)
        }
        
        return Observable.just(heros)
            .observeOn(MainScheduler.instance)
    }
    
    func getHeros(withName name: String) -> Observable<[Hero]> {
        if name == "" {
            return getHeros()
        }
        
        let herosString = Bundle.main.path(forResource: "heros", ofType: "plist")
        let herosArray = NSArray(contentsOfFile: herosString!) as! Array<[String: String]>
        var heros = [Hero]()
        for heroDic in herosArray {
            if heroDic["name"]!.contains(name) {
                let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
                heros.append(hero)
            }
        }
        
        return Observable.just(heros)
            .observeOn(MainScheduler.instance)
    }
    
    
    
}
