//
//  Protocol.swift
//  LoginWithRx
//
//  Created by tiantengfei on 2016/11/29.
//  Copyright © 2016年 tiantengfei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


/// service handle result
///
/// - ok: ok
/// - empty: nothing
/// - failed: failed
enum InkResult {
    case ok(message: String)
    case empty
    case failed(message: String)
}

extension InkResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension InkResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}


extension InkResult {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}

extension Reactive where Base: UILabel {
    var validationResult: UIBindingObserver<Base, InkResult> {
        return UIBindingObserver(UIElement: base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base: UITextField {
    var inputEnabled: UIBindingObserver<Base, InkResult> {
        return UIBindingObserver(UIElement: base) { textFiled, result in
            textFiled.isEnabled = result.isValid
        }
    }
}

extension Reactive where Base: UIButton {
    var tapEnabled: UIBindingObserver<Base, InkResult> {
        return UIBindingObserver(UIElement: base) { button, result in
            button.isEnabled = result.isValid
        }
    }
}
