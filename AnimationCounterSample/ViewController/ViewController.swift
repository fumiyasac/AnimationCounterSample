//
//  ViewController.swift
//  AnimationCounterSample
//
//  Created by Fumiya Sakai on 2017/11/15.
//  Copyright © 2017年 Fumiya Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //カウンターの様にアニメーションをするラベル
    @IBOutlet weak var counterAnimationLabel: CounterAnimationLabel!

    //カウンターの様にアニメーションをするラベルに入れる値を入力するためのテキストフィールド
    @IBOutlet weak var counterTextField: UITextField!
    
    //テキストの変更をドラムロールの様に行うアニメーションをするラベル
    @IBOutlet weak var changeAnimationTextLabel: ChangeAnimationTextLabel!

    //ドラムロールの様に行うアニメーションをするラベルのマスクになるView
    @IBOutlet weak var changeAnimationTextLabelWrappedView: UIView!

    //Step2.用のメンバ変数
    private var counter = 0

    //カウンターアニメーションの時間設定
    private var counterAnimationLabelDuration: TimeInterval = 5.0

    //ドラムロールアニメーションの時間設定
    private var changeAnimationTextLabelDuration: TimeInterval = 0.3

    override func viewDidLoad() {
        super.viewDidLoad()

        //カウンターの初期値の設定
        counterAnimationLabel.text = "0"

        //テキストフィールドの定義
        counterTextField.delegate = self
        counterTextField.placeholder = "0~9999までな！"
        counterTextField.keyboardType = .numberPad
        counterTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        //ドラムロールーの初期値の設定
        changeAnimationTextLabel.text = String(counter)
        changeAnimationTextLabelWrappedView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - @IBActions

    @IBAction func inputNumberButtonTapped(_ sender: Any) {
        counterTextField.resignFirstResponder()
        let counterValue = counterTextField.text ?? ""
        if !counterValue.isEmpty {
        counterAnimationLabel.changeCountValueWithAnimation(Float(counterValue)!, withDuration: counterAnimationLabelDuration, andAnimationType: .EaseOut, andCounterType: .Int)
        } else {
            counterAnimationLabel.changeCountValueWithAnimation(Float(0), withDuration: counterAnimationLabelDuration, andAnimationType: .EaseOut, andCounterType: .Int)
        }
        counterTextField.text = ""
    }

    @IBAction func increaseButtonTapped(_ sender: Any) {
        counter += 1
        changeAnimationTextLabel.changeTextWithAnimation(newText: String(counter), duration: changeAnimationTextLabelDuration, fromTop: true)
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        counter -= 1
        changeAnimationTextLabel.changeTextWithAnimation(newText: String(counter), duration: changeAnimationTextLabelDuration, fromTop: false)
    }

    //MARK: - Private Function

    @objc private func textFieldDidChange(_ textFiled: UITextField) {
        if let text = textFiled.text {
            //入力は3桁までに制限しておく
            if text.count >= 3 {
                counterTextField.text = String(text.prefix(3))
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        counterTextField.becomeFirstResponder()
    }
}
