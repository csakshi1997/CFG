//
//  RefundVC.swift
//  CFGApp
//
//  Created by Sakshi on 06/01/25.
//

import UIKit

class RefundVC: UIViewController {
    @IBOutlet var tableView: UITableView?
    var refundsText = ["New Case", "List of Pending Cases", "List of Closed Cases", "Senior Consultant", "Finance"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RefundVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        refundsText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RefundsCell = tableView.dequeueReusableCell(withIdentifier: "RefundsCell", for: indexPath) as! RefundsCell
        cell.labl?.text = refundsText[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Refunds", bundle: storyboardBundle)
            let PatientDetailsVC = storyboard.instantiateViewController(withIdentifier: "PatientDetailsVC") as! PatientDetailsVC
            self.navigationController?.pushViewController(PatientDetailsVC, animated: true)
        } else if indexPath.row == 1 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "PendingCases", bundle: storyboardBundle)
            let PatientDetailsVC = storyboard.instantiateViewController(withIdentifier: "PendingCasesVC") as! PendingCasesVC
            self.navigationController?.pushViewController(PatientDetailsVC, animated: true)
        } else if indexPath.row == 2 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Closed", bundle: storyboardBundle)
            let closedCasesListVC = storyboard.instantiateViewController(withIdentifier: "ClosedCasesListVC") as! ClosedCasesListVC
            self.navigationController?.pushViewController(closedCasesListVC, animated: true)
        } else if indexPath.row == 3 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Refunds", bundle: storyboardBundle)
            let seniorConsultantRefundVC = storyboard.instantiateViewController(withIdentifier: "SeniorConsultantRefundVC") as! SeniorConsultantRefundVC
            self.navigationController?.pushViewController(seniorConsultantRefundVC, animated: true)
        } else if indexPath.row == 4 {
//            let storyboardBundle = Bundle.main
//            let storyboard = UIStoryboard(name: "Refunds", bundle: storyboardBundle)
//            let seniorConsultantRefundVC = storyboard.instantiateViewController(withIdentifier: "SeniorConsultantRefundVC") as! SeniorConsultantRefundVC
//            self.navigationController?.pushViewController(seniorConsultantRefundVC, animated: true)
        }
    }
}

class RefundsCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var labl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}
