//
//  CreateViewController.swift
//  ServerLogin
//
//  Created by SWUCOMPUTER on 6/11/20.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    //Outlet 변수
    @IBOutlet var textID : UITextField!
    @IBOutlet var textPassword : UITextField!
    @IBOutlet var textName : UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    
    //함수 textfieldShuldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textID{
            textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder() //ID 입력 후 비번으로 이동
        }
        else if textField == self.textPassword {
            textField.resignFirstResponder()
            self.textName.becomeFirstResponder() // 비번 입력 후 이름으로 이동
        }
        textField.resignFirstResponder()
        return true
    }
    
    //함수 executeRequest
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request){
            (responseData,response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
            }
            if let utf8Data = String(data: receivedData, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.labelStatus.text = utf8Data
                    print(utf8Data)
                }
            }
        }
        task.resume()
    }
    
    
    
    @IBAction func buttonSave() {
        // 필요한 세 가지 자료가 모두 입력 되었는지 확인
        if textID.text == "" {
            labelStatus.text = "ID를 입력하세요";return;
        }
        if textPassword.text == "" {
            labelStatus.text = "Password를 입력하세요"; return;
        }
        if textName.text == "" {
            labelStatus.text = "사용자 이름을 입력하세요"; return;
        }
        // let urlString: String = "http://localhost:8888/login/insertUser.php"
        let urlString: String = "http://condi.swu.ac.kr/student/login/insertUser.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + textID.text! + "&password=" + textPassword.text! + "&name=" + textName.text!
        
        request.httpBody = restString.data(using: .utf8)
        self.executeRequest(request: request)
        
    }
    
    @IBAction func buttonBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
