//
//  ViewController.swift
//  Calculator_UI&codeBase
//
//  Created by t2023-m0023 on 6/20/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label = UILabel()
    let stackview1 = UIStackView()
    let stackview2 = UIStackView()
    let stackview3 = UIStackView()
    let stackview4 = UIStackView()
    let clcStackVeiw = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        // 배경 컬러지정
        view.backgroundColor = .black

        //라벨 설정
        label.text = "12345"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 60)

        // 라벨을 뷰에 추가하고 제약 조건을 설정
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
            $0.height.equalTo(100)
        }
        makeHorizontalStackView()
    }

    private func makeHorizontalStackView() {
        // 스택뷰를 4개를 만들어 줘야함
        // 각각의 스택뷰에 버튼타이틀 설정 할 수있는 함수 필요

        let stackViews = [stackview1, stackview2, stackview3, stackview4]
        let buttonTitle = [["7", "8", "9", "+"], ["4", "5", "6", "-"], ["1", "2", "3", "*"], ["AC", "0", "=", "/"]]
        // for  반복문 사용 스택 뷰의 속성을 설정
        for (index, stackview) in stackViews.enumerated() {
            setHorizontalStackView(stackview: stackview)
            makeButtonStackView(stackview: stackview, titles: buttonTitle[index])
        }

        func setHorizontalStackView(stackview : UIStackView){
            stackview.axis = .horizontal
            stackview.backgroundColor = .black
            stackview.spacing = 10
            stackview.distribution = .fillEqually

            view.addSubview(stackview)
            stackview.snp.makeConstraints{
                $0.width.equalTo(350)
                $0.height.equalTo(80)
                $0.centerX.equalToSuperview()
            }
        }
        func makeButtonStackView (stackview: UIStackView, titles: [String]){
            for title in titles {
                let button = UIButton()
                //버튼 타이틀이 연산자 operator와 숫자를 숫자로 변환
                //숫자로 변환이 되면 검정
                if let title = Int(title) {
                    button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                    //숫자로 변환이 안되면 오렌지
                } else {
                    button.backgroundColor = .orange
                }
                button.setTitle(String(title), for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
                button.frame.size.height = 80
                button.frame.size.width = 80
                button.layer.cornerRadius = 40

                stackview.addArrangedSubview(button)
            }
        }
        makeVerticalstackView()
    }

    private func makeVerticalstackView() {
        clcStackVeiw.axis = .vertical
        clcStackVeiw.backgroundColor = .black
        clcStackVeiw.spacing = 10
        clcStackVeiw.distribution = .fillEqually


        view.addSubview(clcStackVeiw)
        clcStackVeiw.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }

        //가로 스텍뷰를 세로 스택뷰에 추가해주기
        clcStackVeiw.addArrangedSubview(stackview1)
        clcStackVeiw.addArrangedSubview(stackview2)
        clcStackVeiw.addArrangedSubview(stackview3)
        clcStackVeiw.addArrangedSubview(stackview4)
    }
}
