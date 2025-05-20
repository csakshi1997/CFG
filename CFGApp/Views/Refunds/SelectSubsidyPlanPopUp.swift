//
//  SelectSubsidyPlanPopUp.swift
//  CFGApp
//
//  Created by Sakshi on 07/01/25.
//

import UIKit
import DropDown

class SelectSubsidyPlanPopUp: UIViewController {
    @IBOutlet var TblVw: UITableView?
    @IBOutlet var backgroundBtn: UIButton?
    @IBOutlet var selectSubsidyContainerView: UIView?
    @IBOutlet var noDataVw: UIView?
    @IBOutlet var headerLbl: UILabel?
    @IBOutlet var cancelBtn: UIButton?
    @IBOutlet var okBtn: UIButton?
    var origin: CGPoint?
    var completionHandler: (String) -> Void = { _ in }
    var selectedIndexPaths: [Int] = []
    var isDidSelect: Bool = false
    var selectedSubsidyPlans: [PatientDetailModel.SubsidyPlan] = []
    var selectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
//        headerLbl?.isHidden = true
        noDataVw?.isHidden = true
        TblVw?.dataSource = self
        TblVw?.delegate = self
        TblVw?.allowsSelection = true
        TblVw?.showsVerticalScrollIndicator = false
        TblVw?.showsHorizontalScrollIndicator = false
        selectSubsidyContainerView?.layer.cornerRadius  = 8
        selectSubsidyContainerView?.layer.masksToBounds = true
    }
    
//    func setUI() {
//        if !selectedIndexPaths.isEmpty {
//            headerLbl?.isHidden = false
//        } else {
//            headerLbl?.isHidden = true
//        }
//    }
    
    @IBAction func backgroundBtnAction() {
        self.dismiss(animated: false)
    }
    
    @IBAction func cancelBtnAction() {
        self.dismiss(animated: false)
    }
    
    @IBAction func okAction() {
        self.completionHandler(selectedText)
        self.dismiss(animated: false)
    }
}

extension SelectSubsidyPlanPopUp: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSubsidyPlans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectSubsidyPlanPopUpCell", for: indexPath) as! SelectSubsidyPlanPopUpCell
        cell.actionTypeNameLbl?.text = selectedSubsidyPlans[indexPath.row].subsidyPlanName
        cell.parent = self
        cell.isSchemeSelected = selectedIndexPaths.contains(indexPath.row)
        cell.checkButtonAction = { [weak self] in
            if let index = self?.selectedIndexPaths.firstIndex(of: indexPath.row) {
                self?.selectedIndexPaths.remove(at: index)
            } else {
                self?.selectedIndexPaths.append(indexPath.row)
            }
//            self?.setUI()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = self.selectedIndexPaths.firstIndex(of: indexPath.row) {
            self.selectedIndexPaths.remove(at: index)
        } else {
            self.selectedIndexPaths.append(indexPath.row)
        }
//        self.setUI()
        tableView.reloadData()
    }
}

class SelectSubsidyPlanPopUpCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var actionTypeNameLbl: UILabel?
    @IBOutlet var dateTxtFld: UITextField?
    @IBOutlet var chcekBtn: UIButton?
    @IBOutlet var vw: UIView?
    
    var dropDown = DropDown()
    var dropdownOptions: [String] = ["Valid", "Expired"]
    var checkButtonAction: (() -> Void)?
    var parent: SelectSubsidyPlanPopUp?
    
    var isSchemeSelected: Bool = false {
        didSet {
            if isSchemeSelected {
                chcekBtn?.tintColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
                chcekBtn?.setImage(UIImage(named: "addcheck"), for: .normal)
                dateTxtFld?.isHidden = false
            } else {
                chcekBtn?.setImage(UIImage(named: "uncheck"), for: .normal)
                dateTxtFld?.isHidden = true
                dropDown.hide()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.dropShadow()
        configureDropdown()
        setupButtonAction()
        
        // Set the delegate to prevent keyboard appearance
        dateTxtFld?.delegate = self
    }
    
    private func configureDropdown() {
        dropDown.anchorView = dateTxtFld
        dropDown.dataSource = dropdownOptions
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dateTxtFld?.text = item
            self?.parent?.selectedText = item
            self?.dropDown.hide()
        }
        
        dropDown.dismissMode = .automatic
        dateTxtFld?.isUserInteractionEnabled = true
        dateTxtFld?.addTarget(self, action: #selector(showDropdown), for: .editingDidBegin)
    }
    
    @objc private func showDropdown() {
        dropDown.show()
    }
    
    private func setupButtonAction() {
        chcekBtn?.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
    }
    
    @objc private func checkButtonClicked() {
        checkButtonAction?()
    }
    
    // ✅ Prevent Keyboard from Opening
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTxtFld {
            showDropdown()
            return false  // Prevents keyboard from appearing
        }
        return true
    }
}
