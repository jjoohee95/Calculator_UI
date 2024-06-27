//
//  Calculator.swift
//  Calculator_Storyboard
//
//  Created by t2023-m0023 on 6/27/24.
//

import Foundation

//계산기 클래스

func calculate(expression: String) -> Int? {
    // 입력한 수식이 비어있는 경우
    guard !expression.isEmpty else {
        print("수식이 비어있습니다.")
        return nil
    }
    // 연산자를 포함한 수식, 정규 표현식 사용하여 검사
    let regex = try! NSRegularExpression(pattern: "^[0-9]+([\\+\\-\\*\\/][0-9]+)*$")
    let range = NSRange(location: 0, length: expression.utf16.count)

    // 정규 표현식에 맞지 않는 경우
    guard regex.firstMatch(in: expression, options: [], range: range) != nil else {
        print("잘못된 수식입니다.")
        return nil
    }

    // NSExpression을 사용해 계산
    let nsExpression = NSExpression(format: expression)

    // 계산 결과를 반환
    if let result = nsExpression.expressionValue(with: nil, context: nil) as? Int {
        return result
    } else {
        print("잘못된 수식입니다.")  // 잘못된 수식일 경우, 메시지를 출력
        return nil
    }
}
