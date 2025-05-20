//
//  ImagePopUpVc.swift
//  CFGApp
//
//  Created by Sakshi on 07/02/25.
//

import UIKit
import SDWebImage
import WebKit
import AVFoundation
import AVKit

class ImagePopUpVc: UIViewController {
    @IBOutlet var imgView: UIImageView?
    @IBOutlet var webView: WKWebView?
    @IBOutlet var videoView: UIView? // Add a view for video playback
    @IBOutlet var crossBtn: UIButton?
    
    var base64String: String?
    var fileType: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        crossBtn?.layer.cornerRadius = 20
        
        guard let base64String = base64String, let fileType = fileType else {
            print("❌ Error: Missing data")
            return
        }
        
        if fileType.hasSuffix(".jpg") || fileType.hasSuffix(".jpeg") || fileType.hasSuffix(".png") {
            // Show Image
            imgView?.isHidden = false
            webView?.isHidden = true
            videoView?.isHidden = true
            decodeBase64ToImage(base64String: base64String)
            
        } else if fileType.hasSuffix(".pdf") {
            // Show PDF
            imgView?.isHidden = true
            webView?.isHidden = false
            videoView?.isHidden = true
            decodeBase64ToPDF(base64String: base64String)
            
        } else if fileType.hasSuffix(".mp4") {
            // Play Video
            imgView?.isHidden = true
            webView?.isHidden = true
            videoView?.isHidden = false
            playVideo(base64String: base64String)
        }
    }
    
    // Decode Base64 to UIImage
    func decodeBase64ToImage(base64String: String) {
        if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters),
           let image = UIImage(data: imageData) {
            imgView?.image = image
        } else {
            print("❌ Error: Could not decode base64 to image")
        }
    }

    // Decode Base64 to PDF and show in WKWebView
    func decodeBase64ToPDF(base64String: String) {
        if let pdfData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            webView?.load(pdfData, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: URL(fileURLWithPath: ""))
        } else {
            print("❌ Error: Could not decode base64 to PDF")
        }
    }

    // Play MP4 Video
    func playVideo(base64String: String) {
        guard let videoData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("❌ Error: Could not decode base64 to video")
            return
        }
        
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempVideo.mp4")
        do {
            try videoData.write(to: tempURL)
            let player = AVPlayer(url: tempURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = videoView?.bounds ?? .zero
            playerLayer.videoGravity = .resizeAspectFill
            videoView?.layer.addSublayer(playerLayer)
            player.play()
        } catch {
            print("❌ Error: Unable to save video file - \(error.localizedDescription)")
        }
    }
    
    @IBAction func crossBtnAction() {
        self.dismiss(animated: true)
    }
}
