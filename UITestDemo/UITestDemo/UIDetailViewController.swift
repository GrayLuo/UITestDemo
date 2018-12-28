//
//  UIDetailViewController.swift
//  UITestDemo
//
//  Created by Grey.Luo on 2018/11/14.
//  Copyright © 2018 Sioeye. All rights reserved.
//

import UIKit

protocol TodoEditProtocol: NSObjectProtocol {
    func save(_ text: String)
}

class UIDetailViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!

    weak var delegate: TodoEditProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveHandle(_ sender: Any) {
        guard let string = textfield.text, string.count > 0  else {
            let alert = UIAlertController(title: "Warning", message: "Empty to do content", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        delegate?.save(string)
        navigationController?.popViewController(animated: true)
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
