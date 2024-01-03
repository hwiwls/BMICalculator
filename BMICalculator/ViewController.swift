//
//  ViewController.swift
//  BMICalculator
//
//  Created by hwijinjeong on 1/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var cmTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calRandomBtn: UIButton!
    
    var ht: Double = 0
    var wt: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func optionalBinding() {
        guard let cm = cmTextField.text else {
            print("error")
            return
        }
        
        if let doubleCm = Double(cm) {
            ht = doubleCm
        } else {
            ht = 0
        }
        
        guard let weight = weightTextField.text else {
            print("error2")
            return
        }
        
        if let doubleWeight = Double(weight) {
            wt = doubleWeight
        } else {
            wt = 0
        }
    }

    func calcBMI() -> Double {
        optionalBinding()
        
        let bmi: Double = wt / ((ht * 0.01) * (ht * 0.01))
        
        return bmi
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "BMI 지수는 \(round(calcBMI()*100)/100) 입니다.", message: nil, preferredStyle: .alert)
        // 2. 버튼
        let btn1 = UIAlertAction(title: "확인", style: .cancel) // 안 쓰거나 두 개 이상 쓰는 건 불가
        let btn2 = UIAlertAction(title: "cancel", style: .destructive)
        // 3. 컨텐츠 + 버튼
        alert.addAction(btn1)
        alert.addAction(btn2)
        // 4. 띄우기
        present(alert, animated: true)
    }
    
    @IBAction func calcRandomly(_ sender: Any) {
        let randomHeight = Int.random(in: 140...200)
        
        let randomWeight = Int.random(in: 40...100)
        
        let bmi = Double(randomWeight) / ((Double(randomHeight) * 0.01) * (Double(randomHeight) * 0.01))
        
        let alert = UIAlertController(title: "BMI 지수는 \(round(bmi * 100)/100) 입니다.", message: nil, preferredStyle: .alert)
        // 2. 버튼
        let btn1 = UIAlertAction(title: "확인", style: .cancel) // 안 쓰거나 두 개 이상 쓰는 건 불가
        let btn2 = UIAlertAction(title: "cancel", style: .destructive)
        // 3. 컨텐츠 + 버튼
        alert.addAction(btn1)
        alert.addAction(btn2)
        // 4. 띄우기
        present(alert, animated: true)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}

