//
//  TriggerCropTalkListVC.swift
//  CFGApp
//
//  Created by Sakshi on 25/03/25.
//

import UIKit

class TriggerCropTalkListVC: UIViewController {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var searchVw: UISearchBar?
    @IBOutlet var floatingButton: UIButton?
    @IBOutlet var noDataFoundVw: UIView?
    var isPending: Bool = true
    var customDateFormatter = CustomDateFormatter()
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingButton?.layer.cornerRadius = 25
        searchVw?.delegate = self

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
        let storyboard = UIStoryboard(name: "TriggerCropTalk", bundle: storyboardBundle)
        let createNewCaseVC = storyboard.instantiateViewController(withIdentifier: "CreateTriggerCropTalk") as! CreateTriggerCropTalk
        self.navigationController?.pushViewController(createNewCaseVC, animated: true)
    }

}

extension TriggerCropTalkListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TriggerCropTalkListCell = tableView.dequeueReusableCell(withIdentifier: "TriggerCropTalkListCell", for: indexPath) as! TriggerCropTalkListCell
        cell.patientNameLabl?.text = "pendingCaseData.name"
        cell.clinicNameLabl?.text = "pendingCaseData.name"
        cell.doctorNameLabl?.text = "pendingCaseData.name"
        cell.employerNameLabl?.text = "pendingCaseData.name"
        cell.createdAtLabl?.text = "" /*customDateFormatter.getDateForCreatedAt(dateString: pendingCaseData.createdDate)*/
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "TriggerCropTalk", bundle: storyboardBundle)
        let viewCropTalkVc = storyboard.instantiateViewController(withIdentifier: "ViewCropTalkVc") as! ViewCropTalkVc
//            redFlagPendingVC.pendingData = pendingData
        self.navigationController?.pushViewController(viewCropTalkVc, animated: true)
    }
}

extension TriggerCropTalkListVC: UISearchBarDelegate {
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

class TriggerCropTalkListCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var patientNameLabl: UILabel?
    @IBOutlet var clinicNameLabl: UILabel?
    @IBOutlet var doctorNameLabl: UILabel?
    @IBOutlet var employerNameLabl: UILabel?
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

