//
//  ViewCropTalkVc.swift
//  CFGApp
//
//  Created by Sakshi on 27/03/25.
//

import UIKit

class ViewCropTalkVc: UIViewController {
    @IBOutlet var detailView: UIView?
    @IBOutlet var patientNameLbl: UILabel?
    @IBOutlet var clinicNameLbl: UILabel?
    @IBOutlet var doctorNameLbl: UILabel?
    @IBOutlet var employerNameLbl: UILabel?
    @IBOutlet var createdAtLbl: UILabel?
    @IBOutlet var addPersonBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUPInitialView()
    }
    
    func setUPInitialView() {
        detailView?.dropShadowTableView()
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addPeopleAction() {
        
    }

}

extension ViewCropTalkVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ViewCropTalkCell = tableView.dequeueReusableCell(withIdentifier: "ViewCropTalkCell", for: indexPath) as! ViewCropTalkCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


class ViewCropTalkCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var contactNameLabl: UILabel?
    @IBOutlet var contactNumberLabl: UILabel?
    @IBOutlet var removeBtnLabl: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vw?.layer.cornerRadius = 12
        vw?.layer.borderWidth = 0.5
        vw?.layer.borderColor = UIColor(hex: "#E3E3E3")?.cgColor
        vw?.layer.masksToBounds = false
        vw?.dropShadowTableView()
    }
}
