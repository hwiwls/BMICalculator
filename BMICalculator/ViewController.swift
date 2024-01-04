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
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var calRandomBtn: UIButton!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    var ht: Double = 0
    var wt: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        saveUserDefaults()
    }
    
    func saveUserDefaults() {
        /*
         이해가 안 가네
         */
        
        // 1. 이름
        let name = UserDefaults.standard.string(forKey: "Name")
        
        if let name, !name.isEmpty {
            nameTextField.text = name
        }
        
        // 2. 키
        let storedHeight = UserDefaults.standard.string(forKey: "Height")
        
        if let storedHeight, !storedHeight.isEmpty {
            cmTextField.text = storedHeight
        }
        
        // 3. 몸무게
        let storedWeight = UserDefaults.standard.string(forKey: "Weight")
        
        if let storedWeight, !storedWeight.isEmpty {
            weightTextField.text = storedWeight
        }
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
        let result = calcBMI()
        if result.isNaN == true || ht == 0.0 || wt == 0.0 || ht >= 200.0 || wt >= 200.0 {
            let alert = UIAlertController(title: "잘못된 값을 입력하셨습니다.", message: "문자열, 공백, 잘못된 범위 입력은 계산이 어렵습니다.", preferredStyle: .alert)
            // 2. 버튼
            let btn1 = UIAlertAction(title: "확인", style: .cancel) // 안 쓰거나 두 개 이상 쓰는 건 불가
            let btn2 = UIAlertAction(title: "cancel", style: .destructive)
            // 3. 컨텐츠 + 버튼
            alert.addAction(btn1)
            alert.addAction(btn2)
            // 4. 띄우기
            present(alert, animated: true)
        } else {
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
        
        UserDefaults.standard.setValue(nameTextField.text, forKey: "Name")
        UserDefaults.standard.setValue(cmTextField.text, forKey: "Height")
        UserDefaults.standard.setValue(weightTextField.text, forKey: "Weight")
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
        
        UserDefaults.standard.setValue(nameTextField.text, forKey: "Name")
    }
    
    @IBAction func resetBtnClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "Name")
        UserDefaults.standard.removeObject(forKey: "Height")
        UserDefaults.standard.removeObject(forKey: "Weight")
        
        nameTextField.text = ""
        cmTextField.text = ""
        weightTextField.text = ""
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

