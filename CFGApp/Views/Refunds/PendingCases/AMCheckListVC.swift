//
//  AMCheckListVC.swift
//  CFGApp
//
//  Created by Sakshi on 21/01/25.
//

import UIKit

class AMCheckListVC: UIViewController, UITextViewDelegate {
    @IBOutlet var vw: UIView?
    @IBOutlet var lowerVw: UIView?
    @IBOutlet var CommentTxtVw: UITextView?
    @IBOutlet var commentCountLblVwTop: NSLayoutConstraint?
    @IBOutlet var commentCountLbl: UILabel?
    @IBOutlet var commtHeight: NSLayoutConstraint?
    @IBOutlet var lowerCountVwHeight: NSLayoutConstraint?
    @IBOutlet var reviewBtn: UIButton?
    @IBOutlet var nextBtn: UIButton?
    @IBOutlet var callBtn: UIButton?
    @IBOutlet var callCommentVw: UIView?
    @IBOutlet var callCommentTxtVw: UITextView?
    @IBOutlet var callCommentCountLbl: UILabel?
    @IBOutlet var callCommentHeight: NSLayoutConstraint?
    @IBOutlet var callCommentCountVwHeight: NSLayoutConstraint?
    @IBOutlet var offerBtn: UIButton?
    @IBOutlet var yesArrangeBtn: UIButton?
    @IBOutlet var noArrangeBtn: UIButton?
    @IBOutlet var yesArrangeBtnHeight: NSLayoutConstraint?
    @IBOutlet var noArrangeBtnHeight: NSLayoutConstraint?
    @IBOutlet var noArrangeBtnTop: NSLayoutConstraint?
    @IBOutlet var extendBtn: UIButton?
    @IBOutlet var updateSyantemBtn: UIButton?
    @IBOutlet var updateSyantemBtnHeight: NSLayoutConstraint?
    @IBOutlet var transferBtn: UIButton?
    @IBOutlet var dateTxtFld: UITextField?
    @IBOutlet var dateStackView: UIStackView?
    @IBOutlet var dateStackViewHeight: NSLayoutConstraint?
    @IBOutlet var offerToSeeBtn: UIButton?
    @IBOutlet var offerToSeeYesBtn: UIButton?
    @IBOutlet var offerToSeeScheduleBtn: UIButton?
    @IBOutlet var offerToSeeNoBtn: UIButton?
    @IBOutlet var offerToSeeScheduleBtnTop: NSLayoutConstraint?
    @IBOutlet var offerToSeeNoBtnTop: NSLayoutConstraint?
    @IBOutlet var offerToSeeYesBtnHeight: NSLayoutConstraint?
    @IBOutlet var offerToSeeScheduleBtnHeight: NSLayoutConstraint?
    @IBOutlet var offerToSeeNoBtnHeight: NSLayoutConstraint?
    @IBOutlet var refundBtn: UIButton?
    @IBOutlet var noRefundBtn: UIButton?
    @IBOutlet var caseClosedNoRefundBtn: UIButton?
    @IBOutlet var pursueWithOmNoRefundBtn: UIButton?
    @IBOutlet var caseClosedNoRefundBtnHeight: NSLayoutConstraint?
    @IBOutlet var pursueWithOmNoRefundBtnHeight: NSLayoutConstraint?
    @IBOutlet var pursueWithOmNoRefundBtnTop: NSLayoutConstraint?
    @IBOutlet var speakToHigherBtn: UIButton?
    var isreviewBtn: Bool = false {
        didSet {
            if isreviewBtn {
                reviewBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                reviewBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var iscallBtn: Bool = false {
        didSet {
            if iscallBtn {
                callCommentVw?.isHidden = false
                callCommentTxtVw?.isHidden = false
                callCommentHeight?.constant = 60
                callCommentCountVwHeight?.constant = 10
                commentCountLblVwTop?.constant = 10
                callBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                callCommentVw?.isHidden = true
                callCommentTxtVw?.isHidden = true
                callCommentHeight?.constant = 0
                callCommentCountVwHeight?.constant = 0
                commentCountLblVwTop?.constant = 0
                callBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isofferBtn: Bool = false {
        didSet {
            if isofferBtn {
                yesArrangeBtn?.isHidden = false
                noArrangeBtn?.isHidden = false
                yesArrangeBtnHeight?.constant = 22
                noArrangeBtnHeight?.constant = 22
                noArrangeBtnTop?.constant = 22
                offerBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                yesArrangeBtn?.isHidden = true
                noArrangeBtn?.isHidden = true
                yesArrangeBtnHeight?.constant = 0
                noArrangeBtnHeight?.constant = 0
                noArrangeBtnTop?.constant = 0
                offerBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isextendBtn: Bool = false {
        didSet {
            if isextendBtn {
                updateSyantemBtn?.isHidden = false
                updateSyantemBtnHeight?.constant = 22
                extendBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                updateSyantemBtn?.isHidden = true
                updateSyantemBtnHeight?.constant = 0
                extendBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var istransferBtn: Bool = false {
        didSet {
            if istransferBtn {
                dateStackView?.isHidden = false
                dateStackViewHeight?.constant = 45
                transferBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                dateStackView?.isHidden = true
                dateStackViewHeight?.constant = 0
                transferBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isofferToSeeBtn: Bool = false {
        didSet {
            if isofferToSeeBtn {
                offerToSeeYesBtn?.isHidden = false
                offerToSeeScheduleBtn?.isHidden = false
                offerToSeeNoBtn?.isHidden = false
                offerToSeeYesBtnHeight?.constant = 22
                offerToSeeScheduleBtnHeight?.constant = 22
                offerToSeeNoBtnHeight?.constant = 22
                offerToSeeScheduleBtnTop?.constant = 22
                offerToSeeNoBtnTop?.constant = 22
                offerToSeeBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                offerToSeeYesBtn?.isHidden = true
                offerToSeeScheduleBtn?.isHidden = true
                offerToSeeNoBtn?.isHidden = true
                offerToSeeYesBtnHeight?.constant = 0
                offerToSeeScheduleBtnHeight?.constant = 0
                offerToSeeNoBtnHeight?.constant = 0
                offerToSeeScheduleBtnTop?.constant = 0
                offerToSeeNoBtnTop?.constant = 0
                offerToSeeBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isrefundBtn: Bool = false {
        didSet {
            if isrefundBtn {
                refundBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                refundBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    var isnoRefundBtn: Bool = false {
        didSet {
            if isnoRefundBtn {
                caseClosedNoRefundBtnHeight?.constant = 22
                pursueWithOmNoRefundBtnHeight?.constant = 22
                caseClosedNoRefundBtn?.isHidden = false
                pursueWithOmNoRefundBtn?.isHidden = false
                pursueWithOmNoRefundBtnTop?.constant = 22
                noRefundBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                caseClosedNoRefundBtnHeight?.constant = 0
                pursueWithOmNoRefundBtnHeight?.constant = 0
                caseClosedNoRefundBtn?.isHidden = true
                pursueWithOmNoRefundBtn?.isHidden = true
                pursueWithOmNoRefundBtnTop?.constant = 0
                noRefundBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    var isspeakToHigherBtn: Bool = false {
        didSet {
            if isspeakToHigherBtn {
                speakToHigherBtn?.setImage(UIImage(named: "addcheck"), for: UIControl.State.normal)
            } else {
                speakToHigherBtn?.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            }
        }
    }
    
    @IBAction func reasontTerminationAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            isreviewBtn = !isreviewBtn
        case 1:
            iscallBtn = !iscallBtn
        case 2:
            isofferBtn = !isofferBtn
        case 3:
            isextendBtn = !isextendBtn
        case 4:
            istransferBtn = !istransferBtn
        case 5:
            isofferToSeeBtn = !isofferToSeeBtn
        case 6:
            isrefundBtn = !isrefundBtn
        case 7:
            isnoRefundBtn = !isnoRefundBtn
        case 8:
            isspeakToHigherBtn = !isspeakToHigherBtn
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        callCommentHeight?.constant = 0
        callCommentCountVwHeight?.constant = 0
        yesArrangeBtnHeight?.constant = 0
        noArrangeBtnHeight?.constant = 0
        updateSyantemBtnHeight?.constant = 0
        dateStackViewHeight?.constant = 0
        offerToSeeYesBtnHeight?.constant = 0
        offerToSeeScheduleBtnHeight?.constant = 0
        offerToSeeNoBtnHeight?.constant = 0
        caseClosedNoRefundBtnHeight?.constant = 0
        pursueWithOmNoRefundBtnHeight?.constant = 0
        callCommentVw?.isHidden = true
        callCommentTxtVw?.isHidden = true
        yesArrangeBtn?.isHidden = true
        noArrangeBtn?.isHidden = true
        updateSyantemBtn?.isHidden = true
        dateStackView?.isHidden = true
        yesArrangeBtn?.isHidden = true
        offerToSeeYesBtn?.isHidden = true
        offerToSeeScheduleBtn?.isHidden = true
        offerToSeeNoBtn?.isHidden = true
        caseClosedNoRefundBtn?.isHidden = true
        pursueWithOmNoRefundBtn?.isHidden = true
        noArrangeBtnTop?.constant = 0
        commentCountLblVwTop?.constant = 0
        offerToSeeScheduleBtnTop?.constant = 0
        offerToSeeNoBtnTop?.constant = 0
        pursueWithOmNoRefundBtnTop?.constant = 0
    }
    
    func setupUI() {
        vw?.shadowDecorateForView()
        CommentTxtVw?.placeholder = "AM Comments *"
        CommentTxtVw?.layer.borderWidth = 1
        CommentTxtVw?.layer.borderColor = UIColor.gray.cgColor
        CommentTxtVw?.textColor = .darkGray
        CommentTxtVw?.layer.cornerRadius = 8
        CommentTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        callCommentTxtVw?.placeholder = "Comments *"
        callCommentTxtVw?.layer.borderWidth = 1
        callCommentTxtVw?.layer.borderColor = UIColor.gray.cgColor
        callCommentTxtVw?.textColor = .darkGray
        callCommentTxtVw?.layer.cornerRadius = 8
        callCommentTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        dateStackView?.layer.borderWidth = 1
        dateStackView?.layer.borderColor = UIColor.gray.cgColor
        dateStackView?.layer.cornerRadius = 8
        addTapGestureToDismissKeyboard()
        nextBtn?.layer.cornerRadius = 8
        CommentTxtVw?.delegate = self
        dateTxtFld?.setLeftPaddingPoints(10.0)
        dateTxtFld?.setRightPaddingPoints(10.0)
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
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "PendingCases", bundle: storyboardBundle)
        let seniorConsultantVC = storyboard.instantiateViewController(withIdentifier: "SeniorConsultantVC") as! SeniorConsultantVC
        self.navigationController?.pushViewController(seniorConsultantVC, animated: true)
    }
    
    
    
    
    
}
