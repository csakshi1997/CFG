//
//  RedFlagListVc.swift
//  CFGApp
//
//  Created by Sakshi on 10/02/25.
//

import UIKit

class RedFlagListVc: UIViewController {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var pendingBtn: UIButton?
    @IBOutlet var searchVw: UISearchBar?
    @IBOutlet var ClosedBtn: UIButton?
    @IBOutlet var floatingButton: UIButton?
    @IBOutlet var noDataFoundVw: UIView?
    var RedFlagservice = RedFlagService()
    var isPending: Bool = true
    var customDateFormatter = CustomDateFormatter()
    var isSearching = false
    var originalPendingData: [PendingRedFlagModel] = []
    var originalClosedData: [ClosingRedFlagModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingButton?.layer.cornerRadius = 25
        searchVw?.delegate = self
        isPending = true
        pendingBtn?.backgroundColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
        pendingBtn?.setTitleColor(.white, for: .normal)
        ClosedBtn?.backgroundColor = .white
        ClosedBtn?.setTitleColor(.black, for: .normal)
        ClosedBtn?.shadowDecorateButton()
        pendingBtn?.shadowDecorateButton()
        DispatchQueue.main.async {
            Utility.getPendingRedFlagData(outerClosure: { success in
                if success {
                    self.originalPendingData = GlobalData.allPendingRedFlagModel
                    if self.originalPendingData.count < 1 {
                        self.noDataFoundVw?.isHidden = false
                        self.tableView?.isHidden = true
                    } else {
                        self.noDataFoundVw?.isHidden = true
                        self.tableView?.isHidden = false
                        self.tableView?.reloadData()
                    }
                    
                }
            })
        }
        
        DispatchQueue.main.async {
            Utility.getClosedRedFlagData(outerClosure: { success in
                if success {
                    self.originalClosedData = GlobalData.allClosingRedFlagModel
                }
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ClosedBtn?.layer.cornerRadius = (ClosedBtn?.frame.height ?? 0) / 2
        ClosedBtn?.clipsToBounds = true
        pendingBtn?.layer.cornerRadius = (pendingBtn?.frame.height ?? 0) / 2
        pendingBtn?.clipsToBounds = true
        addShadowOnButton(to: pendingBtn ?? UIButton())
        addShadowOnButton(to: ClosedBtn ?? UIButton())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            Utility.getPendingRedFlagData(outerClosure: { success in
                if success {
                    self.originalPendingData = GlobalData.allPendingRedFlagModel
                    if self.originalPendingData.count < 1 {
                        self.noDataFoundVw?.isHidden = false
                        self.tableView?.isHidden = true
                    } else {
                        self.noDataFoundVw?.isHidden = true
                        self.tableView?.isHidden = false
                        self.tableView?.reloadData()
                    }
                    
                }
            })
        }
        
        DispatchQueue.main.async {
            Utility.getClosedRedFlagData(outerClosure: { success in
                if success {
                    self.originalClosedData = GlobalData.allClosingRedFlagModel
                }
            })
        }
        searchVw?.text = ""
        resetSearchResults()
        tableView?.reloadData()
        addTapGestureToDismissKeyboard()
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
    
    @IBAction func addIconaAction() {
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
        let createNewCaseVC = storyboard.instantiateViewController(withIdentifier: "CreateRedFlagTicketVC") as! CreateRedFlagTicketVC
        createNewCaseVC.completionHandler = { TEXT in
            self.tableView?.reloadData()
        }
        self.navigationController?.pushViewController(createNewCaseVC, animated: true)
    }
    
    @IBAction func caseAction(sender: UIButton) {
        if sender.tag == 1 {
            pendingBtn?.backgroundColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
            pendingBtn?.setTitleColor(.white, for: .normal)
            ClosedBtn?.backgroundColor = .white
            ClosedBtn?.setTitleColor(.black, for: .normal)
            isPending = true
            print("Pending Maintenance Count: \(GlobalData.allpendingMaintenanceModel.count)")
            if self.originalPendingData.count < 1 {
                self.noDataFoundVw?.isHidden = false
                self.tableView?.isHidden = true
            } else {
                self.noDataFoundVw?.isHidden = true
                self.tableView?.isHidden = false
                self.tableView?.reloadData()
            }
        } else if sender.tag == 2 {
            ClosedBtn?.backgroundColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
            ClosedBtn?.setTitleColor(.white, for: .normal)
            pendingBtn?.backgroundColor = .white
            pendingBtn?.setTitleColor(.black, for: .normal)
            ClosedBtn?.setTitleColor(.white, for: .normal)
            isPending = false
            print("Pending Maintenance Count: \(GlobalData.allpendingMaintenanceModel.count)")
            if self.originalClosedData.count < 1 {
                self.noDataFoundVw?.isHidden = false
                self.tableView?.isHidden = true
            } else {
                self.noDataFoundVw?.isHidden = true
                self.tableView?.isHidden = false
                self.tableView?.reloadData()
            }
        }
    }
}

extension RedFlagListVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPending ? GlobalData.allPendingRedFlagModel.count : GlobalData.allClosingRedFlagModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RedFlagListCell = tableView.dequeueReusableCell(withIdentifier: "RedFlagListCell", for: indexPath) as! RedFlagListCell
        if isPending {
            let pendingCaseData = GlobalData.allPendingRedFlagModel[indexPath.row]
            cell.caseNoLabl?.text = pendingCaseData.name
            cell.patientNameLabl?.text = pendingCaseData.patient?.name
            cell.clinicNameLabl?.text = pendingCaseData.clinic?.name
            cell.healthCardLabl?.text = pendingCaseData.patientHealthCard?.name
            cell.financialBalanceLabl?.text = pendingCaseData.financialBalance == "NA" ? "$0.0" : "$\(pendingCaseData.financialBalance)"
            cell.subsidyTypeLabl?.text = pendingCaseData.typeOfSubsidyPlan == "NA" ? "" : pendingCaseData.typeOfSubsidyPlan
            cell.frequencyLabl?.text = pendingCaseData.frequency == "NA" ? "" : pendingCaseData.frequency
            cell.statusLabl?.text = pendingCaseData.status
            cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingCaseData.createdDate)
            cell.createdAtTimeLabl?.text = customDateFormatter.getDateForCreatedAtTime(dateString: pendingCaseData.createdDate)
            
        } else {
            let closedCaseData = GlobalData.allClosingRedFlagModel[indexPath.row]
            cell.caseNoLabl?.text = closedCaseData.name
            cell.patientNameLabl?.text = closedCaseData.patient?.name
            cell.clinicNameLabl?.text = closedCaseData.clinic?.name
            cell.healthCardLabl?.text = closedCaseData.patientHealthCard?.name
            cell.financialBalanceLabl?.text = closedCaseData.financialBalance == "NA" ? "" : "$\(closedCaseData.financialBalance)"
            cell.subsidyTypeLabl?.text = closedCaseData.typeOfSubsidyPlan == "NA" ? "" : closedCaseData.typeOfSubsidyPlan
            cell.frequencyLabl?.text = closedCaseData.frequency == "NA" ? "" : closedCaseData.frequency
            cell.statusLabl?.text = closedCaseData.status
            cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: closedCaseData.createdDate)
            cell.createdAtTimeLabl?.text = customDateFormatter.getDateForCreatedAtTime(dateString: closedCaseData.createdDate)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPending {
            let pendingData = GlobalData.allPendingRedFlagModel[indexPath.row]
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
            let redFlagPendingVC = storyboard.instantiateViewController(withIdentifier: "RedFlagPendingVC") as! RedFlagPendingVC
            redFlagPendingVC.pendingData = pendingData
            self.navigationController?.pushViewController(redFlagPendingVC, animated: true)
        } else {
            let closedData = GlobalData.allClosingRedFlagModel[indexPath.row]
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
            let redFlagClosedDetailsVC = storyboard.instantiateViewController(withIdentifier: "RedFlagClosedDetailsVC") as! RedFlagClosedDetailsVC
            redFlagClosedDetailsVC.closingData = closedData
            self.navigationController?.pushViewController(redFlagClosedDetailsVC, animated: true)
        }
        
    }
}

