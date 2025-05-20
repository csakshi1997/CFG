//
//  SeniorConsultantVC.swift
//  CFGApp
//
//  Created by Sakshi on 21/01/25.
//

import UIKit

class SeniorConsultantVC: UIViewController, UITextViewDelegate {
    @IBOutlet var vw: UIView?
    @IBOutlet var lowerVw: UIView?
    @IBOutlet var CommentTxtVw: UITextView?
    @IBOutlet var commentCountLbl: UILabel?
    @IBOutlet var commtHeight: NSLayoutConstraint?
    @IBOutlet var clinicDoctorBtn: UIButton?
    @IBOutlet var nextBtn: UIButton?
    @IBOutlet var seniorConsultantBtn: UIButton?
    @IBOutlet var otherDoctorrBtn: UIButton?
    @IBOutlet var approvedBtn: UIButton?
    @IBOutlet var otherrBtn: UIButton?
    var isclinicDoctorBtn: Bool = false {
        didSet {
            if isclinicDoctorBtn {
                clinicDoctorBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                clinicDoctorBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isseniorConsultantBtn: Bool = false {
        didSet {
            if isseniorConsultantBtn {
                seniorConsultantBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                seniorConsultantBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isotherDoctorrBtn: Bool = false {
        didSet {
            if isotherDoctorrBtn {
                otherDoctorrBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                otherDoctorrBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isapprovedBtn: Bool = false {
        didSet {
            if isapprovedBtn {
                approvedBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                lowerVw?.isHidden = false
                
            } else {
                approvedBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                lowerVw?.isHidden = true
            }
        }
    }
    var isotherrBtn: Bool = false {
        didSet {
            if isotherrBtn {
                otherrBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
                lowerVw?.isHidden = false
                CommentTxtVw?.isHidden = false
                commtHeight?.constant = 60
            } else {
                otherrBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
                lowerVw?.isHidden = true
                CommentTxtVw?.isHidden = true
                commtHeight?.constant = 0
            }
        }
    }
    
    @IBAction func seniorDoctorCommentAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            isseniorConsultantBtn = !isseniorConsultantBtn
        case 1:
            isclinicDoctorBtn = !isclinicDoctorBtn
        case 2:
            isotherDoctorrBtn = !isotherDoctorrBtn
        case 3:
            isapprovedBtn = !isapprovedBtn
        case 4:
            isotherrBtn = !isotherrBtn
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commtHeight?.constant = 0
    }
    
    func setupUI() {
        vw?.shadowDecorateForView()
        CommentTxtVw?.placeholder = "Why?"
        CommentTxtVw?.layer.borderWidth = 1
        CommentTxtVw?.layer.borderColor = UIColor.gray.cgColor
        CommentTxtVw?.textColor = .darkGray
        CommentTxtVw?.layer.cornerRadius = 8
        CommentTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        addTapGestureToDismissKeyboard()
        nextBtn?.layer.cornerRadius = 8
        CommentTxtVw?.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == CommentTxtVw {
            let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
            textView.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.constant = size.height
                }
            }
            let currentCount = textView.text.count
            commentCountLbl?.text = "\(currentCount)"
            if textView.text.isEmpty {
                textView.setPlaceholder("Comments")
            } else {
                textView.removePlaceholder()
            }
        }
    }
    
    func showAlert(){
        let checkInalert = UIAlertController(
            title: "Confirmation",
            message: "Are you sure you want to submit this case?",
            preferredStyle: .alert
        )
        self.present(checkInalert, animated: true, completion: nil)
        checkInalert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            print("Cancel tapped")
        }))
        
        checkInalert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            Utility.gotoPendingCaseVC()
            SceneDelegate.getSceneDelegate().window?.makeToast(CASE_SUBMITTED)
        }))
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let updatedTextLength = currentText.count - range.length + text.count
        return updatedTextLength <= 131072
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction() {
        showAlert()
    }
    
}
