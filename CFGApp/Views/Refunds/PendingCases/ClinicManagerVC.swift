//
//  ClinicManagerVC.swift
//  CFGApp
//
//  Created by Sakshi on 15/01/25.
//

import UIKit

class ClinicManagerVC: UIViewController, UITextViewDelegate {
    @IBOutlet var vw: UIView?
    @IBOutlet var upperVw: UIView?
    @IBOutlet var lowerVw: UIView?
    @IBOutlet var spokenWithPatientBtn: UIButton?
    @IBOutlet var yesBtn: UIButton?
    @IBOutlet var noBtn: UIButton?
    @IBOutlet var spokenPatientTextCountLbl: UILabel?
    @IBOutlet var whyTextCountLbl: UILabel?
    @IBOutlet var whyTxtVw: UITextView?
    @IBOutlet var CommentTxtVw: UITextView?
    @IBOutlet var dateTxtFld: UITextField?
    @IBOutlet var dateStackView: UIStackView?
    @IBOutlet var submitBtn: UIButton?
    @IBOutlet var commtHeight: NSLayoutConstraint?
    @IBOutlet var stackHeight: NSLayoutConstraint?
    @IBOutlet var whyCommtHeight: NSLayoutConstraint?
    @IBOutlet var uppperCountVwHeight: NSLayoutConstraint?
    @IBOutlet var lowerCountVwHeight: NSLayoutConstraint?
    var isYes: Bool = false
    var isNo: Bool = false
    var isSpokeToPatient: Bool = false {
        didSet {
            if isSpokeToPatient {
                spokenWithPatientBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
                commtHeight?.constant = 60
                uppperCountVwHeight?.constant = 10
                upperVw?.isHidden = false
            } else {
                spokenWithPatientBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                commtHeight?.constant = 0
                uppperCountVwHeight?.constant = 0
                upperVw?.isHidden = true
            }
        }
    }
    
    var isYesClick: Bool = false {
        didSet {
            if isYesClick {
                isNoClick = false
                yesBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
                noBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                stackHeight?.constant = 45
                whyCommtHeight?.constant = 0
            } else {
                yesBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                stackHeight?.constant = 0
            }
        }
    }
    
    var isNoClick: Bool = false {
        didSet {
            if isNoClick {
                isYesClick = false
                yesBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                noBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
                stackHeight?.constant = 0
                whyCommtHeight?.constant = 60
                lowerCountVwHeight?.constant = 10
                lowerVw?.isHidden = false
            } else {
                noBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                whyCommtHeight?.constant = 0
                lowerCountVwHeight?.constant = 0
                lowerVw?.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        commtHeight?.constant = 0
        stackHeight?.constant = 0
        whyCommtHeight?.constant = 0
    }
    
    func setupUI() {
        vw?.shadowDecorateForView()
        CommentTxtVw?.placeholder = "Comments"
        CommentTxtVw?.layer.borderWidth = 1
        CommentTxtVw?.layer.borderColor = UIColor.gray.cgColor
        CommentTxtVw?.textColor = .darkGray
        CommentTxtVw?.layer.cornerRadius = 8
        CommentTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        whyTxtVw?.placeholder = "Why?"
        whyTxtVw?.layer.borderWidth = 1
        whyTxtVw?.layer.borderColor = UIColor.gray.cgColor
        whyTxtVw?.textColor = .darkGray
        whyTxtVw?.layer.cornerRadius = 8
        whyTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        dateStackView?.layer.borderWidth = 1
        dateStackView?.layer.borderColor = UIColor.gray.cgColor
        dateStackView?.layer.cornerRadius = 8
        dateTxtFld?.setLeftPaddingPoints(12.0)
        dateTxtFld?.setRightPaddingPoints(12.0)
        addTapGestureToDismissKeyboard()
        submitBtn?.layer.cornerRadius = 8
        CommentTxtVw?.delegate = self
        whyTxtVw?.delegate = self
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
            spokenPatientTextCountLbl?.text = "\(currentCount)"
            if textView.text.isEmpty {
                textView.setPlaceholder("Comments")
            } else {
                textView.removePlaceholder()
            }
        } else if textView == whyTxtVw {
            let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
            textView.constraints.forEach { constraint in
                if constraint.firstAttribute == .height {
                    constraint.constant = size.height
                }
            }
            let currentCount = textView.text.count
            whyTextCountLbl?.text = "\(currentCount)"
            if textView.text.isEmpty {
                textView.setPlaceholder("Why?")
            } else {
                textView.removePlaceholder()
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == CommentTxtVw {
            let currentText = textView.text ?? ""
            let updatedTextLength = currentText.count - range.length + text.count
            return updatedTextLength <= 131072
        } else {
            let currentText = textView.text ?? ""
            let updatedTextLength = currentText.count - range.length + text.count
            return updatedTextLength <= 131072
        }
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
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "PendingCases", bundle: storyboardBundle)
        let aMCheckListVC = storyboard.instantiateViewController(withIdentifier: "AMCheckListVC") as! AMCheckListVC
        self.navigationController?.pushViewController(aMCheckListVC, animated: true)
    }
    
    @IBAction func yesNoAction(sender: UIButton) {
        if sender.tag == 1 {
            isYesClick = !isYesClick
        } else {
            isNoClick = !isNoClick
        }
    }
    
    @IBAction func spokeWithAction(sender: UIButton) {
        isSpokeToPatient = !isSpokeToPatient
    }
    
    

}
