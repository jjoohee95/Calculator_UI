//
//  ViewController.swift
//  Calculator_Storyboard
//
//  Created by t2023-m0023 on 6/27/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentText: UILabel!

    @IBOutlet var button: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentText.text = "0"
        setButton()
    }

    @IBAction func numButton(_ sender: UIButton) {
        guard let clickedButtonText = sender.currentTitle else { return }
        // 현재 텍스트가 "0"일 때 클릭된 버튼이 0이 아닌경우, 0제거 클릭된 버튼 텍스트로 대체
        if currentText.text == "0" && clickedButtonText != "0" {
            currentText.text = clickedButtonText
        } else {
            currentText.text! += clickedButtonText
        }
    }

    @IBAction func ACButton(_ sender: UIButton) {
        currentText.text = "0"
    }

    @IBAction func EqualButton(_ sender: UIButton) {

        if let result = calculate(expression: currentText.text!) {
            currentText.text = String(result)  // = 버튼 클릭 시 계산, 결과를 텍스트로 설정
        } else {
            currentText.text = "ERROR"  // 잘못된 수식, 에러 표시
        }
    }
    @IBAction func operatorButton(_ sender: UIButton) {
        guard let clickedButtonText = sender.currentTitle else { return }

        currentText.text! += clickedButtonText
    }
    func setButton(){
        for i in button {
            i.layer.cornerRadius = 40
        }
    }
}




