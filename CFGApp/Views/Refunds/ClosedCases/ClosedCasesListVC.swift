//
//  ClosedCasesListVC.swift
//  CFGApp
//
//  Created by Sakshi on 21/01/25.
//

import UIKit

class ClosedCasesListVC: UIViewController {
    @IBOutlet var tableView: UITableView?
    var originalClosedData: [ClosingRefundModel] = []
    var refundWebService = RefundWebService()
    var customDateFormatter = CustomDateFormatter()
    @IBOutlet var noDataFoundVw: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            Utility.getClosedRefundData(outerClosure: { success in
                if success {
                    self.originalClosedData = GlobalData.allClosingRefundModel
                    if self.originalClosedData.count < 0 {
                        self.noDataFoundVw?.isHidden = false
                        self.tableView?.reloadData()
                    } else {
                        self.noDataFoundVw?.isHidden = true
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

extension ClosedCasesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return originalClosedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ClosedCasesListCell = tableView.dequeueReusableCell(withIdentifier: "ClosedCasesListCell", for: indexPath) as! ClosedCasesListCell
        let closedCaseData = originalClosedData[indexPath.row]
        cell.caseLabl?.text = closedCaseData.name
        cell.patientNameLabl?.text = closedCaseData.patient?.name
        cell.statusLabl?.text = closedCaseData.status
        cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: closedCaseData.createdDate ?? "")
        cell.createdAtTimeLabl?.text = customDateFormatter.getDateForCreatedAtTime(dateString: closedCaseData.createdDate ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Closed", bundle: storyboardBundle)
        let closingCaseDetailVC = storyboard.instantiateViewController(withIdentifier: "ClosedCaseDetailsVC") as! ClosedCaseDetailsVC
        closingCaseDetailVC.closingRefundModel = GlobalData.allClosingRefundModel[indexPath.row]
        self.navigationController?.pushViewController(closingCaseDetailVC, animated: true)
    }
}

class ClosedCasesListCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var caseLabl: UILabel?
    @IBOutlet var patientNameLabl: UILabel?
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
