//
//  PendingCasesVC.swift
//  CFGApp
//
//  Created by Sakshi on 15/01/25.
//

import UIKit

class PendingCasesVC: UIViewController {
    @IBOutlet var tableView: UITableView?
    var refundWebService = RefundWebService()
    var customDateFormatter = CustomDateFormatter()
    var originalPendingData: [PendingRefundModel] = []
    @IBOutlet var noDataFoundVw: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            Utility.getPendingRefundData(outerClosure: { success in
                if success {
                    self.originalPendingData = GlobalData.allPendingRefundModel
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
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PendingCasesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return originalPendingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PendingCasesCell = tableView.dequeueReusableCell(withIdentifier: "PendingCasesCell", for: indexPath) as! PendingCasesCell
        let pendingCaseData = GlobalData.allPendingRefundModel[indexPath.row]
        cell.caseLabl?.text = pendingCaseData.name
        cell.patientNameLabl?.text = pendingCaseData.patient?.name
        cell.healthCardLbl?.text = pendingCaseData.patientHealthCard?.cardNumber
        cell.statusLabl?.text = pendingCaseData.status
        cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: pendingCaseData.createdDate ?? "")
        cell.createdAtTimeLabl?.text = customDateFormatter.getDateForCreatedAtTime(dateString: pendingCaseData.createdDate ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pendingData = GlobalData.allPendingRefundModel[indexPath.row]
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "PendingCases", bundle: storyboardBundle)
        let pendingCaseDetailVC = storyboard.instantiateViewController(withIdentifier: "PendingCaseDetailVC") as! PendingCaseDetailVC
        pendingCaseDetailVC.pendingRefundModel = GlobalData.allPendingRefundModel[indexPath.row]
        self.navigationController?.pushViewController(pendingCaseDetailVC, animated: true)
    }
}

class PendingCasesCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var caseLabl: UILabel?
    @IBOutlet var patientNameLabl: UILabel?
    @IBOutlet var healthCardLbl: UILabel?
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
