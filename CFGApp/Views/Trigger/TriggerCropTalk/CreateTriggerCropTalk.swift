//
//  CreateTriggerCropTalk.swift
//  CFGApp
//
//  Created by Sakshi on 25/03/25.
//

import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class CreateTriggerCropTalk: UIViewController {
    @IBOutlet var selectPatientNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var submitBtn: UIButton?
    @IBOutlet var footerView: UIView?
    @IBOutlet var tablevw: UITableView?
    var dropdown = DropDown()
    let dateFormatter = DateFormatter()
    var selectedIndex = -1
    var patientNamesToIDs: [String: [String]] = [:]
    var patientId = ""
    var patientPickerData = [String]()
    var filteredPatientNames: [String] = []
    var debounceTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setupPatientData()
        Utility.getAllPatient(outerClosure: { success in
            self.loadPatientNames()
            self.setupDropdown()
        })
        selectPatientNameTxtFld?.delegate = self
        addTapGestureToDismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GlobalData.patientDetailData.removeAll()
    }
    
    func setInitialUI() {
        submitBtn?.layer.masksToBounds = false
        submitBtn?.layer.cornerRadius = 8
        tablevw?.isHidden = true
//        footerView?.isHidden = true
        tablevw?.layer.masksToBounds = false
        tablevw?.layer.cornerRadius = 8
        tablevw?.layer.cornerRadius = 12
        tablevw?.layer.borderWidth = 0.5
        tablevw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        tablevw?.layer.masksToBounds = false
        tablevw?.dropShadowTableView()
        
        selectPatientNameTxtFld?.label.text = "Select Patients"
        selectPatientNameTxtFld?.setOutlineColor(UIColor.gray, for: .normal)
        selectPatientNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectPatientNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        selectPatientNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        selectPatientNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectPatientNameTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
                    self.submitBtn?.isHidden = false
                    self.tablevw?.isHidden = false
//                    self.footerView?.isHidden = false
                    print("Selected Patient ID: \(self.patientId)")
                } else {
                    self.showIDDropdown(for: selectedItem)
                }
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
    
}

extension CreateTriggerCropTalk: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let searchText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""

            if textField == selectPatientNameTxtFld {
                if searchText.isEmpty {
                    self.filteredPatientNames.removeAll()
                    self.footerView?.isHidden = true
                    self.tablevw?.isHidden = true
                    self.dropdown.hide()
                } else {
                    self.filteredPatientNames = self.patientNamesToIDs.keys.filter { $0.lowercased().contains(searchText) }
                    
                    if !self.filteredPatientNames.isEmpty {
                        self.tablevw?.isHidden = false
                        self.footerView?.isHidden = false
                        self.dropdown.dataSource = self.filteredPatientNames
                        self.dropdown.reloadAllComponents()

                        DispatchQueue.main.async {
                            self.dropdown.show()
                        }
                    } else {
                        self.footerView?.isHidden = true
                        self.tablevw?.isHidden = true
                        self.dropdown.hide()
                    }
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == selectPatientNameTxtFld {
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

extension CreateTriggerCropTalk: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CreateCropTalkPatientsCell = tableView.dequeueReusableCell(withIdentifier: "CreateCropTalkPatientsCell", for: indexPath) as! CreateCropTalkPatientsCell
        cell.patientNameLabl?.text = "pendingCaseData.name"
        cell.clinicNameLabl?.text = "pendingCaseData.name"
        cell.doctorNameLabl?.text = "pendingCaseData.name"
        cell.employerNameLabl?.text = "pendingCaseData.name"
        return cell
    }
    
}

class CreateCropTalkPatientsCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var patientNameLabl: UILabel?
    @IBOutlet var clinicNameLabl: UILabel?
    @IBOutlet var doctorNameLabl: UILabel?
    @IBOutlet var employerNameLabl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}



