//
//  HomeVC.swift
//  CFGApp
//
//  Created by Sakshi on 31/12/24.
//

import UIKit
import SideMenu

class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView?
    var dropdownManager = DropdownManager()
    var patientOperation = PatientOperation()
    @IBOutlet var notificationCountLbl: UILabel?
    var notificationOperation = NotificationOperation()
    var notifications = [NotificationModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotification()
    }
    
    func getNotification() {
        notificationOperation.getAllNotification { error, ResponseStatus, statusCode in
            // Check if the ResponseStatus contains "Mobile_Notification" data
            if let data = ResponseStatus {
                // Get the array of notifications from the "Mobile_Notification" key
                if let notificationsArray = data["Mobile_Notification"] as? [[String: Any]], notificationsArray.count > 0 {
                    // Filter the notifications to get only unread notifications
                    let unreadNotifications = notificationsArray.filter { dict in
                        // Check if the notification is unread (IsRead__c is false)
                        return dict["IsRead__c"] as? Bool == false
                    }
                    
                    // Count the unread notifications
                    let unreadCount = unreadNotifications.count
                    
                    // Update the UI with the unread notification count
                    DispatchQueue.main.async {
                        self.updateNotificationIcon(unreadCount: unreadCount)
                    }

                    // Hide the "No Data" view and show the table view (if needed)
                    self.notificationCountLbl?.isHidden = unreadCount > 0
                } else {
                    // No notifications available, show "No Data" view
                    self.notificationCountLbl?.isHidden = false
                }
            } else {
                print("Error: ResponseStatus is not a dictionary")
                // Show the "No Data" view in case of an error
                self.notificationCountLbl?.isHidden = false
            }
        }
    }
    
    func updateNotificationIcon(unreadCount: Int) {
        // Assuming you have a UILabel or UIButton to display the notification count
        if unreadCount > 0 {
            // Display unread count
            notificationCountLbl?.isHidden = false
            notificationCountLbl?.text = "\(unreadCount)"
        } else {
            // Hide the badge if no unread notifications
            notificationCountLbl?.isHidden = true
        }
    }
    
    @IBAction func menuAction() {
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Home", bundle: storyboardBundle)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "SideBarViewController") as! SideBarViewController
        let menu = SideMenuNavigationController(rootViewController: dashboardVC)
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        let bounds = UIScreen.main.bounds
        menu.menuWidth = bounds.width/1.5
        dashboardVC.completionHandler = { textState in
            self.view.makeToast("Please check your internet connection")
        }
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func notificationAction() {
        let storyboardBundle = Bundle.main
        let storyboard = UIStoryboard(name: "Notification", bundle: storyboardBundle)
        let redFlagListVc = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(redFlagListVc, animated: true)
    }
    
    @IBAction func logoutAction() {
        let checkInalert = UIAlertController(
            title: "Confirmation",
            message: "Are you sure you want to Logout?",
            preferredStyle: .alert
        )
        self.present(checkInalert, animated: true, completion: nil)
        checkInalert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            print("Cancel tapped")
        }))
        
        checkInalert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            Utility.logoutAction(isRedirectedToLogin: true)
        }))
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeItems.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.titleLabel?.text = HomeItems.allCases[indexPath.item].rawValue
        cell.headingLbl?.text = HomeItems.allCases[indexPath.item].getHomeItemsText()
        switch indexPath.row {
        case 4, 5, 6, 8, 10, 11, 12:
            cell.commingSoonLbl?.text = "Coming soon..."
        default:
            cell.commingSoonLbl?.text = ""
        }
        cell.shadowDecorate()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Refunds", bundle: storyboardBundle)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "RefundVC") as! RefundVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
        }
        
        if indexPath.row == 3 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
            let ticketListVC = storyboard.instantiateViewController(withIdentifier: "TicketListVC") as! TicketListVC
            self.navigationController?.pushViewController(ticketListVC, animated: true)
        }
        
        if indexPath.row == 9 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
            let redFlagListVc = storyboard.instantiateViewController(withIdentifier: "RedFlagListVc") as! RedFlagListVc
            self.navigationController?.pushViewController(redFlagListVc, animated: true)
        }
        
        if indexPath.row == 7 {
            let storyboardBundle = Bundle.main
            let storyboard = UIStoryboard(name: "Trigger", bundle: storyboardBundle)
            let redFlagListVc = storyboard.instantiateViewController(withIdentifier: "TriggerHomeVC") as! TriggerHomeVC
            self.navigationController?.pushViewController(redFlagListVc, animated: true)
        }
    }
    
}

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var headingLbl: UILabel?
    @IBOutlet weak var commingSoonLbl: UILabel?
    @IBOutlet weak var vw: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
