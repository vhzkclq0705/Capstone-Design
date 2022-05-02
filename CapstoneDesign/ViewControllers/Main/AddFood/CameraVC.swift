//
//  CameraVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/04/28.
//

import UIKit
import AVFoundation
import Alamofire

class CameraVC: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var foodList: UILabel!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    var captureSession: AVCaptureSession!
    var camera: AVCaptureDevice!
    var cameraInput: AVCaptureInput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoOutput: AVCaptureVideoDataOutput!
    
    var takePicture = false
    var realTime = Timer()
    var timeTrigger = true
    var cnt = 0
    
    var capturedFoodList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        initCamera()
    }
    
    @IBAction func captureButton(_ sender: Any) {
        if timeTrigger {
            print("캡쳐 시작")
            checkTimeTrigger()
        } else {
            print("캡쳐 종료")
            captureButton.isHidden = true
            completeButton.isHidden = false
            timerStop()
        }
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SetAddFoodVC") as? SetAddFoodVC else { return }
         vc.resultFoodList = capturedFoodList
         
         self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CameraVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    func initCamera() {
        // captureSession 설정
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            camera = device
        }
        
        // cameraInput 설정
        guard let cameraDeviceInput = try? AVCaptureDeviceInput(device: camera) else { return }
        cameraInput = cameraDeviceInput
        captureSession.addInput(cameraInput)
        
        // previewLayer 설정
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        self.previewLayer.frame = self.cameraView.frame
        cameraView.layer.insertSublayer(previewLayer, at: 0)
        
        // videoOutput 설정
        videoOutput = AVCaptureVideoDataOutput()
        let cameraBufferQueue = DispatchQueue(label: "cameraQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: cameraBufferQueue)
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        videoOutput.connections.first?.videoOrientation = .portrait
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
    
    // 캡쳐 시 발생
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if !takePicture {
            return
        }
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
        let uiImage = UIImage(ciImage: ciImage)
        
        self.ImagePost(image: uiImage)
        self.takePicture = false
    }
    
    func checkTimeTrigger() {
        realTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        timeTrigger = false
    }
    
    @objc func updateCounter() {
        self.takePicture = true
    }
    
    func timerStop() {
        realTime.invalidate()
        self.captureSession.stopRunning()
    }
    
    func ImagePost(image: UIImage) {
        let url = ""
        let imgData = image.jpegData(compressionQuality: 0)!
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
        }, to: url)
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                if let data = json as? NSDictionary {
                    if let foods = data["class_name"] as? [String] {
                        self.foodList.text = ""
                        self.capturedFoodList = foods
                        self.capturedFoodList = Array(Set(self.capturedFoodList))
                        self.capturedFoodList = changeEngToKor(foods: self.capturedFoodList)
                    }
                    print("인식된 재료: \(self.capturedFoodList)")
                    if self.capturedFoodList.count > 0 {
                        for i in 0...self.capturedFoodList.count - 1 {
                            self.foodList.text! += self.capturedFoodList[i] + " "
                        }
                    }
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}
