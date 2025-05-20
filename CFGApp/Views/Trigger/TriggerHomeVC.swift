//
//  TriggerHomeVC.swift
//  CFGApp
//
//  Created by Sakshi on 25/03/25.
//

import UIKit

class TriggerHomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension TriggerHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TriggerHomeItems.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionTriggerHomeCell", for: indexPath) as! CustomCollectionTriggerHomeCell
        cell.titleLabel?.text = TriggerHomeItems.allCases[indexPath.item].rawValue
        cell.headingLbl?.text = TriggerHomeItems.allCases[indexPath.item].getTriggerHomeItemst()
        cell.shadowDecorate()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Trigger", bundle: storyboardBundle)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "TriggerEventsListVc") as! TriggerEventsListVc
            self.navigationController?.pushViewController(dashboardVC, animated: true)
        }
//        
        if indexPath.row == 1 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "TriggerCropTalk", bundle: storyboardBundle)
            let ticketListVC = storyboard.instantiateViewController(withIdentifier: "TriggerCropTalkListVC") as! TriggerCropTalkListVC
            self.navigationController?.pushViewController(ticketListVC, animated: true)
        }
//        
//        if indexPath.row == 2 {
//            let storyboardBundle = Bundle.main
//            let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
//            let redFlagListVc = storyboard.instantiateViewController(withIdentifier: "RedFlagListVc") as! RedFlagListVc
//            self.navigationController?.pushViewController(redFlagListVc, animated: true)
//        }
        
//        if indexPath.row == 3 {
//            let storyboardBundle = Bundle.main
//            let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
//            let redFlagListVc = storyboard.instantiateViewController(withIdentifier: "RedFlagListVc") as! RedFlagListVc
//            self.navigationController?.pushViewController(redFlagListVc, animated: true)
//        }
    }
    
}

class CustomCollectionTriggerHomeCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var headingLbl: UILabel?
    @IBOutlet weak var commingSoonLbl: UILabel?
    @IBOutlet weak var vw: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



