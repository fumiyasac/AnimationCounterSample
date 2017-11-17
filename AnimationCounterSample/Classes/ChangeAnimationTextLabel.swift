//
//  ChangeAnimationTextLabel.swift
//  AnimationCounterSample
//
//  Created by Fumiya Sakai on 2017/11/15.
//  Copyright © 2017年 Fumiya Sakai. All rights reserved.
//

import Foundation
import UIKit

/**
 * 値のセット時に上下のアニメーションを伴って値の切り替えを行う機能を入れたUILabelクラス
 * (補足).textで直接入れる場合はアニメーションを伴わない
 *
 * 元ネタ：
 * RetweetCounter
 * https://github.com/usagimaru/RetweetCounter
 *
 */

class ChangeAnimationTextLabel: UILabel {

    //MARK: - Functions

    //上下方向へのアニメーションを伴ってラベル文字列を現在の値から新しく切り替える
    func changeTextWithAnimation(newText: String, duration: TimeInterval, fromTop: Bool = true) {

        let transition = setTransition(withDuration: duration)
        var key: String
        if fromTop {
            transition.subtype = kCATransitionFromTop
            key = "increase"
        } else {
            transition.subtype = kCATransitionFromBottom
            key = "decrease"
        }

        var targetText: String? = nil
        targetText = (!newText.isEmpty) ? newText : ""

        //.textの値と異なる場合だけアニメーションを実行する
        if self.text != targetText {
            layer.removeAllAnimations()
            layer.add(transition, forKey: key)
            self.text = newText
        }
    }

    //MARK: - Private Functions

    //トランジション(CATransition)に関する設定を行う
    private func setTransition(withDuration: TimeInterval) -> CATransition {
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.duration = withDuration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return transition
    }
}