extension RedFlagListVc: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            resetSearchResults()
        } else {
            filterResults(searchText)
        }
        tableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss keyboard
    }
    
    private func resetSearchResults() {
        if isPending {
            GlobalData.allPendingRedFlagModel = originalPendingData
        } else {
            GlobalData.allClosingRedFlagModel = originalClosedData
        }
    }
    
    private func filterResults(_ searchText: String) {
        let lowercasedText = searchText.lowercased()
        
        if isPending {
            GlobalData.allPendingRedFlagModel = originalPendingData.filter { model in
                model.name.lowercased().contains(lowercasedText) ||
                model.patient?.name.lowercased().contains(lowercasedText) ?? false ||
                model.patientHealthCard?.name.lowercased().contains(lowercasedText) ?? false
            }
        } else {
            GlobalData.allClosingRedFlagModel = originalClosedData.filter { model in
                model.name.lowercased().contains(lowercasedText) ||
                model.patient?.name.lowercased().contains(lowercasedText) ?? false ||
                model.patientHealthCard?.name.lowercased().contains(lowercasedText) ?? false
            }
        }
    }
}

class RedFlagListCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var caseNoLabl: UILabel?
    @IBOutlet var patientNameLabl: UILabel?
    @IBOutlet var clinicNameLabl: UILabel?
    @IBOutlet var healthCardLabl: UILabel?
    @IBOutlet var financialBalanceLabl: UILabel?
    @IBOutlet var subsidyTypeLabl: UILabel?
    @IBOutlet var frequencyLabl: UILabel?
    @IBOutlet var statusLabl: UILabel?
    @IBOutlet var createdAtLabl: UILabel?
    @IBOutlet var createdAtTimeLabl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}
