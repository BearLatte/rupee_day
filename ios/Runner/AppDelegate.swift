import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        currentController = window.rootViewController as? FlutterViewController
        methodChanel = FlutterMethodChannel(name: "rupeeDay.method.channel", binaryMessenger: currentController as! FlutterBinaryMessenger)
        
        methodChanel.setMethodCallHandler { call, result in
            if call.method == "liveness" {
                let params = call.arguments as! [String : String]
                FaceLivenessParams.instance.apiId = params["alkccwsuauthId"] ?? ""
                FaceLivenessParams.instance.apiSecret = params["alkccwsuauthSecret"] ?? ""
                FaceLivenessParams.instance.hostUrl = params["alkccwsuauthHostUrl"] ?? ""
                self.go2liveness()
            }
            
            if call.method == "takeFacePhotoAction" {
                self.go2takeFacePhoto()
            }

            if call.method == "getStoageInfo" {
                let totalStorage = "\(UIDevice.current.totalDiskSpaceInBytes)"
                let freeStorage = "\(UIDevice.current.freeDiskSpaceInBytes)"
                let percentOfUsedStorage = Double(UIDevice.current.totalDiskSpaceInBytes - UIDevice.current.freeDiskSpaceInBytes) / Double(UIDevice.current.totalDiskSpaceInBytes) * 100
                result([
                    "internalTotalStorage": totalStorage,
                    "internalUsableStorage":freeStorage,
                    "percentValue" : "\(Int(percentOfUsedStorage))%",
                    "model":UIDevice.current.modelName,
                    "brightness": String(format: "%.0f", UIScreen.main.brightness * 100.0)]
                );
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private var livenessVC : DFActionLivenessController!
    private var currentController : FlutterViewController!
    private var methodChanel : FlutterMethodChannel!
}

extension AppDelegate {
    func go2liveness() {
        let outType = "multiImg"
        let sequence = ["HOLDSTILL", "BLINK", "MOUTH", "NOD", "YAW"]
        let threshold = [0.7, 0.7, 0.7, 0.7, 0.7]
        let dict : [String : Any] = ["sequence" : sequence, "outType": outType, "threshold": threshold, "autoAntiHack" : true]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict),
              let strJson = String(data: data, encoding: .utf8) else {
            return
        }
        
        livenessVC = DFActionLivenessController()
        livenessVC.setJsonCommand(strJson)
        livenessVC.delegate = self
        livenessVC.modalPresentationStyle = .fullScreen
        
        currentController.present(livenessVC, animated: true) {
            self.livenessVC.restart()
        }
    }
    
    func go2takeFacePhoto() {
        let takePicView = TakeFacePhotoView()
        takePicView.modalPresentationStyle = .fullScreen
        takePicView.didTakePhotoAction = { selectedImage in
            if let imgPath = self.saveImage(image: selectedImage) {
                self.methodChanel.invokeMethod("takePhotoCompleted", arguments: imgPath)
            }
        }
        currentController.present(takePicView, animated: true)
    }
    
    func saveImage(image: UIImage?) -> String? {
        if let data = image?.jpegData(compressionQuality: 1) {
            let imgPath = NSTemporaryDirectory() + "temp.jpg"
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: imgPath) {
                // 删除文件
                guard (try? fileManager.removeItem(atPath: imgPath)) != nil else {
                    return nil
                }
            }
            
            // 写入文件
            let isSuccess = FileManager.default.createFile(atPath: imgPath, contents: data)
            
            if(isSuccess) {
                return imgPath
            }
        }
        return nil
    }
}


extension AppDelegate: DFActionLivenessDelegate {
    func actionLivenessDidSuccessfulGet(_ encryTarData: Data!, dfImages arrDFImage: [Any]!, dfVideoData: Data!, isHack: Bool) {
        
    }
    
    
    func actionLivenessDidSuccessfulGet(_ encryTarData: Data!, dfImages arrDFImage: [Any]!, dfVideoData: Data!) {
        
    }
    
    func actionLivenessDidSuccessful(withScore score: CGFloat, dfImages arrDFImage: [Any]!, errorTip: String!) {
        DispatchQueue.main.async {
            self.livenessVC.dismiss(animated: true)
        }
        
        if let image = (arrDFImage?.last as? DFImage)?.image, let imgPath = saveImage(image: image) {
            methodChanel.invokeMethod("livenessCompleted", arguments: ["imgPath": imgPath, "score": "\(score)"])
        }
        
        
        //        if let image = ,let data = image.jpegData(compressionQuality: 1) {
        //            let imgPath = NSTemporaryDirectory() + "temp.jpg"
        //            let fileManager = FileManager.default
        //            if fileManager.fileExists(atPath: imgPath) {
        //                // 删除文件
        //                guard (try? fileManager.removeItem(atPath: imgPath)) != nil else {
        //                    return
        //                }
        //            }
        //
        //            // 写入文件
        //            let isSuccess = FileManager.default.createFile(atPath: imgPath, contents: data)
        //
        //            if(isSuccess) {
        //                methodChanel.invokeMethod("livenessCompleted", arguments: ["imgPath": imgPath, "score": "\(score)"])
        //            }
        //        }
    }
    
    func actionLivenessDidFail(withType iErrorType: DFActionLivenessError, detectionType iDetectionType: DFDetectionType, detectionIndex iIndex: Int, data encryTarData: Data!, dfImages arrDFImage: [Any]!, dfVideoData: Data!) {
        if iErrorType == .faceChanged && iIndex == 0 {
            livenessVC.restart()
            return
        }
        
        switch iErrorType {
        case .initFaild:
            showAlert(message: "SDK initialization failed")
        case .cameraError:
            showAlert(message: "Camera permission acquisition failed")
        case .faceChanged:
            showAlert(message: "No face detected,please try again.")
        case .timeOut:
            showAlert(message: "Detection timeout")
        case .willResignActive:
            showAlert(message: "App is about to be suspended")
        case .internalError:
            showAlert(message: "Internal error")
        case .bundleIDError:
            showAlert(message: "The package name in the license does not match with application ID, please use the right license file")
        case .sequenceError:
            showAlert(message: "Action sequence error")
        case .authExpire:
            showAlert(message: "Device time is not within the validity period of the license, pls use the valid license")
        case .faceMoreThanOneError:
            showAlert(message: "Multiple faces detected, please try again")
        case .licenseInvalid:
            showAlert(message: "License file invalid")
        case .badJson:
            showAlert(message: "Bad json profile")
        @unknown default:
            break
        }
        
    }
    
    func actionLivenessDidCancel() {
        methodChanel.invokeMethod("livenessCancel", arguments: nil)
    }
    
    private func showAlert(message: String) {
        DispatchQueue.main.async {
            ErrorAlertView.showAlert(with: message) {
                self.livenessVC.dismiss(animated: true)
                self.livenessVC.cancel()
            } confirmAction: {
                self.livenessVC.restart()
            }
        }
    }
}
