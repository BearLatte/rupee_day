import UIKit
import AVFoundation

class TakeFacePhotoView: UIViewController {
    
    var didTakePhotoAction: ((_ selectedImage: UIImage?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(titleLabel)
        view.addSubview(backBtn)
        view.addSubview(indicatorLabel)
        view.addSubview(bigCircle)
        view.addSubview(smallCircle)
        view.addSubview(shutterBtn)
        view.addSubview(bottomToolBar)
        setupCamera()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: UIScreen.main.bounds.width, height: 44)
        backBtn.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 44, height: 44)
        indicatorLabel.frame = CGRect(x: 20, y: CGRectGetMaxY(titleLabel.frame), width: UIScreen.main.bounds.width - 40, height: 44)
        
        let bigCircleRatio = UIScreen.main.bounds.width - 25 * 2
        bigCircle.frame = CGRect(x: 0, y: 0, width: bigCircleRatio, height: bigCircleRatio)
        bigCircle.center = view.center
        bigCircle.layer.cornerRadius = bigCircleRatio * 0.5
        
        let smallCircleRatio = UIScreen.main.bounds.width - 35 * 2
        smallCircle.frame = CGRect(x: 0, y: 0, width: smallCircleRatio, height: smallCircleRatio)
        smallCircle.center = view.center
        smallCircle.layer.cornerRadius = smallCircleRatio * 0.5
        smallCircle.layer.masksToBounds = true
        
        shutterBtn.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 40 - 82, width: 82, height: 82)
        shutterBtn.center.x = view.center.x
        bottomToolBar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width, height: 50)
        
        previewLayer.backgroundColor = UIColor.white.cgColor
        smallCircle.layer.addSublayer(previewLayer)
        previewLayer.frame = smallCircle.bounds
    }
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.text = "Detail"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var backBtn = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var indicatorLabel = {
        let lb = UILabel()
        lb.text = "Please keep all faces in the viewfinder and\nmust upload clear photos."
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 16.0)
        lb.textColor = UIColor(red: 21/255.0, green: 23/255.0, blue: 59/255.0, alpha: 1.000)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var bigCircle = createCircleView(borderWidth: 3)
    private lazy var smallCircle = createCircleView(borderWidth: 6)
    
    private lazy var shutterBtn = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "shutter_icon"), for: .normal)
        btn.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        return btn
    }()
    
    private lazy var bottomToolBar : UIView = {
        let view = UIView()
        view.addSubview(retryBtn)
        view.addSubview(submitBtn)
        view.isHidden = true
        return view
    }()
    
    private lazy var retryBtn = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Retry", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.backgroundColor = UIColor(red: 224/255.0, green: 151/255.0, blue: 84/255.0, alpha: 1.000)
        btn.layer.cornerRadius = 25
        btn.frame = CGRect(x: 20, y: 0, width: (UIScreen.main.bounds.width - 40 - 7) * 0.5, height: 50)
        btn.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var submitBtn = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        btn.backgroundColor = UIColor(red: 21/255.0, green: 23/255.0, blue: 59/255.0, alpha: 1.000)
        btn.layer.cornerRadius = 25
        btn.frame = CGRect(x: CGRectGetMaxX(retryBtn.frame) + 7, y: 0, width: (UIScreen.main.bounds.width - 40 - 7) * 0.5, height: 50)
        btn.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        return btn
    }()
    
    private var session : AVCaptureSession?
    private let output  : AVCapturePhotoOutput = AVCapturePhotoOutput()
    private let previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    private var currentTakedImage: UIImage?
    
    private func createCircleView(borderWidth: Double) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = UIColor(red: 224/255.0, green: 151/255.0, blue: 84/255.0, alpha: 1.000).cgColor
        return view
    }
}

extension TakeFacePhotoView {
    private func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                DispatchQueue.global().async {
                    session.startRunning()
                }
                self.session = session
            } catch {
                ErrorAlertView.showAlert(with: "Take photo error") {
                    self.dismiss(animated: true)
                } confirmAction: {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @objc func backAction() {
        self.dismiss(animated: true)
    }
    
    @objc func takePhoto() {
        shutterBtn.isHidden = true
        bottomToolBar.isHidden = false
        indicatorLabel.isHidden = true
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc func retryAction() {
        shutterBtn.isHidden = false
        bottomToolBar.isHidden = true
        indicatorLabel.isHidden = false
        DispatchQueue.global().async {
            self.session?.startRunning()
        }
    }
    
    @objc func submitAction() {
        didTakePhotoAction?(currentTakedImage)
        self.dismiss(animated: true)
    }
}

extension TakeFacePhotoView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            ErrorAlertView.showAlert(with: error?.localizedDescription ?? "", cancelAction: backAction) {
                self.session?.startRunning()
            }
            
            return
        }
        session?.stopRunning()
        currentTakedImage = image
    }
}
