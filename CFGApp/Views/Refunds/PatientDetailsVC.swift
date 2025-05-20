import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class PatientDetailsVC: UIViewController, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var patientNameTxtFld: MDCOutlinedTextField?
    @IBOutlet var getPatientBtn: UIButton?
    @IBOutlet var nexttBtn: UIButton?
    @IBOutlet var bottomVw: UIView?
    @IBOutlet var headerView: UIView?
    @IBOutlet var patientLabl: UILabel?
    @IBOutlet var noDataView: UIView?
    var selectedIndex = -1
    var patientNamesToIDs: [String: [String]] = [:]
    var patientId = ""
    var patientPickerData = [String]()
    let dateFormatter = DateFormatter()
    var dropdown = DropDown()
    var filteredPatientNames: [String] = []
    var debounceTimer: Timer?
    var selectedSubsidyPlans: [PatientDetailModel.SubsidyPlan] = []
    var validityType = ""
    var subsidyPlan = ""
    var HealthCardId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialUI()
        setupPatientData()
        Utility.getAllPatient(outerClosure: { success in
            self.loadPatientNames()
            self.setupDropdown()
        })
        patientNameTxtFld?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dropdown.anchorView = patientNameTxtFld
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
        getPatientBtn?.layer.masksToBounds = false
        getPatientBtn?.layer.cornerRadius = 8
        nexttBtn?.layer.masksToBounds = false
        nexttBtn?.layer.cornerRadius = 8
        patientNameTxtFld?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNameDropdown))
        patientNameTxtFld?.addGestureRecognizer(tapGesture)
        patientNameTxtFld?.isUserInteractionEnabled = true
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
            dropdown.bottomOffset = CGPoint(x: 0, y: patientNameTxtFld?.frame.height ?? 50.0)
            dropdown.show()
        }
    }
    
    private func setupDropdown() {
        dropdown.anchorView = patientNameTxtFld
        dropdown.bottomOffset = CGPoint(x: 0, y: (patientNameTxtFld?.frame.height ?? 50.0))
        dropdown.dataSource = filteredPatientNames
        dropdown.selectionAction = { [weak self] (index: Int, selectedName: String) in
            guard let self = self else { return }
            
            self.patientNameTxtFld?.text = selectedName
            
            let ids = self.patientNamesToIDs[selectedName] ?? []
            if ids.count == 1 {
                self.patientId = ids.first ?? ""
                print("Selected Patient ID: \(self.patientId)")
                
            } else {
                self.showIDDropdown(for: selectedName)
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
    
    func loadPatientNames() {
        filteredPatientNames = GlobalData.allPatientData.map { $0.Name ?? "" }
        patientNamesToIDs = Dictionary(grouping: GlobalData.allPatientData, by: { $0.Name ?? "" }).mapValues { $0.compactMap { $0.Id } }
        
        if filteredPatientNames.isEmpty {
            print("⚠️ No patient names available!")
        }
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func nextAction() {
        if HealthCardId.isEmpty {
            let checkInalert = UIAlertController(
                title: "Alert",
                message: "Please Select Health card",
                preferredStyle: .alert
            )
            self.present(checkInalert, animated: true, completion: nil)
            checkInalert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            }))
        } else if validityType.isEmpty {
            let checkInalert = UIAlertController(
                title: "Info",
                message: "please select subsidy plan and validity",
                preferredStyle: .alert
            )
            self.present(checkInalert, animated: true, completion: nil)
            checkInalert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            }))
            
        } else {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Refunds", bundle: storyboardBundle)
            let SubsidyTerminationFormVC = storyboard.instantiateViewController(withIdentifier: "SubsidyTerminationForm") as! SubsidyTerminationForm
            SubsidyTerminationFormVC.patientId = patientId
            SubsidyTerminationFormVC.selectedSubsidyPlans = selectedSubsidyPlans
            SubsidyTerminationFormVC.validityType = validityType
            self.navigationController?.pushViewController(SubsidyTerminationFormVC, animated: true)
        }
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDataAction() {
        selectedIndex = -1
        if !patientId.isEmpty {
            Utility.getDataBasedOnPatientId(id: patientId) { success in
                if success, let patientDetail = GlobalData.patientDetailData.first {
                    self.headerView?.isHidden = false
                    self.patientLabl?.text = patientDetail.name
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
        vc.completionHandler = { textState in
            self.validityType = textState
        }
        vc.selectedSubsidyPlans = self.selectedSubsidyPlans
        self.present(vc, animated: false, completion: nil)
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            let searchText = textField.text?.lowercased() ?? ""
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
            self.dropdown.reloadAllComponents()
        }
    }
}

extension PatientDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalData.patientDetailData.first?.healthClassList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PatientDetailsCell = tableView.dequeueReusableCell(withIdentifier: "PatientDetailsCell", for: indexPath) as! PatientDetailsCell
        var patientHealthCardData = GlobalData.patientDetailData.first?.healthClassList?[indexPath.row]
        cell.healthCardLabl?.text = patientHealthCardData?.healthCardNumber
        cell.financialBalLabl?.text = String(format: "$%.2f", patientHealthCardData?.financialBalance ?? 0.0)
        cell.subsidyPlanLabl?.text = patientHealthCardData?.subsidyPlanType
        cell.planeNameLabl?.text = patientHealthCardData?.frequency
        cell.datePurchaseLabl?.text = patientHealthCardData?.frequency
        cell.selectionBtn?.setImage(UIImage(named: "circle_unselect"), for: .normal)
        cell.selectionStyle = .default
        if self.selectedIndex == indexPath.row {
            cell.selectionBtn?.tintColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
            cell.selectionBtn?.setImage(UIImage(named: "circle_selected"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let healthClassList = GlobalData.patientDetailData.first?.healthClassList,
              indexPath.row < healthClassList.count else {
            return
        }
        
        let selectedHealthClass = healthClassList[indexPath.row]
        let selectedHealthCardId = selectedHealthClass.healthCardId
        HealthCardId = selectedHealthCardId
        if selectedHealthClass.subsidyPlanList.isEmpty {
            let checkInAlert = UIAlertController(
                title: "Alert",
                message: "No Subsidy Plan found!",
                preferredStyle: .alert
            )
            checkInAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                print("Cancel tapped")
            }))
            self.present(checkInAlert, animated: true, completion: nil)
        } else {
            self.selectedSubsidyPlans = selectedHealthClass.subsidyPlanList
            showSabsidyPopup()
        }
        self.selectedIndex = indexPath.row
        bottomVw?.isHidden = false
        self.tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}

class PatientDetailsCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var healthCardLabl: UILabel?
    @IBOutlet var financialBalLabl: UILabel?
    @IBOutlet var subsidyPlanLabl: UILabel?
    @IBOutlet var planeNameLabl: UILabel?
    @IBOutlet var datePurchaseLabl: UILabel?
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
