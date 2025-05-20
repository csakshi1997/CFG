//
//  MaintenanceClosedDetailsVC.swift
//  CFGApp
//
//  Created by Sakshi on 31/01/25.
//

import UIKit
import AVFoundation
import WebKit

class MaintenanceClosedDetailsVC: UIViewController {
    @IBOutlet var ticketNo: UILabel?
    @IBOutlet var clinicName: UILabel?
    @IBOutlet var issueType: UILabel?
    @IBOutlet var status: UILabel?
    @IBOutlet var AMdate: UILabel?
    @IBOutlet var issueByAM: UILabel?
    @IBOutlet var AMRemark: UILabel?
    @IBOutlet var MOdate: UILabel?
    @IBOutlet var issueByMO: UILabel?
    @IBOutlet var MORemarks: UILabel?
    @IBOutlet var OVdate: UILabel?
    @IBOutlet var issueByOV: UILabel?
    @IBOutlet var OVRemark: UILabel?
    @IBOutlet var Finaldate: UILabel?
    @IBOutlet var issueByFinal: UILabel?
    @IBOutlet var finalMORemark: UILabel?
    @IBOutlet var imageVw: UIImageView?
    @IBOutlet var vw: UIView?
    @IBOutlet var AMViewHeight: NSLayoutConstraint?
    @IBOutlet var MOViewHeight: NSLayoutConstraint?
    @IBOutlet var OVViewHeight: NSLayoutConstraint?
    @IBOutlet var FDViewHeight: NSLayoutConstraint?
    @IBOutlet var AMView: UIView?
    @IBOutlet var MOView: UIView?
    @IBOutlet var OVView: UIView?
    @IBOutlet var FDView: UIView?
    @IBOutlet var collectionVw: UICollectionView?
    @IBOutlet var collectionVwHeight: NSLayoutConstraint?
    var closedMaintenanceData: ClosedMaintenanceModel?
    var selectedMaintenance: ClosedMaintenanceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
    }
    
    func setInitialUI() {
        Utility.getDataBasedOnMaintenanceId(id: closedMaintenanceData?.id ?? "") { success in
            if success {
                if let firstItem = GlobalData.allClosedMaintenanceModel.first {
                    self.selectedMaintenance = firstItem
                    DispatchQueue.main.async {
                        if (self.selectedMaintenance?.attachments?.isEmpty ?? true) {
                            self.collectionVwHeight?.constant = 0
                        } else {
                            self.collectionVwHeight?.constant = 60
                            self.collectionVw?.reloadData()
                        }
                      
                        
                    }
                }
            }
        }
        if "\(closedMaintenanceData?.isIssueFixedByAM ?? "No")" == "Yes" {
            MOViewHeight?.constant = 0
            OVViewHeight?.constant = 0
            FDViewHeight?.constant = 0
            
            MOViewHeight?.isActive = false
            MOViewHeight = MOView?.heightAnchor.constraint(equalToConstant: 0)
            MOViewHeight?.isActive = true
            
            OVViewHeight?.isActive = false
            OVViewHeight = OVView?.heightAnchor.constraint(equalToConstant: 0)
            OVViewHeight?.isActive = true
            
            FDViewHeight?.isActive = false
            FDViewHeight = FDView?.heightAnchor.constraint(equalToConstant: 0)
            FDViewHeight?.isActive = true
            
            MOView?.isHidden = true
            OVView?.isHidden = true
            FDView?.isHidden = true
//            vw?.shadowDecorateForView()
        } else if "\(closedMaintenanceData?.isIssueFixedByMO ?? "No")" == "Yes" {
            OVViewHeight?.constant = 0
            FDViewHeight?.constant = 0
            
            OVViewHeight?.isActive = false
            OVViewHeight = OVView?.heightAnchor.constraint(equalToConstant: 0)
            OVViewHeight?.isActive = true
            
            FDViewHeight?.isActive = false
            FDViewHeight = FDView?.heightAnchor.constraint(equalToConstant: 0)
            FDViewHeight?.isActive = true
            
            OVView?.isHidden = true
            FDView?.isHidden = true
//            vw?.shadowDecorateForView()
        } else if "\(closedMaintenanceData?.isIssueFixedByOV ?? "No")" == "Yes" {
            FDViewHeight?.constant = 0
            FDView?.isHidden = true
            
            FDViewHeight?.isActive = false
            FDViewHeight = FDView?.heightAnchor.constraint(equalToConstant: 0)
            FDViewHeight?.isActive = true
            
//            vw?.shadowDecorateForView()
        } else {
            MOViewHeight?.constant = 92
            OVViewHeight?.constant = 92
            FDViewHeight?.constant = 92
            MOView?.isHidden = false
            OVView?.isHidden = false
            FDView?.isHidden = false
//            vw?.shadowDecorateForView()
        }
        ticketNo?.text = closedMaintenanceData?.name
        clinicName?.text = closedMaintenanceData?.clinic?.name
        issueType?.text = closedMaintenanceData?.ticketType
        status?.text = closedMaintenanceData?.status
        AMdate?.text = closedMaintenanceData?.amRemarksDate
        issueByAM?.text = "\(closedMaintenanceData?.isIssueFixedByAM ?? "No")"
        AMRemark?.text = closedMaintenanceData?.amRemarks
        MOdate?.text = closedMaintenanceData?.amRemarksDate
        issueByMO?.text = "\(closedMaintenanceData?.isIssueFixedByMO ?? "No")"
        MORemarks?.text = closedMaintenanceData?.maintenanceOfficerRemarks
        OVdate?.text = closedMaintenanceData?.Outsource_Vendor_Remarks_Date__c
        issueByOV?.text = "\(closedMaintenanceData?.isIssueFixedByOV ?? "No")"
        OVRemark?.text = closedMaintenanceData?.Outsource_Vendor_Remarks__c
        Finaldate?.text = closedMaintenanceData?.amRemarksDate
        issueByFinal?.text = "\(closedMaintenanceData?.Is_this_Issue_Fixed_by_MO_Final__c ?? "No")"
        finalMORemark?.text = closedMaintenanceData?.Maintenance_Officer_Final_Remarks__c
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension MaintenanceClosedDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMaintenance?.attachments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MaintenanceClosedCell", for: indexPath) as! MaintenanceClosedCell
        
        if let attachments = selectedMaintenance?.attachments, indexPath.item < attachments.count {
            let attachment = attachments[indexPath.item]
            
            // Get MIME Type from Base64 String
            if let base64String = attachment.base64Body, let mimeType = getMimeType(from: base64String) {
                
                if mimeType.hasPrefix("image/") {
                    decodeBase64ToImage(base64String: base64String, imageView: cell.imageVw ?? UIImageView())
                } else if mimeType == "video/mp4" {
                    decodeBase64ToVideoThumbnail(base64String: base64String, imageView: cell.imageVw ?? UIImageView())
                } else if mimeType == "application/pdf" {
                    decodeBase64ToPDFThumbnail(base64String: base64String, imageView: cell.imageVw ?? UIImageView())
                } else {
                    print("❌ Unsupported file type: \(mimeType)")
                }
                
            } else {
                print("❌ Could not determine file type for Base64 string.")
            }
        }
        
        return cell
    }
    
    func getMimeType(from base64String: String) -> String? {
        // Check for MIME type in prefix
        if let range = base64String.range(of: ";base64,") {
            let prefix = base64String[..<range.lowerBound]
            if let mimeType = prefix.split(separator: ":").last {
                return String(mimeType) // Extracted MIME type (if available)
            }
        }

        // Decode Base64 to Data
        guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        // Identify file type based on magic numbers
        let byteArray = [UInt8](data.prefix(4))
        
        if byteArray.starts(with: [0xFF, 0xD8, 0xFF]) {
            return "image/jpeg"
        } else if byteArray.starts(with: [0x89, 0x50, 0x4E, 0x47]) {
            return "image/png"
        } else if byteArray.starts(with: [0x25, 0x50, 0x44, 0x46]) {
            return "application/pdf"
        } else if byteArray.starts(with: [0x00, 0x00, 0x00, 0x18]) || byteArray.starts(with: [0x66, 0x74, 0x79, 0x70]) {
            return "video/mp4"
        }
        
        return nil // Unknown MIME type
    }
    
    func decodeBase64ToImage(base64String: String, imageView: UIImageView) {
        if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("❌ Error: Could not convert data to UIImage")
            }
        } else {
            print("❌ Error: Invalid Base64 string for image")
        }
    }
    
    func decodeBase64ToVideoThumbnail(base64String: String, imageView: UIImageView) {
        if let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempVideo.mp4")
            do {
                try videoData.write(to: tempURL)
                
                // Generate Thumbnail
                let asset = AVAsset(url: tempURL)
                let generator = AVAssetImageGenerator(asset: asset)
                generator.appliesPreferredTrackTransform = true
                
                let time = CMTime(seconds: 1, preferredTimescale: 60) // Get the first frame
                let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                
                DispatchQueue.main.async {
                    imageView.image = thumbnail
                }
            } catch {
                print("❌ Error: Failed to write video data or generate thumbnail - \(error.localizedDescription)")
            }
        } else {
            print("❌ Error: Invalid Base64 string for video")
        }
    }
    
    func decodeBase64ToPDFThumbnail(base64String: String, imageView: UIImageView) {
        if let pdfData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempDocument.pdf")
            do {
                try pdfData.write(to: tempURL)
                
                // Generate PDF Thumbnail
                if let document = CGPDFDocument(tempURL as CFURL),
                   let page = document.page(at: 1) {
                    let pdfSize = page.getBoxRect(.mediaBox).size
                    let renderer = UIGraphicsImageRenderer(size: pdfSize)
                    
                    let image = renderer.image { ctx in
                        ctx.cgContext.drawPDFPage(page)
                    }
                    
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                } else {
                    print("❌ Error: Failed to generate PDF thumbnail")
                }
            } catch {
                print("❌ Error: Failed to write PDF data - \(error.localizedDescription)")
            }
        } else {
            print("❌ Error: Invalid Base64 string for PDF")
        }
    }
    
    func decodeBase64ToVideo(base64String: String, videoView: UIView) {
        if let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempVideo.mp4")
            do {
                try videoData.write(to: tempURL)
                DispatchQueue.main.async {
                    let player = AVPlayer(url: tempURL)
                    let playerLayer = AVPlayerLayer(player: player)
                    playerLayer.frame = videoView.bounds
                    videoView.layer.addSublayer(playerLayer)
                    player.play()
                }
            } catch {
                print("❌ Error: Failed to write video data to file - \(error.localizedDescription)")
            }
        } else {
            print("❌ Error: Invalid Base64 string for video")
        }
    }
    
    func decodeBase64ToPDF(base64String: String, webView: WKWebView) {
        if let pdfData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            DispatchQueue.main.async {
                webView.load(pdfData, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(fileURLWithPath: ""))
            }
        } else {
            print("❌ Error: Invalid Base64 string for PDF")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let attachments = selectedMaintenance?.attachments, indexPath.item < attachments.count else { return }
        let attachment = attachments[indexPath.item]
        
        guard let base64String = attachment.base64Body else {
            print("❌ Error: Missing base64 string")
            return
        }
        
        let fileName = attachment.name.lowercased()
        
        let storyboard = UIStoryboard(name: "Maintenance", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ImagePopUpVc") as? ImagePopUpVc {
            vc.base64String = base64String
            vc.fileType = fileName
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
            self.present(vc, animated: false)
        }
    }
}

class MaintenanceClosedCell: UICollectionViewCell {
    @IBOutlet var imageVw: UIImageView?
}
