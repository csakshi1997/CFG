//
//  NotificationVC.swift
//  CFGApp
//
//  Created by Sakshi on 01/04/25.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet var tableView: UITableView?
    @IBOutlet var noDataView: UIView?
    var notificationOperation = NotificationOperation()
    var notifications = [NotificationModel]()
    var customDateFormatter = CustomDateFormatter()
    var originalPendingData: [PendingMaintenanceModel] = []
    var originalClosedData: [ClosedMaintenanceModel] = []
    var originalPendingRedFlagData: [PendingRedFlagModel] = []
    var originalClosedRedFlgData: [ClosingRedFlagModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotification()
        DispatchQueue.main.async {
            Utility.getPendingMaintenanceData(outerClosure: { success in
                if success {
                    self.originalPendingData = GlobalData.allpendingMaintenanceModel
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
        
        DispatchQueue.main.async {
            Utility.getPendingRedFlagData(outerClosure: { success in
                if success {
                    self.originalPendingRedFlagData = GlobalData.allPendingRedFlagModel
                }
            })
        }
        
        DispatchQueue.main.async {
            Utility.getClosedRedFlagData(outerClosure: { success in
                if success {
                    self.originalClosedRedFlgData = GlobalData.allClosingRedFlagModel
                }
            })
        }

    }
    
    func getNotification() {
        notificationOperation.getAllNotification { error, ResponseStatus, statusCode in
            // Check if the ResponseStatus contains "Mobile_Notification" data
            if let data = ResponseStatus {
                // Get the array of notifications from the "Mobile_Notification" key
                if let notificationsArray = data["Mobile_Notification"] as? [[String: Any]], notificationsArray.count > 0 {
                    // Map the notifications to NotificationModel objects
                    self.notifications = notificationsArray.map { dict in
                        return NotificationModel(
                            body: dict["Body__c"] as? String ?? "",
                            title: dict["Title__c"] as? String ?? "",
                            createdDate: dict["CreatedDate"] as? String ?? "",
                            id: dict["Id"] as? String ?? "",
                            isRead: dict["IsRead__c"] as? Bool ?? false
                        )
                    }
                    
                    // Hide the "No Data" view and show the table view
                    self.noDataView?.isHidden = true
                    self.tableView?.isHidden = false
                } else {
                    // No notifications available, show "No Data" view
                    self.noDataView?.isHidden = false
                    self.tableView?.isHidden = true
                }
            } else {
                // Handle error if ResponseStatus is not in expected format
                print("Error: ResponseStatus is not a dictionary")
                // Show the "No Data" view in case of an error
                self.noDataView?.isHidden = false
                self.tableView?.isHidden = true
            }
            
            // Reload the table view with new data
            self.tableView?.reloadData()
        }
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of notifications
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notification = notifications[indexPath.row]
        cell.ticketStatusLabl?.text = notification.title
        cell.discriptionLabl?.text = notification.body
        cell.createdAtLabl?.text = customDateFormatter.getDateForCreatedAt(dateString: notification.createdDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110  // Adjust this as needed
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNotification = notifications[indexPath.row]
        
        // Create the parameters for the API call
        let parameters: [String: Any] = [
            "noti_id": selectedNotification.id,
            "is_read": true
        ]
        
        notificationOperation.updateNotificationStatus(param: parameters) { error, responseData, status in
            if let error = error {
                print("Error updating notification status: \(error)")
                return
            }
            if let responseData = responseData {
                print("Notification status updated successfully: \(responseData)")
            }
        }
        
        let storyboardBundle = Bundle.main
        
        //        if selectedNotification.body.contains("M0") && selectedNotification.title.contains("Pending") {
        //            if let pendingData = GlobalData.allpendingMaintenanceModel.first(where: { selectedNotification.body.contains($0.name) }) {
        //                let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
        //                let maintenancePendingVC = storyboard.instantiateViewController(withIdentifier: "MaintenancePendingVC") as! MaintenancePendingVC
        //                maintenancePendingVC.pendingMaintenanceData = pendingData
        //                self.navigationController?.pushViewController(maintenancePendingVC, animated: true)
        //            } else {
        //                print("No matching pending maintenance found")
        //            }
        //
        //        } else if selectedNotification.body.contains("M0") && selectedNotification.title.contains("Close") {
        //            if let closedData = GlobalData.allClosedMaintenanceModel.first(where: { selectedNotification.body.contains($0.name) }) {
        //                let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
        //                let maintenanceClosedDetailsVC = storyboard.instantiateViewController(withIdentifier: "MaintenanceClosedDetailsVC") as! MaintenanceClosedDetailsVC
        //                maintenanceClosedDetailsVC.closedMaintenanceData = closedData
        //                self.navigationController?.pushViewController(maintenanceClosedDetailsVC, animated: true)
        //            } else {
        //                print("No matching closed maintenance found")
        //            }
        //
        //        }
        
        // Extract maintenance ID (assuming it follows the pattern "M0XXXX")
        if let maintenanceID = selectedNotification.body.components(separatedBy: " ").first(where: { $0.hasPrefix("M0") }) {

            // Check if it's in pending maintenance
            if let pendingData = GlobalData.allpendingMaintenanceModel.first(where: { $0.name.caseInsensitiveCompare(maintenanceID) == .orderedSame }) {
                let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
                let maintenancePendingVC = storyboard.instantiateViewController(withIdentifier: "MaintenancePendingVC") as! MaintenancePendingVC
                maintenancePendingVC.pendingMaintenanceData = pendingData
                self.navigationController?.pushViewController(maintenancePendingVC, animated: true)
                return
            }
            
            // Check if it's in closed maintenance
            if let closedData = GlobalData.allClosedMaintenanceModel.first(where: { $0.name.caseInsensitiveCompare(maintenanceID) == .orderedSame }) {
                let storyboard = UIStoryboard(name: "Maintenance", bundle: storyboardBundle)
                let maintenanceClosedDetailsVC = storyboard.instantiateViewController(withIdentifier: "MaintenanceClosedDetailsVC") as! MaintenanceClosedDetailsVC
                maintenanceClosedDetailsVC.closedMaintenanceData = closedData
                self.navigationController?.pushViewController(maintenanceClosedDetailsVC, animated: true)
                return
            } else {
                print("No matching maintenance record found")

            }
        }

        // If no match is found
        else if selectedNotification.body.contains("RD-") && selectedNotification.title.contains("Pending") {
            self.view.makeToast("Refund is in progress")

        } else if selectedNotification.body.contains("RD-") && selectedNotification.title.contains("Close") {
            self.view.makeToast("Refund is in progress")

        } else if let redFlagID = selectedNotification.body.components(separatedBy: " ").first(where: { $0.hasPrefix("RF-") }) {
            
            // Check if it's in pending red flag model
            if let pendingData = GlobalData.allPendingRedFlagModel.first(where: { $0.name.caseInsensitiveCompare(redFlagID) == .orderedSame }) {
                let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
                let redFlagPendingVC = storyboard.instantiateViewController(withIdentifier: "RedFlagPendingVC") as! RedFlagPendingVC
                redFlagPendingVC.pendingData = pendingData
                self.navigationController?.pushViewController(redFlagPendingVC, animated: true)
                return
            }
            
            // Check if it's in closed red flag model
            if let closedData = GlobalData.allClosingRedFlagModel.first(where: { $0.name.caseInsensitiveCompare(redFlagID) == .orderedSame }) {
                let storyboard = UIStoryboard(name: "RedFlag", bundle: storyboardBundle)
                let redFlagClosedDetailsVC = storyboard.instantiateViewController(withIdentifier: "RedFlagClosedDetailsVC") as! RedFlagClosedDetailsVC
                redFlagClosedDetailsVC.closingData = closedData
                self.navigationController?.pushViewController(redFlagClosedDetailsVC, animated: true)
                return
            }
        }

        // If no match is found
    }
}


class NotificationCell: UITableViewCell {
    @IBOutlet var vw: UIView?
    @IBOutlet var ticketStatusLabl: UILabel?
    @IBOutlet var discriptionLabl: UILabel?
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


struct NotificationModel {
    var body: String
    var title: String
    var createdDate: String
    var id: String
    var isRead: Bool
}
