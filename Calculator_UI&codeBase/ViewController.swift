//
//  ViewController.swift
//  Calculator_UI&codeBase
//
//  Created by t2023-m0023 on 6/20/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // 화면에 표시될 레이블과 스택뷰
    let label = UILabel()
    let stackview1 = UIStackView()
    let stackview2 = UIStackView()
    let stackview3 = UIStackView()
    let stackview4 = UIStackView()
    let clcStackVeiw = UIStackView()

    // 현재 표시되고 있는 텍스트
    var currentText = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        // 초기 UI 설정 및 스택뷰 생성
        configureUI()
        makeHorizontalStackView()
        makeVerticalstackView()
    }

    // UI를 설정하는 메서드
    private func configureUI() {
        view.backgroundColor = .black  // 배경 검정색

        label.text = currentText  // 초기 텍스트 설정
        label.textColor = .white  // 텍스트 색상 흰색
        label.textAlignment = .right  // 텍스트 정렬 오른쪽
        label.font = UIFont.boldSystemFont(ofSize: 60)  // 굵은 폰트 60

        // 레이블 추가 , 설정
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)  // 왼쪽 여백 30
            $0.trailing.equalToSuperview().inset(30)  // 오른쪽 여백 30
            $0.top.equalToSuperview().inset(200)  // 상단여백 200
            $0.height.equalTo(100)  // 높이 100
        }
    }

    // 가로스택뷰 생성 버튼추가 메서드
    private func makeHorizontalStackView() {
        let stackViews = [stackview1, stackview2, stackview3, stackview4]
        let buttonTitle = [["7", "8", "9", "+"], ["4", "5", "6", "-"], ["1", "2", "3", "*"], ["AC", "0", "=", "/"]]

        for (index, stackview) in stackViews.enumerated() {
            setHorizontalStackView(stackview: stackview)  // 가로 스택뷰 속성 설정
            makeButtonStackView(stackview: stackview, titles: buttonTitle[index])  // 버튼을 생성, 스택뷰에 추가
        }
    }




    // 가로 스택뷰 속성 설정 메서드
    private func setHorizontalStackView(stackview: UIStackView) {
        stackview.axis = .horizontal  // 가로 방향 정렬
        stackview.backgroundColor = .black  // 배경색 검은색
        stackview.spacing = 10  // 요소 간의 간격 10 포인트
        stackview.distribution = .fillEqually  // 균등하게 배치

        // 스택뷰 추가하고 제약조건 설정
        view.addSubview(stackview)
        stackview.snp.makeConstraints {
            $0.width.equalTo(350)  // 너비 350
            $0.height.equalTo(80)  // 높이 80
            $0.centerX.equalToSuperview()  // 수평 가운데 정렬
        }
    }

    // 버튼생성, 가로스택뷰 추가하는 함수
    private func makeButtonStackView(stackview: UIStackView, titles: [String]) {
        for title in titles {
            let button = UIButton()

            // 숫자 버튼인지 연산자 버튼인지 확인한후 스타일과 액션 설정
            if let _ = Int(title) {
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)  // 숫자 버튼 배경색
                button.addTarget(self, action: #selector(clickNum(_:)), for: .touchUpInside)  // 숫자 버튼 액션 설정
            } else {
                button.backgroundColor = .orange  // 연산자 버튼 배경색
                button.addTarget(self, action: #selector(clickOperator(_:)), for: .touchUpInside)  // 연산자 버튼 클릭 액션을 추가
            }
            //버튼 텍스트 설정
            button.setTitle(String(title), for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)  // 버튼 텍스트 굵은폰트 크기 30
            button.frame.size.height = 80  // 버튼 높이 80 포인트
            button.frame.size.width = 80  // 버튼 너비 80 포인트
            button.layer.cornerRadius = 40  // 버튼 모서리 둥글게

            stackview.addArrangedSubview(button)  // 버튼 가로 스택뷰에 추가
        }
    }

    // 세로 스택뷰 생성,  가로 스택뷰 추가
    private func makeVerticalstackView() {
        clcStackVeiw.axis = .vertical  // 세로 방향 정렬
        clcStackVeiw.backgroundColor = .black  // 배경색 검은색
        clcStackVeiw.spacing = 10  // 요소  간격을 10 포인트
        clcStackVeiw.distribution = .fillEqually  // 균등 배치

        // 세로 스택뷰 화면에 추가, 제약조건 설정
        view.addSubview(clcStackVeiw)
        clcStackVeiw.snp.makeConstraints {
            $0.width.equalTo(350)  // 너비 350
            $0.top.equalTo(label.snp.bottom).offset(60)  // 레이블 아래 여백 60
            $0.centerX.equalToSuperview()  // 수평 가운데 정렬
        }

        // 가로 스택뷰들을 세로 스택뷰에 추가
        clcStackVeiw.addArrangedSubview(stackview1)
        clcStackVeiw.addArrangedSubview(stackview2)
        clcStackVeiw.addArrangedSubview(stackview3)
        clcStackVeiw.addArrangedSubview(stackview4)
    }

    // 숫자 버튼 클릭 시 호출되는 메서드
    @objc func clickNum(_ sender: UIButton) {
        guard let clickedButtonText = sender.currentTitle else { return }

        // 현재 텍스트가 "0"일 때 클릭된 버튼의 텍스트로 대체
        if currentText == "0" {
            currentText = clickedButtonText
        // 그 외의 경우에는 기존 텍스트에 추가
        } else {
            currentText += clickedButtonText
        }
        updateLabel()  // 레이블 업데이트
    }

    // 연산자 버튼 클릭 시 호출되는 메서드
    @objc func clickOperator(_ sender: UIButton) {
        guard let clickedButtonText = sender.currentTitle else { return }

        // 클릭된 연산자에 따라 동작 수행
        switch clickedButtonText {
        case "AC":
            currentText = "0"  // AC 버튼 클릭 시 초기화
        case "=":
            if let result = calculate(expression: currentText) {
                currentText = String(result)  // = 버튼 클릭 시 계산, 결과를 텍스트로 설정
            } else {
                currentText = "ERROR"  // 잘못된 수식, 에러 표시
            }
        default:
            currentText += clickedButtonText  // 기타 연산자, 텍스트에 추가
        }
        updateLabel()  // 레이블을 업데이트
    }

    // 수식을 계산,  결과를 반환하는 메서드
    func calculate(expression: String) -> Int? {
        let nsExpression = NSExpression(format: expression)
        if let result = nsExpression.expressionValue(with: nil, context: nil) as? Int {
            return result  // 계산 결과를 반환
        } else {
            print("잘못된 수식입니다.")  // 잘못된 수식일 경우, 메시지를 출력
            return nil
        }
    }

    // 레이블의 텍스트를 업데이트
    func updateLabel() {
        label.text = currentText  // 레이블 현재 텍스트를 설정
    }
}
