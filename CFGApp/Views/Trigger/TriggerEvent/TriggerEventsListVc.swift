//
//  TriggerEventsListVc.swift
//  CFGApp
//
//  Created by Sakshi on 25/03/25.
//

import UIKit

class TriggerEventsListVc: UIViewController {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var pendingBtn: UIButton?
    @IBOutlet var searchVw: UISearchBar?
    @IBOutlet var ClosedBtn: UIButton?
    @IBOutlet var floatingButton: UIButton?
    @IBOutlet var noDataFoundVw: UIView?
    var isLive: Bool = true
    var customDateFormatter = CustomDateFormatter()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingButton?.layer.cornerRadius = 25
        searchVw?.delegate = self
        isLive = true
        pendingBtn?.backgroundColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
        pendingBtn?.setTitleColor(.white, for: .normal)
        ClosedBtn?.backgroundColor = .white
        ClosedBtn?.setTitleColor(.black, for: .normal)
        ClosedBtn?.shadowDecorateButton()
        pendingBtn?.shadowDecorateButton()
        addTapGestureToDismissKeyboard()
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
        let storyboard = UIStoryboard(name: "Trigger", bundle: storyboardBundle)
        let createNewCaseVC = storyboard.instantiateViewController(withIdentifier: "CreateTriggerEventVC") as! CreateTriggerEventVC
        self.navigationController?.pushViewController(createNewCaseVC, animated: true)
    }
    
    @IBAction func caseAction(sender: UIButton) {
        if sender.tag == 1 {
            pendingBtn?.backgroundColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
            pendingBtn?.setTitleColor(.white, for: .normal)
            ClosedBtn?.backgroundColor = .white
            ClosedBtn?.setTitleColor(.black, for: .normal)
            isLive = true
        } else if sender.tag == 2 {
            ClosedBtn?.backgroundColor = UIColor(red: 229.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
            ClosedBtn?.setTitleColor(.white, for: .normal)
            pendingBtn?.backgroundColor = .white
            pendingBtn?.setTitleColor(.black, for: .normal)
            ClosedBtn?.setTitleColor(.white, for: .normal)
            isLive = false
        }
    }

}

extension TriggerEventsListVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return isPending ? GlobalData.allPendingRedFlagModel.count : GlobalData.allClosingRedFlagModel.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TriggerEventsListCell = tableView.dequeueReusableCell(withIdentifier: "TriggerEventsListCell", for: indexPath) as! TriggerEventsListCell
        if isLive {
//            let pendingCaseData = GlobalData.allPendingRedFlagModel[indexPath.row]
            cell.triggerIdLabl?.text = "pendingCaseData.name"
            cell.eventNameLabl?.text = "pendingCaseData.name"
            cell.startDateLabl?.text = "pendingCaseData.name"
            cell.endDateLabl?.text = "pendingCaseData.name"
            cell.createdAtLabl?.text = "2015-03-26 12:00 PM" /*customDateFormatter.getDateForCreatedAt(dateString: pendingCaseData.createdDate)*/
            
        } else {
//            let closedCaseData = GlobalData.allClosingRedFlagModel[indexPath.row]
            cell.triggerIdLabl?.text = "pendingCaseData.name"
            cell.eventNameLabl?.text = "pendingCaseData.name"
            cell.startDateLabl?.text = "pendingCaseData.name"
            cell.endDateLabl?.text = "pendingCaseData.name"
            cell.createdAtLabl?.text = "2015-03-26 12:00 PM" /*customDateFormatter.getDateForCreatedAt(dateString: closedCaseData.createdDate)*/
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isLive {
//            let pendingData = GlobalData.allPendingRedFlagModel[indexPath.row]
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Trigger", bundle: storyboardBundle)
            let redFlagPendingVC = storyboard.instantiateViewController(withIdentifier: "EditTriggerEventVC") as! EditTriggerEventVC
//            redFlagPendingVC.pendingData = pendingData
            self.navigationController?.pushViewController(redFlagPendingVC, animated: true)
        } else {
//            let closedData = GlobalData.allClosingRedFlagModel[indexPath.row]
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Trigger", bundle: storyboardBundle)
            let redFlagClosedDetailsVC = storyboard.instantiateViewController(withIdentifier: "EditTriggerEventVC") as! EditTriggerEventVC
//            redFlagClosedDetailsVC.closingData = closedData
            self.navigationController?.pushViewController(redFlagClosedDetailsVC, animated: true)
        }
    }
}

extension TriggerEventsListVc: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            resetSearchResults()
//        } else {
//            filterResults(searchText)
//        }
        tableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss keyboard
    }
    
    private func resetSearchResults() {
//        if isPending {
//            GlobalData.allPendingRedFlagModel = originalPendingData
//        } else {
//            GlobalData.allClosingRedFlagModel = originalClosedData
//        }
    }
    
    private func filterResults(_ searchText: String) {
        let lowercasedText = searchText.lowercased()
        
//        if isPending {
//            GlobalData.allPendingRedFlagModel = originalPendingData.filter { model in
//                model.name.lowercased().contains(lowercasedText) ||
//                model.patient?.name.lowercased().contains(lowercasedText) ?? false ||
//                model.patientHealthCard?.name.lowercased().contains(lowercasedText) ?? false
//            }
//        } else {
//            GlobalData.allClosingRedFlagModel = originalClosedData.filter { model in
//                model.name.lowercased().contains(lowercasedText) ||
//                model.patient?.name.lowercased().contains(lowercasedText) ?? false ||
//                model.patientHealthCard?.name.lowercased().contains(lowercasedText) ?? false
//            }
//        }
    }
}

class TriggerEventsListCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var triggerIdLabl: UILabel?
    @IBOutlet var eventNameLabl: UILabel?
    @IBOutlet var startDateLabl: UILabel?
    @IBOutlet var endDateLabl: UILabel?
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

