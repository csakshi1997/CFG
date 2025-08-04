//
//  CreateNewCaseVC.swift
//  CFGApp
//
//  Created by Sakshi on 03/02/25.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
import UniformTypeIdentifiers
import AVFoundation

class CreateNewCaseVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet var ticketTypeTxtVw: UITextView?
    @IBOutlet var selectClinicTxtVw: UITextView?
    var ticketTypeTxtFldHeightConstraint: NSLayoutConstraint?
    var selectClinicTxtFldHeightConstraint: NSLayoutConstraint?
    @IBOutlet var remarkTextVw: UITextView?
    @IBOutlet var vw: UIView?
    @IBOutlet var submitBtn: UIButton?
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var TotalTxtCount: UILabel?
    @IBOutlet var remarkErrorLabel: UILabel?
    @IBOutlet var ticketErrorLabel: UILabel?
    @IBOutlet var clinicErrorLabel: UILabel?
    @IBOutlet var TxtCount: UILabel?
    let maxCharacterLimit = 131072
    var images: [UIImage] = []
    var selectedIndex: Int = 0
    var ticketTypeArr = ["General Lighting", "LED Lighting", "Minor Renovation", "Hardware Aesthetic", "Furnitures", "Electronics; vacuum, water dispenser etc", "IT Hardware", "IT System Support", "Service Needs; Carpet Cleaning, Anti Mould, Plants Replacement, Cleaner", "Ad Hoc Requirements"]
    var pickerView = UIPickerView()
    var clinicId = ""
    var clinicPickerData = [String]()
    var currentClinicPickerData: [(name: String, id: String)] = []
    var filteredClinicNames: [String] = []
    var currentPickerData: [String] = []
    var debounceTimer: Timer?
    var selectedImages: [UIImage] = []
    let maxImages = 5
    var selectedMediaItems: [MediaItem] = []
    var maintenanceOperation = MaintenanceOperation()
    var completionHandler: (String) -> Void = { _ in}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticketTypeTxtFldHeightConstraint = ticketTypeTxtVw?.heightAnchor.constraint(equalToConstant: 50)
        ticketTypeTxtFldHeightConstraint?.isActive = true
        selectClinicTxtFldHeightConstraint = selectClinicTxtVw?.heightAnchor.constraint(equalToConstant: 50)
        selectClinicTxtFldHeightConstraint?.isActive = true
        Utility.getAllClinic(outerClosure: { success in
        })
        remarkTextVw?.delegate = self
        setInitialUI()
        addTapGestureToDismissKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let textView = remarkTextVw?.viewWithTag(101) as? UITextView {
            textView.delegate = self
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentTextCount = textView.text.count
        if textView == remarkTextVw {
            TxtCount?.text = "\(currentTextCount)"
            clearValidationErrorForTextView()
        }
    }
    
    func clearValidationError(for textField: MDCOutlinedTextField?) {
        textField?.leadingAssistiveLabel.text = ""
        textField?.setOutlineColor(.gray, for: .normal)
        textField?.setOutlineColor(.blue, for: .editing)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let mdcTextField = textField as? MDCOutlinedTextField, let text = mdcTextField.text, !text.isEmpty {
            clearValidationError(for: mdcTextField)
            adjustTextFieldHeight(mdcTextField)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newLength = currentText.count + text.count - range.length
        return newLength <= maxCharacterLimit  // Prevent exceeding max limit
    }
    
    func showValidationErrorForTextView(_ textView: UITextView?, message: String) {
        if textView == remarkTextVw {
            remarkErrorLabel?.text = message
            remarkErrorLabel?.textColor = .red
            remarkErrorLabel?.isHidden = false
        } else if textView == ticketTypeTxtVw {
            ticketErrorLabel?.text = message
            ticketErrorLabel?.textColor = .red
            ticketErrorLabel?.isHidden = false
        } else if textView == selectClinicTxtVw {
            clinicErrorLabel?.text = message
            clinicErrorLabel?.textColor = .red
            clinicErrorLabel?.isHidden = false
        }
    }
    
    func clearValidationErrorForTextView() {
        remarkErrorLabel?.text = ""
        remarkErrorLabel?.isHidden = true
        
        ticketErrorLabel?.text = ""
        ticketErrorLabel?.isHidden = true
        
        clinicErrorLabel?.text = ""
        clinicErrorLabel?.isHidden = true
    }
    
    func setInitialUI() {
        collectionView?.isUserInteractionEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        remarkTextVw?.delegate = self
        remarkTextVw?.textColor = .darkGray
        remarkTextVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        remarkTextVw?.borderWidth = 1
        remarkTextVw?.borderColor = UIColor(red: 114.0 / 255.0, green: 47.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
        
        ticketTypeTxtVw?.textColor = .darkGray
        ticketTypeTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        ticketTypeTxtVw?.borderWidth = 1
        ticketTypeTxtVw?.borderColor = UIColor(red: 114.0 / 255.0, green: 47.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
        
        selectClinicTxtVw?.textColor = .darkGray
        selectClinicTxtVw?.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 10, right: 13)
        selectClinicTxtVw?.borderWidth = 1
        selectClinicTxtVw?.borderColor = UIColor(red: 114.0 / 255.0, green: 47.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
        submitBtn?.layer.cornerRadius = 8.0
        submitBtn?.layer.masksToBounds = true
        remarkTextVw?.layer.cornerRadius = 8.0
        remarkTextVw?.layer.masksToBounds = true
        
        ticketTypeTxtVw?.layer.cornerRadius = 8.0
        ticketTypeTxtVw?.layer.masksToBounds = true
        
        selectClinicTxtVw?.layer.cornerRadius = 8.0
        selectClinicTxtVw?.layer.masksToBounds = true
        vw?.layer.cornerRadius = 8
        vw?.layer.masksToBounds = true
        ticketTypeTxtVw?.inputView = pickerView
        selectClinicTxtVw?.inputView = pickerView
        
        ticketTypeTxtVw?.inputAccessoryView = createToolbar()
        selectClinicTxtVw?.inputAccessoryView = createToolbar()
        
        ticketTypeTxtVw?.delegate = self
        selectClinicTxtVw?.delegate = self
        setupPickerView()
    }
    
    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        return toolbar
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == ticketTypeTxtVw {
            currentClinicPickerData.removeAll()
            currentPickerData = ticketTypeArr
            pickerView.reloadAllComponents()
            
            DispatchQueue.main.async {
                textView.reloadInputViews()
            }
        }
        else if textView == selectClinicTxtVw {
            currentClinicPickerData.removeAll()
            
            if !GlobalData.allClinicModel.isEmpty {
                currentClinicPickerData = GlobalData.allClinicModel.compactMap { clinic in
                    if let name = clinic.Name, let id = clinic.Id {
                        return (name, id)
                    }
                    return nil
                }
                currentPickerData = currentClinicPickerData.map { $0.name }
                pickerView.reloadAllComponents()
                
                DispatchQueue.main.async {
                    textView.reloadInputViews()
                }
            }
        }
        return true
    }
    
    func adjustTextFieldHeight(_ textField: MDCOutlinedTextField) {
        let textSize = textField.sizeThatFits(CGSize(width: textField.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let newHeight = max(56, textSize.height + 10)
        ticketTypeTxtFldHeightConstraint?.constant = newHeight
        
        UIView.animate(withDuration: 0.3) {
            textField.superview?.layoutIfNeeded()
        }
    }
    
    let mediaItems: [MediaItem] = [
        MediaItem(type: .image, image: UIImage(named: "sampleImage"), videoURL: nil, pdfURL: nil, thumbnail: nil),
        MediaItem(type: .video, image: nil, videoURL: URL(string: "file:///path/video.mp4"), pdfURL: nil, thumbnail: UIImage(named: "videoThumbnail")),
        MediaItem(type: .pdf, image: nil, videoURL: nil, pdfURL: URL(string: "file:///path/document.pdf"), thumbnail: nil)
    ]
    
    func imageToBase64(image: UIImage) -> String? {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            return imageData.base64EncodedString()
        }
        return nil
    }
    
    func fileToBase64(filePath: String) -> String? {
        let fileURL = URL(fileURLWithPath: filePath)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            print("File does not exist at path: \(fileURL.path)")
            return nil
        }
        do {
            let fileData = try Data(contentsOf: fileURL)
            return fileData.base64EncodedString()
        } catch {
            print("Error reading file: \(error.localizedDescription)")
            return nil
        }
    }
    
    func showValidationError(for field: UIView?, message: String) {
        if let textView = field as? UITextView {
            textView.layer.borderColor = UIColor.red.cgColor
            textView.layer.borderWidth = 1.0
            textView.layer.cornerRadius = 5.0
        }
    }
    
    func clearValidationError(for field: UIView?) {
        if let textView = field as? UITextView {
            textView.layer.borderColor = UIColor.clear.cgColor
            textView.layer.borderWidth = 0
        }
    }
    
    @IBAction func submitAction() {
        var isValid = true
        if let ticketType = ticketTypeTxtVw?.text, ticketType.isEmpty {
            showValidationErrorForTextView(ticketTypeTxtVw, message: "Ticket type is required")
            isValid = false
        } else {
            clearValidationErrorForTextView()
        }
        
        if let clinic = selectClinicTxtVw?.text, clinic.isEmpty {
            showValidationErrorForTextView(selectClinicTxtVw, message: "Clinic is required")
            isValid = false
        } else {
            clearValidationErrorForTextView()
        }
        
        if let remarks = remarkTextVw?.text?.trimmingCharacters(in: .whitespacesAndNewlines), remarks.isEmpty {
            showValidationErrorForTextView(remarkTextVw, message: "Remarks are required")
            isValid = false
        } else {
            clearValidationErrorForTextView()
        }
        
        guard isValid else { return }
        let alert = UIAlertController(title: "Confirm Submission",
                                      message: "Do you really want to submit?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "YES", style: .default) { _ in
            self.submitFunc()
        }
        
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //    func submitFunc() {
    //        var payload: [String: Any] = [
    //            "ticket_type": ticketTypeTxtVw?.text ?? "",
    //            "clinic_name": clinicId,
    //            "remarks": remarkTextVw?.text ?? "",
    //            "m_status": "Pending by AM"
    //        ]
    //        let mediaItemCount = min(selectedMediaItems.count, 5)
    //        let compressionQuality: CGFloat = 0.3
    //
    //        DispatchQueue.global(qos: .userInitiated).async {
    //            var mediaData: [String: Any] = [:]
    //            let group = DispatchGroup()
    //
    //            for (index, mediaItem) in self.selectedMediaItems.prefix(mediaItemCount).enumerated() {
    //                let mediaIndex = index + 1
    //                group.enter()
    //
    //                var base64Key = (mediaIndex == 1) ? "imageBase64" : "imageBase64_\(mediaIndex)"
    //
    //                switch mediaItem.type {
    //                case .image:
    //                    mediaData["image_type_\(mediaIndex)"] = "jpeg"
    //                    if let image = mediaItem.image {
    //                        DispatchQueue.global(qos: .utility).async {
    //                            if let compressedData = self.compressImageToSize(image: image, targetSizeKB: 80) {
    //                                let base64String = compressedData.base64EncodedString()
    //                                DispatchQueue.main.async {
    //                                    mediaData[base64Key] = base64String
    //                                    group.leave()
    //                                }
    //                            } else {
    //                                group.leave()
    //                            }
    //                        }
    //                    } else {
    //                        group.leave()
    //                    }
    //
    //                case .video:
    //                    mediaData["image_type_\(mediaIndex)"] = "mp4"
    //                    if let videoURL = mediaItem.videoURL {
    //                        let compressedURL = FileManager.default.temporaryDirectory.appendingPathComponent("compressed\(mediaIndex).mp4")
    //                        self.compressVideoToSize(inputURL: videoURL, outputURL: compressedURL) { compressedVideoURL in
    //                            if let compressedVideoURL = compressedVideoURL,
    //                               let base64String = self.fileToBase64(filePath: compressedVideoURL.path) {
    //                                DispatchQueue.main.async {
    //                                    mediaData[base64Key] = base64String
    //                                    group.leave()
    //                                }
    //                            } else {
    //                                group.leave()
    //                            }
    //                        }
    //                    } else {
    //                        group.leave()
    //                    }
    //
    //                case .pdf:
    //                    mediaData["image_type_\(mediaIndex)"] = "pdf"
    //                    if let pdfURL = mediaItem.pdfURL {
    //                        DispatchQueue.global(qos: .utility).async {
    //                            if let base64String = self.base64ForPDF(at: pdfURL) {
    //                                DispatchQueue.main.async {
    //                                    mediaData[base64Key] = base64String
    //                                    group.leave()
    //                                }
    //                            } else {
    //                                group.leave()
    //                            }
    //                        }
    //                    } else {
    //                        group.leave()
    //                    }
    //                }
    //            }
    //
    //            group.notify(queue: .main) {
    //                if mediaItemCount < 5 {
    //                    for i in (mediaItemCount + 1)...5 {
    //                        if !mediaData.keys.contains("image_type_\(i)") {
    //                            mediaData["image_type_\(i)"] = ""
    //                        }
    //                        if !mediaData.keys.contains("imageBase64_\(i)") {
    //                            mediaData["imageBase64_\(i)"] = ""
    //                        }
    //                    }
    //                }
    //
    //                mediaData = mediaData.filter { !(($0.value as? String)?.isEmpty ?? true) }
    //
    //                for (key, value) in mediaData {
    //                    payload[key] = value
    //                }
    //
    //                print("Final Payload Before Sending: \(payload)")
    //
    //                self.maintenanceOperation.submitNewTicketFormaintenance(param: payload) { error, response, statusCode in
    //                    if error == nil {
    //                        SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
    //                        self.completionHandler(EMPTY)
    //                        self.navigationController?.popViewController(animated: true)
    //                    } else {
    //                        SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    
    func submitFunc() {
        var maintenanceBody: [String: Any] = [
            "Issue__c": remarkTextVw?.text ?? "",
            "Ticket_Type__c": ticketTypeTxtVw?.text ?? "",
            "Clinic__c": clinicId
        ]
        
        let mediaItemCount = min(selectedMediaItems.count, 5)
        
        DispatchQueue.global(qos: .userInitiated).async {
            var attachments: [[String: Any]] = []
            let group = DispatchGroup()
            
            for (index, mediaItem) in self.selectedMediaItems.prefix(mediaItemCount).enumerated() {
                group.enter()
                
                let mediaIndex = index + 1
                let fileNamePrefix = "Attachment\(mediaIndex)"
                let referenceId = "file\(mediaIndex)"
                let firstPublishLocationId = "@{Maint1.id}"
                
                func addAttachment(base64String: String, ext: String) {
                    let fileName = "\(fileNamePrefix).\(ext)"
                    let attachment: [String: Any] = [
                        "method": "POST",
                        "referenceId": referenceId,
                        "url": "/services/data/v63.0/sobjects/ContentVersion",
                        "body": [
                            "FirstPublishLocationId": firstPublishLocationId,
                            "Title": fileName,
                            "PathOnClient": fileName,
                            "VersionData": base64String
                        ]
                    ]
                    attachments.append(attachment)
                    group.leave()
                }
                
                switch mediaItem.type {
                case .image:
                    if let image = mediaItem.image {
                        DispatchQueue.global(qos: .utility).async {
                            if let compressedData = self.compressImageToSize(image: image, targetSizeKB: 80) {
                                let base64String = compressedData.base64EncodedString()
                                DispatchQueue.main.async {
                                    addAttachment(base64String: base64String, ext: "jpeg")
                                }
                            } else {
                                group.leave()
                            }
                        }
                    } else {
                        group.leave()
                    }
                    
                case .video:
                    if let videoURL = mediaItem.videoURL {
                        let compressedURL = FileManager.default.temporaryDirectory.appendingPathComponent("compressed\(mediaIndex).mp4")
                        self.compressVideoToSize(inputURL: videoURL, outputURL: compressedURL) { compressedVideoURL in
                            if let compressedVideoURL = compressedVideoURL,
                               let base64String = self.fileToBase64(filePath: compressedVideoURL.path) {
                                DispatchQueue.main.async {
                                    addAttachment(base64String: base64String, ext: "mp4")
                                }
                            } else {
                                group.leave()
                            }
                        }
                    } else {
                        group.leave()
                    }
                    
                case .pdf:
                    if let pdfURL = mediaItem.pdfURL {
                        DispatchQueue.global(qos: .utility).async {
                            if let base64String = self.base64ForPDF(at: pdfURL) {
                                DispatchQueue.main.async {
                                    addAttachment(base64String: base64String, ext: "pdf")
                                }
                            } else {
                                group.leave()
                            }
                        }
                    } else {
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) {
                // ✅ Validate total size of attachments here BEFORE submitting
                
                let totalSizeBytes = attachments.reduce(0) { total, attachment in
                    if let body = attachment["body"] as? [String: Any],
                       let base64String = body["VersionData"] as? String {
                        let estimatedDataSize = Int(Double(base64String.count) * 3.0 / 4.0)
                        return total + estimatedDataSize
                    }
                    return total
                }
                
                let maxTotalSizeBytes = 30 * 1024 * 1024 // 30MB
                
                if totalSizeBytes > maxTotalSizeBytes {
                    self.showAlert(
                        title: "Attachments too large",
                        message: "The total size of all attachments exceeds 30MB. Please remove some files or choose smaller ones."
                    )
                    return
                }
                
                // Build Maintenance__c object
                let maintenanceObject: [String: Any] = [
                    "method": "POST",
                    "url": "/services/data/v63.0/sobjects/Maintenance__c",
                    "referenceId": "Maint1",
                    "body": maintenanceBody
                ]
                
                // Final Composite Request payload
                let finalPayload: [String: Any] = [
                    "allOrNone": false,
                    "compositeRequest": [maintenanceObject] + attachments
                ]
                
                print("🚀 Final Composite Payload: \(finalPayload)")
                
                self.maintenanceOperation.submitNewTicketFormaintenance(param: finalPayload) { error, response, statusCode in
                    if error == nil {
                        SceneDelegate.getSceneDelegate().window?.makeToast(YOUR_TICKET_HAS_BEEN_SAVED)
                        self.completionHandler(EMPTY)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        SceneDelegate.getSceneDelegate().window?.makeToast(SOMETHING_WENT_WRONG_STR)
                    }
                }
            }
        }
    }
    
    func base64ForPDF(at url: URL) -> String? {
        do {
            let pdfData = try Data(contentsOf: url)
            return pdfData.base64EncodedString()
        } catch {
            return nil
        }
    }
    
    func compressImageToSize(image: UIImage, targetSizeKB: Int = 6000, minSizeKB: Int = 5000) -> Data? {
        var compressionQuality: CGFloat = 1.0
        let maxSize = targetSizeKB * 1024
        let minSize = minSizeKB * 1024
        
        var imageData = image.jpegData(compressionQuality: compressionQuality)
        
        while let data = imageData, data.count > maxSize && compressionQuality > 0.1 {
            compressionQuality -= 0.05
            imageData = image.jpegData(compressionQuality: compressionQuality)
        }
        
        if let data = imageData, data.count < minSize {
            compressionQuality += 0.05
            imageData = image.jpegData(compressionQuality: compressionQuality)
        }
        
        return imageData
    }
    
    func compressVideoToSize(inputURL: URL, outputURL: URL, completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: inputURL)
        
        // Check video duration (in seconds)
        let durationInSeconds = CMTimeGetSeconds(asset.duration)
        if durationInSeconds > 60 { // 1 minute limit
            DispatchQueue.main.async {
                self.showAlert(title: "Video too long", message: "Please select a video shorter than 60 seconds.")
            }
            completion(nil)
            return
        }
        
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality) else {
            completion(nil)
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
        
        exportSession.exportAsynchronously {
            guard exportSession.status == .completed else {
                completion(nil)
                return
            }
            
            if let attributes = try? FileManager.default.attributesOfItem(atPath: outputURL.path),
               let fileSize = attributes[.size] as? Int {
                if fileSize <= 5 * 1024 * 1024 { // 5MB limit
                    completion(outputURL)
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Video too large", message: "Compressed video is still larger than 5MB.")
                    }
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func compressPDFToSize(inputURL: URL, outputURL: URL, targetSizeKB: Int = 6144) -> Bool { // 6MB limit
        guard let pdfData = try? Data(contentsOf: inputURL) else { return false }
        
        let originalSize = pdfData.count
        let maxSize = targetSizeKB * 1024
        
        // Directly check size. If within limit, just copy
        if originalSize <= maxSize {
            try? FileManager.default.copyItem(at: inputURL, to: outputURL)
            return true
        }
        
        // Cannot actually "compress" a PDF easily without modifying content
        DispatchQueue.main.async {
            self.showAlert(title: "PDF too large", message: "Please select a smaller PDF file under 5MB.")
        }
        return false
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            if let topController = UIApplication.shared.keyWindow?.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getFileExtension(from url: URL?) -> String {
        guard let url = url else { return "" }
        return url.pathExtension.lowercased()
    }
    
    func getImagePath(for image: UIImage?) -> String? {
        guard let image = image else { return nil }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
                return fileURL.path
            } catch {
                print("Error saving image to temporary directory: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
    
    @IBAction func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
    
extension CreateNewCaseVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if ticketTypeTxtVw?.isFirstResponder == true {
            ticketTypeTxtVw?.text = currentPickerData[row]
            //            ticketTypeTxtVw?.isEditable = false  // Make non-editable
            clearValidationError(for: ticketTypeTxtVw)
            
            // Optional styling
            ticketTypeTxtVw?.layer.borderColor = UIColor.lightGray.cgColor
            ticketTypeTxtVw?.layer.borderWidth = 1.0
            ticketTypeTxtVw?.layer.cornerRadius = 6
            
        } else if selectClinicTxtVw?.isFirstResponder == true {
            let selectedClinic = currentClinicPickerData[row]
            selectClinicTxtVw?.text = selectedClinic.name
            //            selectClinicTxtVw?.isEditable = false  // Make non-editable
            clinicId = selectedClinic.id
            print("Selected Clinic ID: \(clinicId)")
            clearValidationError(for: selectClinicTxtVw)
            
            // Optional styling
            selectClinicTxtVw?.layer.borderColor = UIColor.lightGray.cgColor
            selectClinicTxtVw?.layer.borderWidth = 1.0
            selectClinicTxtVw?.layer.cornerRadius = 6
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = currentPickerData[row]
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
}

extension CreateNewCaseVC: UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIDocumentPickerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMediaItems.count < maxImages ? selectedMediaItems.count + 1 : selectedMediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageVw?.borderWidth = 1
        cell.borderColor = .gray
        
        if indexPath.item < selectedMediaItems.count {
            let mediaItem = selectedMediaItems[indexPath.item]
            
            switch mediaItem.type {
            case .image:
                cell.imageVw?.image = mediaItem.image
            case .video:
                if let thumbnail = mediaItem.thumbnail {
                    cell.imageVw?.image = thumbnail
                } else {
                    cell.imageVw?.image = UIImage(named: "video_icon")
                }
            case .pdf:
                cell.imageVw?.image = UIImage(named: "pdf_icon")
                cell.configureForMedia(mediaItem)
            }
        } else {
            cell.imageVw?.image = UIImage(systemName: "plus")
            cell.imageVw?.tintColor = .gray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item < selectedMediaItems.count ? indexPath.item : selectedMediaItems.count
        if let cell = collectionView.cellForItem(at: indexPath) {
            openMediaPicker(sourceView: cell)
        } else {
            openMediaPicker(sourceView: collectionView)
        }
    }
        
    func generateThumbnailFromVideo(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let asset = AVURLAsset(url: url)
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        assetGenerator.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 60)
        
        assetGenerator.generateCGImageAsynchronously(for: time) { cgImage, actualTime, error in
            var thumbnailImage: UIImage?
            if let error = error {
                print("Error generating thumbnail: \(error)")
            } else if let cgImage = cgImage {
                thumbnailImage = UIImage(cgImage: cgImage)
            }
            DispatchQueue.main.async {
                completion(thumbnailImage)
            }
        }
    }
    
    func openMediaPicker(sourceView: UIView? = nil) {
        let mediaPickerController = UIAlertController(
            title: "Choose Media",
            message: "Select an image, video, or document",
            preferredStyle: .actionSheet
        )
        
        mediaPickerController.addAction(UIAlertAction(title: "Select Image", style: .default) { _ in
            self.openImagePickerController()
        })
        
        mediaPickerController.addAction(UIAlertAction(title: "Select Video", style: .default) { _ in
            self.openVideoPickerController()
        })
        
        mediaPickerController.addAction(UIAlertAction(title: "Select PDF", style: .default) { _ in
            self.openDocumentPickerController()
        })
        
        mediaPickerController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        // ✅ Fix crash on iPad by setting popoverPresentationController
        if let popoverController = mediaPickerController.popoverPresentationController {
            popoverController.sourceView = sourceView ?? self.view
            popoverController.sourceRect = sourceView?.bounds ?? CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(mediaPickerController, animated: true)
    }
    
    func openImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openVideoPickerController() {
        let videoPicker = UIImagePickerController()
        videoPicker.delegate = self
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = ["public.movie"]
        present(videoPicker, animated: true, completion: nil)
    }
    
    func openDocumentPickerController() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func presentImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [UTType.image.identifier, UTType.movie.identifier] // Handles both images and videos
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func presentDocumentPickerController() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf]) // Handles PDFs
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            let mediaItem = MediaItem(type: .image, image: selectedImage)
            updateSelectedMediaItem(with: mediaItem)
        }
        else if let videoURL = info[.mediaURL] as? URL {
            generateThumbnailFromVideo(at: videoURL) { thumbnail in
                let mediaItem = MediaItem(type: .video, videoURL: videoURL, thumbnail: thumbnail)
                self.updateSelectedMediaItem(with: mediaItem)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func updateSelectedMediaItem(with mediaItem: MediaItem) {
        if selectedIndex < selectedMediaItems.count {
            selectedMediaItems[selectedIndex] = mediaItem
        } else {
            selectedMediaItems.append(mediaItem)
        }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let pdfURL = urls.first else { return }
        let mediaItem = MediaItem(type: .pdf, pdfURL: pdfURL)
        
        if selectedIndex < selectedMediaItems.count {
            selectedMediaItems[selectedIndex] = mediaItem  // Replace existing item
        } else {
            selectedMediaItems.append(mediaItem)  // Append if it's a new selection
        }
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document Picker was cancelled.")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var playIcon: UIImageView?
    @IBOutlet weak var pdfIcon: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playIcon?.isHidden = true
        pdfIcon?.isHidden = true
    }
    
    func configureForMedia(_ mediaItem: MediaItem) {
        if mediaItem.type == .video {
            playIcon?.isHidden = false
            pdfIcon?.isHidden = true
        } else if mediaItem.type == .pdf {
            playIcon?.isHidden = true
            pdfIcon?.isHidden = false
        }
    }
}
