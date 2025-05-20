//
//  CreateRedFlagTicketVC.swift
//  CFGApp
//
//  Created by Sakshi on 10/02/25.
//

import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class CreateRedFlagTicketVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var patientNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var selectConcernTxtView: UITextView?
    @IBOutlet var healthCardLabl: UILabel?
    @IBOutlet var patientLabl: UILabel?
    @IBOutlet var clinicLabl: UILabel?
    @IBOutlet var financialBalLabl: UILabel?
    @IBOutlet var subsidyPlanLabl: UILabel?
    @IBOutlet var frequencyLabl: UILabel?
    @IBOutlet var getPatientBtn: UIButton?
    @IBOutlet var bottomVw: UIView?
    @IBOutlet var getPatientView: UIView?
    @IBOutlet var detailPatientDataView: UIView?
    @IBOutlet var createFlagView: UIView?
    @IBOutlet var headerView: UIView?
    @IBOutlet var noDataView: UIView?
    @IBOutlet var patientName: UILabel?
    @IBOutlet var clinictName: UILabel?
    @IBOutlet var createRedFlag: UIButton?
    @IBOutlet var nextBtn: UIButton?
    var selectedIndex = -1
    var patientNamesToIDs: [String: [String]] = [:]
    var patientId = ""
    var healthCardId = ""
    var patientPickerData = [String]()
    let dateFormatter = DateFormatter()
    var dropdown = DropDown()
    var filteredPatientNames: [String] = []
    var debounceTimer: Timer?
    var selectedHealthCard: PatientDetailModel.HealthClass?
    var concernsList = ["Not getting better", "Problems got worse", "No improvement at all", "Not happy with clinic staff services", "Not happy with Doctor’s adjustment techniques", "Don’t like Doctor’s attitude", "Non-Compliance on frequency", "Not co-operative on following clinic process (eg. PPR, Thumbs-up)"]
    var filteredConcerns: [String] = []
    var redFlagService = RedFlagService()
    var completionHandler: (String) -> Void = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectConcernTxtView?.inputView = UIView()
        detailPatientDataView?.layer.masksToBounds = false
        detailPatientDataView?.layer.cornerRadius = 8
        detailPatientDataView?.dropShadowTableView()
        dropdown.anchorView = view
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 12)
        setInitialUI()
        setupPatientData()
        Utility.getAllPatient(outerClosure: { success in
            self.loadPatientNames()
            self.setupDropdown()
        })
        patientNameTxtFld?.delegate = self
        selectConcernTxtView?.delegate = self
        addTapGestureToDismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GlobalData.patientDetailData.removeAll()
    }
    
    func setInitialUI() {
        tableView?.delegate = self
        tableView?.dataSource = self
        patientNameTxtFld?.label.text = "Select Patient Name"
        patientNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .normal)
        patientNameTxtFld?.setOutlineColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        patientNameTxtFld?.setNormalLabelColor(UIColor.gray, for: .normal) // Placeholder color
        patientNameTxtFld?.setFloatingLabelColor(UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0), for: .editing)
        patientNameTxtFld?.setLeadingAssistiveLabelColor(UIColor.systemGray, for: .normal)
        
        selectConcernTxtView?.layer.masksToBounds = false
        selectConcernTxtView?.layer.cornerRadius = 8
        selectConcernTxtView?.textColor = .darkGray
        selectConcernTxtView?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        selectConcernTxtView?.borderWidth = 1
        selectConcernTxtView?.borderColor = UIColor(red: 114.0 / 255.0, green: 47.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
        
        getPatientBtn?.layer.masksToBounds = false
        getPatientBtn?.layer.cornerRadius = 8
        nextBtn?.layer.masksToBounds = false
        nextBtn?.layer.cornerRadius = 8
        createRedFlag?.layer.masksToBounds = false
        createRedFlag?.layer.cornerRadius = 8
        patientNameTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == patientNameTxtFld {
            dropdown.dataSource = filteredPatientNames
            dropdown.anchorView = patientNameTxtFld
            if let textFieldFrame = patientNameTxtFld?.superview?.convert(patientNameTxtFld!.frame, to: view) {
                dropdown.bottomOffset = CGPoint(x: 0, y: textFieldFrame.height)
            }
        }
        dropdown.direction = .bottom
        dropdown.reloadAllComponents()
        if !dropdown.dataSource.isEmpty {
            dropdown.show()
        }
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView == selectConcernTxtView {
//            dropdown.dataSource = concernsList
//            dropdown.anchorView = selectConcernTxtView
//            if let textViewFrame = selectConcernTxtView?.superview?.convert(selectConcernTxtView!.frame, to: view) {
//                print("🟢 TextField Frame in View: \(textViewFrame)")
//                print("🟢 TextField Bottom Y Position: \(textViewFrame.maxY)")
//                dropdown.bottomOffset = CGPoint(x: 0, y: textViewFrame.height + 5)
//            }
//        }
//        dropdown.direction = .bottom
//        dropdown.reloadAllComponents()
//        if !dropdown.dataSource.isEmpty {
//            dropdown.show()
//        }
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == selectConcernTxtView {
            
            dropdown.dataSource = concernsList
            dropdown.anchorView = selectConcernTxtView
            
            if let textViewFrame = selectConcernTxtView?.superview?.convert(selectConcernTxtView!.frame, to: view) {
                
                print("🟢 TextView Frame: \(textViewFrame)")
                
                let leadingTrailingPadding: CGFloat = 5
                
                // Set dropdown width = TextView width - padding
                dropdown.width = textViewFrame.width - (leadingTrailingPadding * 2)
                
                // Shift dropdown to right by padding value
                dropdown.bottomOffset = CGPoint(x: leadingTrailingPadding, y: textViewFrame.height + 5)
            }
            
            dropdown.direction = .bottom
            dropdown.reloadAllComponents()
            
            if !dropdown.dataSource.isEmpty {
                dropdown.show()
            }
        }
    }
    
    private func setupDropdown() {
        dropdown.selectionAction = { [weak self] (index: Int, selectedItem: String) in
            guard let self = self else { return }
            if self.patientNameTxtFld?.isFirstResponder == true {
                self.patientNameTxtFld?.text = selectedItem
                let ids = self.patientNamesToIDs[selectedItem] ?? []
                if ids.count == 1 {
                    self.patientId = ids.first ?? ""
                    getPatientBtn?.isHidden = false
                    print("Selected Patient ID: \(self.patientId)")
                } else {
                    self.showIDDropdown(for: selectedItem)
                }
            } else if self.selectConcernTxtView?.isFirstResponder == true {
                self.selectConcernTxtView?.text = selectedItem
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
        idDropdown.anchorView = patientNameTxtFld
        idDropdown.topOffset = CGPoint(x: 0, y: -(patientNameTxtFld?.frame.height ?? 0))
        idDropdown.dataSource = ids
        idDropdown.selectionAction = { [weak self] (index: Int, selectedId: String) in
            guard let self = self else { return }
            self.patientId = selectedId
            print("Patient ID: \(selectedId)")
        }
        idDropdown.show()
    }
    //
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
    
    func setupPatientDetail() {
        if let patientDetail = GlobalData.patientDetailData.first {
            patientLabl?.text = patientDetail.name
            clinicLabl?.text = patientDetail.clinicName
        }
        if let healthCard = selectedHealthCard {
            healthCardId = healthCard.healthCardId
            healthCardLabl?.text = healthCard.healthCardNumber
            financialBalLabl?.text = "$\(healthCard.financialBalance)"
            subsidyPlanLabl?.text = healthCard.subsidyPlanType
            frequencyLabl?.text = healthCard.frequency
        }
    }
    
    func submit() {
        var payload: [String: Any] = [
            "patient_id": patientId,
            "concern_name": selectConcernTxtView?.text ?? "",
            "health_card_id": healthCardId
        ]
        if let patientDetail = GlobalData.patientDetailData.first {
            payload["clinic_name"] = patientDetail.clinicId
        }
        redFlagService.submitNewTicketForRedFlag(param: payload) { error, response, statusCode in
            if error == nil {
                SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                self.completionHandler(EMPTY)
                self.navigationController?.popViewController(animated: true)
            } else {
                SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
            }
        }
    }
    
    @IBAction func nextAction() {
        if selectedIndex < 0  {
            self.view.makeToast(PLEASE_SELECT_PATIENT_ID)
        } else if selectedIndex >= 0 {
            detailPatientDataView?.isHidden = false
            createFlagView?.isHidden = false
            getPatientView?.isHidden = true
            tableView?.isHidden = true
            noDataView?.isHidden = true
        }
        
    }
    
    @IBAction func createFlagAction() {
        guard let concernText = selectConcernTxtView?.text, !concernText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            SceneDelegate.getSceneDelegate().window?.makeToast(PLEASE_SELECT_CONCERN)
            return
        }
        let alert = UIAlertController(title: "Confirm Submission",
                                      message: "Do you really want to Create Red Flag?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES", style: .default) { _ in
            self.submit()
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDataAction() {
        if !patientId.isEmpty {
            Utility.getDataBasedOnPatientId(id: patientId) { success in
                if success, let patientDetail = GlobalData.patientDetailData.first {
                    self.headerView?.isHidden = false
                    self.patientName?.text = patientDetail.name
                    self.clinictName?.text = patientDetail.clinicName
                    if GlobalData.patientDetailData.first?.healthClassList?.count ?? 0 > 0  {
                        self.headerView?.isHidden = false
                        self.noDataView?.isHidden = true
                        self.tableView?.isHidden = false
                        self.tableView?.reloadData()
                    } else {
                        self.headerView?.isHidden = true
                        self.noDataView?.isHidden = false
                        self.bottomVw?.isHidden = true
                        self.tableView?.isHidden = true
                    }
                } else {
                    self.headerView?.isHidden = true
                    self.noDataView?.isHidden = false
                    self.bottomVw?.isHidden = true
                    self.tableView?.isHidden = true
                }
            }
        } else {
            self.view.makeToast(PLEASE_SELECT_PATIENT_ID)
            self.headerView?.isHidden = true
        }
        
    }
    
    func showSabsidyPopup() {
        self.view.endEditing(true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Refunds", bundle:nil)
        let vc = (storyBoard.instantiateViewController(identifier: "SelectSubsidyPlanPopUp")) as! SelectSubsidyPlanPopUp
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3966007864)
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let searchText = textField.text?.lowercased() ?? ""
            
            if textField == patientNameTxtFld {
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
            //            else if textField == selectConcernTxtFld {
            //                if searchText.isEmpty {
            //                    self.filteredConcerns = self.concernsList
            //                    self.dropdown.hide()
            //                } else {
            //                    self.filteredConcerns = self.concernsList.filter { $0.lowercased().contains(searchText) }
            //                    if !self.filteredConcerns.isEmpty {
            //                        self.dropdown.show()
            //                    } else {
            //                        self.dropdown.hide()
            //                    }
            //                }
            //                self.dropdown.dataSource = self.filteredConcerns
            //            }
            
            self.dropdown.reloadAllComponents()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let searchText = textView.text?.lowercased() ?? ""
            if textView == selectConcernTxtView {
                if searchText.isEmpty {
                    self.filteredConcerns = self.concernsList
                    self.dropdown.hide()
                } else {
                    self.filteredConcerns = self.concernsList.filter { $0.lowercased().contains(searchText) }
                    if !self.filteredConcerns.isEmpty {
                        self.dropdown.show()
                    } else {
                        self.dropdown.hide()
                    }
                }
                self.dropdown.dataSource = self.filteredConcerns
            }
            
            self.dropdown.reloadAllComponents()
        }
    }
}

extension CreateRedFlagTicketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalData.patientDetailData.first?.healthClassList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CreateRedFlagCell = tableView.dequeueReusableCell(withIdentifier: "CreateRedFlagCell", for: indexPath) as! CreateRedFlagCell
        let patientHealthCardData = GlobalData.patientDetailData.first?.healthClassList?[indexPath.row]
        cell.healthCardLabl?.text = patientHealthCardData?.healthCardNumber
        cell.financialBalLabl?.text =  "$\(patientHealthCardData?.financialBalance ?? "$0.00")"
        cell.subsidyPlanLabl?.text = patientHealthCardData?.subsidyPlanType
        cell.frequencyLabl?.text = patientHealthCardData?.frequency
        cell.selectionBtn?.setImage(UIImage(named: "circle_unselect"), for: .normal)
        cell.selectionStyle = .default
        if self.selectedIndex == indexPath.row {
            cell.selectionBtn?.tintColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
            cell.selectionBtn?.setImage(UIImage(named: "circle_selected"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let healthClassList = GlobalData.patientDetailData.first?.healthClassList else {
            return
        }
        guard indexPath.row < healthClassList.count else {
            return
        }
        let selectedHealthCard = healthClassList[indexPath.row]
        if let currentSelected = self.selectedHealthCard, currentSelected.healthCardId == selectedHealthCard.healthCardId {
            return
        }
        self.selectedHealthCard = selectedHealthCard
        self.selectedIndex = indexPath.row
        setupPatientDetail()
        bottomVw?.isHidden = false
        self.tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

class CreateRedFlagCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var healthCardLabl: UILabel?
    @IBOutlet var financialBalLabl: UILabel?
    @IBOutlet var subsidyPlanLabl: UILabel?
    @IBOutlet var frequencyLabl: UILabel?
    @IBOutlet var selectionBtn: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}
