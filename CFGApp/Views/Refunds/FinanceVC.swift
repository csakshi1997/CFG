//
//  FinanceVC.swift
//  CFGApp
//
//  Created by Sakshi on 26/02/25.
//

import UIKit

class FinanceVC: UIViewController, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var pendingBtn: UIButton?
    @IBOutlet var searchVw: UISearchBar?
    @IBOutlet var ClosedBtn: UIButton?
    @IBOutlet var floatingButton: UIButton?
    @IBOutlet var noDataFoundVw: UIView?
    var refundWebService = RefundWebService()
    var isPending: Bool = true
    var customDateFormatter = CustomDateFormatter()
    var isSearching = false
    var originalPendingData: [PendingMaintenanceModel] = []
    var originalClosedData: [ClosedMaintenanceModel] = []
    
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
            Utility.getPendingMaintenanceData(outerClosure: { success in
                if success {
                    self.originalPendingData = GlobalData.allpendingMaintenanceModel
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
            Utility.getClosedMaintenanceData(outerClosure: { success in
                if success {
                    self.originalClosedData = GlobalData.allClosedMaintenanceModel
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
            Utility.getPendingMaintenanceData(outerClosure: { success in
                if success {
                    self.originalPendingData = GlobalData.allpendingMaintenanceModel
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
            Utility.getClosedMaintenanceData(outerClosure: { success in
                if success {
                    self.originalClosedData = GlobalData.allClosedMaintenanceModel
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
        let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
        let createNewCaseVC = storyboard.instantiateViewController(withIdentifier: "CreateNewCaseVC") as! CreateNewCaseVC
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

extension FinanceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPending ? GlobalData.allpendingMaintenanceModel.count : GlobalData.allClosedMaintenanceModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TicketListCell = tableView.dequeueReusableCell(withIdentifier: "TicketListCell", for: indexPath) as! TicketListCell
        if isPending {
            let pendingCaseData = GlobalData.allpendingMaintenanceModel[indexPath.row]
            cell.nameLabl?.text = pendingCaseData.name
            cell.clinicNameLabl?.text = pendingCaseData.clinic?.name
            cell.issueTypeLabl?.text = pendingCaseData.ticketType
            cell.statusLabl?.text = pendingCaseData.status
            cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingCaseData.createdDate)
        } else {
            let closedCaseData = GlobalData.allClosedMaintenanceModel[indexPath.row]
            cell.nameLabl?.text = closedCaseData.name
            cell.clinicNameLabl?.text = closedCaseData.clinic?.name
            cell.issueTypeLabl?.text = closedCaseData.ticketType
            cell.statusLabl?.text = closedCaseData.status
            cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: closedCaseData.createdDate ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPending {
            let pendingData = GlobalData.allpendingMaintenanceModel[indexPath.row]
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
            let maintenancePendingVC = storyboard.instantiateViewController(withIdentifier: "MaintenancePendingVC") as! MaintenancePendingVC
            maintenancePendingVC.pendingMaintenanceData = pendingData
            maintenancePendingVC.completionHandler = { textState in
                self.tableView?.reloadData()
            }
            self.navigationController?.pushViewController(maintenancePendingVC, animated: true)
        } else {
            let closedData = GlobalData.allClosedMaintenanceModel[indexPath.row]
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
            let maintenanceClosedDetailsVC = storyboard.instantiateViewController(withIdentifier: "MaintenanceClosedDetailsVC") as! MaintenanceClosedDetailsVC
            maintenanceClosedDetailsVC.closedMaintenanceData = closedData
            self.navigationController?.pushViewController(maintenanceClosedDetailsVC, animated: true)
        }
        
    }
}

class FinanceCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var nameLabl: UILabel?
    @IBOutlet var clinicNameLabl: UILabel?
    @IBOutlet var issueTypeLabl: UILabel?
    @IBOutlet var statusLabl: UILabel?
    @IBOutlet var createdAtLabl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}

extension FinanceVC: UISearchBarDelegate {
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
            GlobalData.allpendingMaintenanceModel = originalPendingData
        } else {
            GlobalData.allClosedMaintenanceModel = originalClosedData
        }
    }
    
    private func filterResults(_ searchText: String) {
        let lowercasedText = searchText.lowercased()
        
        if isPending {
            GlobalData.allpendingMaintenanceModel = originalPendingData.filter { model in
                model.name.lowercased().contains(lowercasedText) ||
                model.clinic?.name.lowercased().contains(lowercasedText) ?? false ||
                model.issue.lowercased().contains(lowercasedText)
            }
        } else {
            GlobalData.allClosedMaintenanceModel = originalClosedData.filter { model in
                model.name.lowercased().contains(lowercasedText) ||
                model.clinic?.name.lowercased().contains(lowercasedText) ?? false ||
                model.issue.lowercased().contains(lowercasedText)
            }
        }
    }
}
