//
//  EditTriggerEventVC.swift
//  CFGApp
//
//  Created by Sakshi on 27/03/25.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown

class EditTriggerEventVC: UIViewController {
    @IBOutlet var nextView: UIView?
    @IBOutlet var initialView: UIView?
    @IBOutlet var initialTableVwView: UITableView?
    @IBOutlet var nextTableVwView: UITableView?
    
    @IBOutlet var editBtn: UIButton?
    @IBOutlet var backToListBtn: UIButton?
    @IBOutlet var triggerIdLbl: UILabel?
    @IBOutlet var eventNameLbl: UILabel?
    @IBOutlet var startDateLbl: UILabel?
    @IBOutlet var endDateLbl: UILabel?
    @IBOutlet var createdAtLbl: UILabel?
    @IBOutlet var detailView: UIView?
    @IBOutlet var headerView: UIView?
    @IBOutlet var footerView: UIView?
    
    @IBOutlet var selectEventNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var startDateTxtFld: MDCOutlinedTextField?
    @IBOutlet var startTimeTxtFld: MDCOutlinedTextField?
    @IBOutlet var endDateTxtFld: MDCOutlinedTextField?
    @IBOutlet var endTimeTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectPatientNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var submitBtn: UIButton?
    
    var dropdown = DropDown()
    let dateFormatter = DateFormatter()
    var selectedIndex = -1
    var patientNamesToIDs: [String: [String]] = [:]
    var patientId = ""
    var patientPickerData = [String]()
    var filteredPatientNames: [String] = []
    var debounceTimer: Timer?
    var datePicker = UIDatePicker()
    let timePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        nextView?.isHidden = true
        addTapGestureToDismissKeyboard()
    }
    
    func setInitialUI() {
        detailView?.layer.masksToBounds = false
        detailView?.layer.cornerRadius = 8
        detailView?.dropShadowTableView()
        detailView?.layer.cornerRadius = 8
        submitBtn?.layer.masksToBounds = false
        submitBtn?.layer.cornerRadius = 8
        backToListBtn?.layer.masksToBounds = false
        backToListBtn?.layer.cornerRadius = 8
        
        selectEventNameTxtFld?.label.text = "Event Name"
        selectEventNameTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        selectEventNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectEventNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectEventNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectEventNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        startDateTxtFld?.label.text = "Start Date"
        startDateTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        startDateTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        startDateTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        startDateTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        startDateTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        startTimeTxtFld?.label.text = "Start Time"
        startTimeTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        startTimeTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        startTimeTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        startTimeTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        startTimeTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        endDateTxtFld?.label.text = "End Date"
        endDateTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        endDateTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        endDateTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        endDateTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        endDateTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        endTimeTxtFld?.label.text = "End Time"
        endTimeTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        endTimeTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        endTimeTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        endTimeTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        endTimeTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectPatientNameTxtFld?.label.text = "Select Patients"
        selectPatientNameTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        selectPatientNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectPatientNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectPatientNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectPatientNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectEventNameTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        selectPatientNameTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([donebtn], animated: true)
        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = .date
        startDateTxtFld?.inputAccessoryView = toolbar
        startDateTxtFld?.inputView = datePicker
        endDateTxtFld?.inputAccessoryView = toolbar
        endDateTxtFld?.inputView = datePicker
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date)
        if (startDateTxtFld?.isFirstResponder ?? true) {
            startDateTxtFld?.text = selectedDate
        } else if (endDateTxtFld?.isFirstResponder ?? true) {
            endDateTxtFld?.text = selectedDate
        }
        self.view.endEditing(true)
    }
    
    // MARK: - Time Picker
    func createTimePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timeDonePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        timePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        timePicker.datePickerMode = .time
        
        startTimeTxtFld?.inputAccessoryView = toolbar
        startTimeTxtFld?.inputView = timePicker
        endTimeTxtFld?.inputAccessoryView = toolbar
        endTimeTxtFld?.inputView = timePicker
    }
    
    @objc func timeDonePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // Format as 12-hour time with AM/PM
        let selectedTime = formatter.string(from: timePicker.date)
        
        if startTimeTxtFld?.isFirstResponder == true {
            startTimeTxtFld?.text = selectedTime
        } else if endTimeTxtFld?.isFirstResponder == true {
            endTimeTxtFld?.text = selectedTime
        }
        self.view.endEditing(true)
    }
    
    private func setupPatientData() {
        for patient in GlobalData.allPatientData {
            let name = patient.Name ?? ""
            let id = patient.Id ?? ""
            if !name.isEmpty, !id.isEmpty {
                if patientNamesToIDs[name] != nil {
                    patientNamesToIDs[name]?.append(id)
                } else {
                    patientNamesToIDs[name] = [id]
                }
            }
        }
    }
    
    private func setupDropdown() {
        dropdown.selectionAction = { [weak self] (index: Int, selectedItem: String) in
            guard let self = self else { return }
            if self.selectPatientNameTxtFld?.isFirstResponder == true {
                self.selectPatientNameTxtFld?.text = selectedItem
                let ids = self.patientNamesToIDs[selectedItem] ?? []
                if ids.count == 1 {
                    self.patientId = ids.first ?? ""
                    submitBtn?.isHidden = false
                    print("Selected Patient ID: \(self.patientId)")
                } else {
                    self.showIDDropdown(for: selectedItem)
                }
            } else if self.selectEventNameTxtFld?.isFirstResponder == true {
                //                self.selectEventNameTxtFld?.text = selectedItem
            }
            self.dropdown.hide()
        }
    }
    
    @objc private func showNameDropdown() {
        view.layoutIfNeeded()
        dropdown.dataSource = filteredPatientNames
        dropdown.reloadAllComponents()
        if !filteredPatientNames.isEmpty {
            dropdown.show()
        }
    }
    
    private func showIDDropdown(for patientName: String) {
        guard let ids = patientNamesToIDs[patientName], ids.count > 1 else { return }
        let idDropdown = DropDown()
        idDropdown.anchorView = selectPatientNameTxtFld
        idDropdown.topOffset = CGPoint(x: 0, y: -(selectPatientNameTxtFld?.frame.height ?? 0))
        idDropdown.dataSource = ids
        idDropdown.selectionAction = { [weak self] (index: Int, selectedId: String) in
            guard let self = self else { return }
            self.patientId = selectedId
            print("Patient ID: \(selectedId)")
        }
        idDropdown.show()
    }
    
    func loadPatientNames() {
        filteredPatientNames = GlobalData.allPatientData.map { $0.Name ?? "" }
        patientNamesToIDs = Dictionary(grouping: GlobalData.allPatientData, by: { $0.Name ?? "" }).mapValues { $0.compactMap { $0.Id } }
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editAction() {
        initialView?.isHidden = true
        nextView?.isHidden = false
    }
    
    @IBAction func backToListAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction() {
//        guard let concernText = selectEventNameTxtFld?.text, !concernText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            SceneDelegate.getSceneDelegate().window?.makeToast(PLEASE_SELECT_EVENT)
//            return
//        }
//        guard let concernText = startDateTxtFld?.text, !concernText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            SceneDelegate.getSceneDelegate().window?.makeToast(PLEASE_SELECT_START_DATE_TIME)
//            return
//        }
//        guard let concernText = startTimeTxtFld?.text, !concernText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            SceneDelegate.getSceneDelegate().window?.makeToast(PLEASE_SELECT_START_DATE_TIME)
//            return
//        }
//        guard let concernText = endDateTxtFld?.text, !concernText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            SceneDelegate.getSceneDelegate().window?.makeToast(PLEASE_SELECT_END_DATE_TIME)
//            return
//        }
//        guard let concernText = endTimeTxtFld?.text, !concernText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            SceneDelegate.getSceneDelegate().window?.makeToast(PLEASE_SELECT_END_DATE_TIME)
//            return
//        }
        
        let alert = UIAlertController(title: "Update Confirmation",
                                      message: "Are You Sure With This Updation",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES PROCEED", style: .default) { _ in
            self.submit()
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func submit() {
        SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_EVENT_HAS_BEEN_CREATED)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditTriggerEventVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let searchText = textField.text?.lowercased() ?? ""
            
            if textField == selectPatientNameTxtFld {
                if searchText.isEmpty {
                    self.filteredPatientNames = Array(self.patientNamesToIDs.keys)
                    self.dropdown.hide()
                } else {
                    self.filteredPatientNames = self.patientNamesToIDs.keys.filter { $0.lowercased().contains(searchText) }
                    if !self.filteredPatientNames.isEmpty {
                        self.dropdown.show()
                    } else {
                        self.dropdown.hide()
                    }
                }
                self.dropdown.dataSource = self.filteredPatientNames
            }
            else if textField == selectEventNameTxtFld {
                
            }
            
            self.dropdown.reloadAllComponents()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == startDateTxtFld {
            self.createDatePicker()
        } else if textField == endDateTxtFld {
            self.createDatePicker()
        } else if textField == startTimeTxtFld {
            self.createTimePicker()
        } else if textField == endTimeTxtFld {
            self.createTimePicker()
        } else if textField == selectPatientNameTxtFld {
            dropdown.dataSource = filteredPatientNames
            dropdown.anchorView = selectPatientNameTxtFld
            if let textFieldFrame = selectPatientNameTxtFld?.superview?.convert(selectPatientNameTxtFld!.frame, to: view) {
                dropdown.bottomOffset = CGPoint(x: 0, y: textFieldFrame.height)
            }
        }
        dropdown.direction = .bottom
        dropdown.reloadAllComponents()
        
        if !dropdown.dataSource.isEmpty {
            dropdown.show()
        }
    }
    
}

extension EditTriggerEventVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == initialTableVwView {
            let cell: InitialTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InitialTableViewCell", for: indexPath) as! InitialTableViewCell
            return cell
            
        } else if tableView == nextTableVwView {
            let cell: NextTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NextTableViewCell", for: indexPath) as! NextTableViewCell
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
}

class InitialTableViewCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var patientLabl: UILabel?
    @IBOutlet var clinicLabl: UILabel?
    @IBOutlet var doctorNameLabl: UILabel?
    @IBOutlet var checkBoxLabl: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}

class NextTableViewCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var patientLabl: UILabel?
    @IBOutlet var clinicLabl: UILabel?
    @IBOutlet var doctorNameLabl: UILabel?
    @IBOutlet var checkBoxLabl: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}
    
