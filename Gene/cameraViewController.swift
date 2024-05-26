//
//  ViewController.swift
//  Gene
//
//  Created by manoj on 15/12/23.
//


import UIKit
import AVFoundation
import Photos
import CoreMotion
import CoreImage




class cameraViewController : UIViewController,AVCapturePhotoCaptureDelegate,UIGestureRecognizerDelegate{
 
    
    
    
    var cameraView: UIView!
    var captureButton: UIButton!
    var cameraSwitchButton: UIButton!
    var flashModeButton: UIButton!
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
    var currentCamera: AVCaptureDevice?
    var ultraWideCamera: AVCaptureDevice!
    var captureSession = AVCaptureSession()
    var stillImageOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var positionString = String()
    var imageView : UIImageView!
    var currentZoomFactor: CGFloat = 1.0
    var maxZoomFactor: CGFloat = 5.0
    var zoomStep: CGFloat = 1.0
    var currentFlashMode : String! // AVCaptureDevice.FlashMode = .auto // set flash mode on auto
    var isFlashOn: Bool = false
    var exposurePoint = CGPoint(x: 0.5, y: 0.5)
    var focusPoint = CGPoint(x: 0.5, y: 0.5)
    var boxView = UIView()
    var exposureSlider: UISlider!
    var currentExposureBias: Float = 0.0
    var currentFocusLevel: Float = 0.0
    var currentExposureValue: Float = 0.5
    var motionManager: CMMotionManager!
    var yawAngle: Double = 0.0
    var aspectControll : UISegmentedControl? // segment controll for select a aspect ratio
//    var currentAspectRatio : AVCaptureSession.Preset = .photo// set default aspet ratio on capture session
    var selectedAspectRatio: String = "4:3"
    var selectedlens : String = "1:1"
    var timerButton : UIButton!
    var timerDuration: TimeInterval = 0
    var timerLabel: UILabel!
    var timer : Timer?
    var styleButton : UIButton!
    var levelView: UIView!
    var Currenttolerance : CGFloat = 1.0
    var straightAngle: CGFloat =  0.0
    var wideControll : UISegmentedControl!
    var switchButton : UIButton!
    var homeButton : UIButton!
    var capturedImage: UIImage?
    var sliderHiderTimer: Timer!
    var finalAngle : Double = 0.0
    var portraitEffectButton : UIButton!
    var isPortraitEffectEnabled: Bool = true
    var porttraitEffectMatte : AVPortraitEffectsMatte?
    var finalAngleFromPicture : Double = 0.0
    
    var aspectLabel : UIView!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .black
        setupCameraView()
        setupCamera()
        setupButtons()
        setupGestures()
        setupLevelView()
        setupBoxAndSliderView()
        setAspectRatio(selectedAspectRatio)
        setupMotionManager(finalAngle: finalAngle)
        setCameralens(selectedlens)
        //        GridView()
        addGridView(cameraView: cameraView)
        
        if timerDuration == 3.0 {
            timerButton.setTitle("3", for: .normal)
            timerButton.setTitleColor(.white, for: .normal)
            
        }
        else if timerDuration == 10.0 {
            
            timerButton.setTitle("10", for: .normal)
            timerButton.setTitleColor(.white, for: .normal)
        } else {
            timerButton.setTitle(" ", for: .normal)
        }
        
        aspectControll?.layer.cornerRadius = 50
        aspectControll?.layer.borderColor = UIColor.white.cgColor
       aspectControll?.layer.masksToBounds = true
        
        
        
    }
  
    //it was using for hide status bar on display eg:battery status,singnal
    override  var prefersStatusBarHidden: Bool{
        return true
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
//            self.previewLayer?.connection?.videoOrientation = self.currentVideoOrientation()
            self.previewLayer?.frame = self.cameraView.bounds
        }, completion: nil)
    }

    func setupCameraView() {
        cameraView = UIView()
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraView)
        
        NSLayoutConstraint.activate([
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cameraView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
              

    }
    
    
    func setupLevelView() {
        levelView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 2))
        levelView.backgroundColor = UIColor.red
        view.addSubview(levelView)
        levelView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            levelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            levelView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            levelView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        

            
            guard let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) else {
            print("Unable to access the ultra-wide camera.")
            return
        }
        self.ultraWideCamera = ultraWideCamera

            _ = AVCapturePhotoSettings()
            guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("Unable to access the back camera.")
                return
            }
            
            
            self.backCamera = backCamera
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Unable to access the front camera.")
            return
        }
        self.frontCamera = frontCamera


        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
        else { fatalError("No dual camera")}

      currentCamera = backCamera

        if let currentCamera = currentCamera {
            setupZoom(for: currentCamera)
            setupExposure(for: currentCamera)
        }

        do {
            let input = try AVCaptureDeviceInput(device: videoDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            
            stillImageOutput = AVCapturePhotoOutput()
            if stillImageOutput.isPortraitEffectsMatteDeliverySupported {
                stillImageOutput.isPortraitEffectsMatteDeliveryEnabled = true
            } else {
            print("Depth delivery not supported")
            }
            if captureSession.canAddOutput(stillImageOutput!) {
                captureSession.addOutput(stillImageOutput!)
            }

//            changeAspectRatio(preset: currentAspectRatio)
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = cameraView.bounds
            cameraView?.layer.addSublayer(previewLayer)

            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        } catch {
            print("Error setting up camera: \(error)")
        }

      
      stillImageOutput.isDepthDataDeliveryEnabled = stillImageOutput.isDepthDataDeliverySupported
       self.captureSession.commitConfiguration()
    }
    
    
  
    func setCameralens(_ cameralens: String) {
        
        switch cameralens {
            
        case "1x" :
            if let backCamera = backCamera {
                
                switchCamera(to: backCamera)
                wideControll.selectedSegmentIndex = 0
            }
        case "0.5" :
            
            if let ultraWideCamera = ultraWideCamera {
                switchCamera(to: ultraWideCamera)
                wideControll.selectedSegmentIndex = 1
            }
        default:

            if let backCamera = backCamera {
                switchCamera(to: backCamera)
                wideControll.selectedSegmentIndex = 0
            }
        }
        
        selectedlens  = cameralens
    }
    
    
    @objc func wideAngleValueChanged(_ sender: UISegmentedControl) {
        guard let angleControll = sender as? UISegmentedControl else {return}
        setCameralens(angleControll.titleForSegment(at: angleControll.selectedSegmentIndex) ?? "")
    }
    
    func switchCamera(to newCamera: AVCaptureDevice) {
        //captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        //  currentCamera = newCamera
        printCameraPosition()
        // Remove the existing input
        guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput else { return }
        captureSession.removeInput(currentInput)

        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            if captureSession.canAddInput(newInput) {
                captureSession.addInput(newInput)
                currentCamera = newCamera
                

            }
            
            else {
                print("Could not add input for the new camera.")
            }
        } catch {
            print("Error setting up the input for the new camera: \(error)")
        }
     
        captureSession.commitConfiguration()
    }
    
    func switchcamera(to cameraPosition: String) {

        switch cameraPosition.lowercased() {
        case "front":
         
            
            if let frontCamera = frontCamera {
                switchCamera(to: frontCamera)
             
            }
            wideControll?.isHidden = true
        case "back":
         
            
            if let backCamera = backCamera {
                
                switchCamera(to: backCamera)
              
            }
            wideControll?.isHidden = false

            
        default:
            print("Invalid camera position: \(cameraPosition)")
        }
        
        positionString = cameraPosition
    }
    
    func printCameraPosition() {
        guard let currentCamera = currentCamera else {
            print("Current camera is nil.")
            return
        }
        
        DispatchQueue.main.async { [self] in
            positionString = (currentCamera.position == .front) ? "Front" : "Back"
            print(positionString)
        }
   
    }
    
    func updateCountdownLabel(_ secondsRemaining: Int) {
        DispatchQueue.main.async {
            self.timerLabel.text = "\(secondsRemaining)s"
        }
    }
    
    @objc func switchCameraButtonTapped(_ sender: UIButton) {
        
        // frontback("front")
        
        if let currentCamera = currentCamera {
            
            let newCamera = (currentCamera.position == .back) ? FrontCamera() : Backcamera()
            
            switchCamera(to: newCamera!)
            
            setupZoom(for: newCamera!)
            setupExposure(for: newCamera!)
            
            printCameraPosition()
        }
    }

    func FrontCamera() -> AVCaptureDevice? {
        
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        //wideControll.isHidden = true
    }
    
    func Backcamera() -> AVCaptureDevice? {
        
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    }
 
    func startCountdown(duration: TimeInterval) {
        timerDuration = duration
        var secondsRemaining = Int(duration)
        updateCountdownLabel(secondsRemaining)
        
        timer?.invalidate() // Invalidate any existing timers
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            secondsRemaining -= 1
            updateCountdownLabel(secondsRemaining)
            
            if secondsRemaining <= 0 {
                timer.invalidate()
                capturePhoto(self.timerButton)
            }
        }
    }

    func stopCountdown() {
        timer?.invalidate()
        timerLabel.text = " "
        timerDuration = 0
    }
    
    
    func setAspectRatio(_ aspectRatio: String) {
        
        _ = AVCapturePhotoSettings()
        switch aspectRatio {
    
        case "4:3":
        changeAspectRatio(preset: .photo)
        aspectControll?.selectedSegmentIndex = 0

        case "16:9":
        changeAspectRatio(preset: .high)
        aspectControll?.selectedSegmentIndex = 1
        case "1:1":
        setSquareAspectRatio()
        aspectControll?.selectedSegmentIndex = 2
        default:
//            break
            changeAspectRatio(preset: .photo)
            aspectControll?.selectedSegmentIndex = 0
        }
        
        selectedAspectRatio = aspectRatio
        
        // print(selectedAspectRatio)
    }
    
    @objc func segmentControllValueChanged(_ sender: UISegmentedControl) {
        guard let aspectControll = sender as? UISegmentedControl else { return }
        setAspectRatio(aspectControll.titleForSegment(at: aspectControll.selectedSegmentIndex) ?? "")
    }
    
    
    func changeAspectRatio(preset: AVCaptureSession.Preset) {
 
        captureSession.beginConfiguration()
    
        captureSession.sessionPreset = preset
        captureSession.commitConfiguration()
 
        DispatchQueue.main.async {
            let previewLayerHeight: CGFloat
            let yOffset: CGFloat
            
            switch preset {
            case .photo: // 4:3
                previewLayerHeight = UIScreen.main.bounds.width * 4 / 3
                yOffset = (UIScreen.main.bounds.height - previewLayerHeight) / 2.0
                
            case .high: // 16:9
                previewLayerHeight = UIScreen.main.bounds.width * 16 / 9
                yOffset = (UIScreen.main.bounds.height - previewLayerHeight) / 2.0
     
                
            default:
                return
            }
            
            self.previewLayer?.frame = CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: previewLayerHeight)
        }
    }
    
   
    func setSquareAspectRatio() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        captureSession.commitConfiguration()

       
        
        let previewLayerHeight = UIScreen.main.bounds.width
        let yOffset = (UIScreen.main.bounds.height - previewLayerHeight) / 2.0
        previewLayer?.frame = CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: previewLayerHeight)
    }
    
    
    @objc func timerButtonTapped(_ sender: UIButton) {
        // Toggle between off, 3s, and 10s timer modes
        switch timerDuration {
        case 0:

                timerDuration = 3
                sender.setTitle("3s", for: .normal)
                sender.setTitleColor(.white, for: .normal)
          
        case 3:

                timerDuration = 10
                sender.setTitle("10s", for: .normal)
                sender.setTitleColor(.white, for: .normal)
        case 10:
          
                timerDuration = 0
                sender.setTitle("", for: .normal)
                sender.setTitleColor(.white, for: .normal)
        default:
            break
        }
        
    }
 
    
    func togglePortraitEffect() {
        isPortraitEffectEnabled = !isPortraitEffectEnabled
        
        
        guard let currentCamera = currentCamera else {
                print("No current camera available.")
                return
            }
            
            do {
                try currentCamera.lockForConfiguration()
                
              
                if isPortraitEffectEnabled {
              
                    if stillImageOutput.isPortraitEffectsMatteDeliveryEnabled {
                     
                        stillImageOutput.isPortraitEffectsMatteDeliveryEnabled = true
                     
                    } else {
                        print("Portrait effects matte delivery not supported.")
                 
                    }
                } else {
                
                    stillImageOutput.isPortraitEffectsMatteDeliveryEnabled = false

                }
                
                currentCamera.unlockForConfiguration()
            } catch {
                print("Error adjusting camera settings: \(error)")
            }
            
        
        if isPortraitEffectEnabled {
            portraitEffectButton.setTitle("Portrait: On", for: .normal)
            portraitEffectButton.setTitleColor(.green, for: .normal)
        } else {
            portraitEffectButton.setTitle("Portrait: Off", for: .normal)
            portraitEffectButton.setTitleColor(.red, for: .normal)
        }
        // Apply portrait effect settings to the camera session as needed
    }

    @objc func portraitEffectButtonTapped(_ sender: UIButton) {
         togglePortraitEffect()
     }
    
    func setupMotionManager(finalAngle: Double) {
       motionManager = CMMotionManager()
//          motionManager.deviceMotionUpdateInterval = 0.1
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }
                
                // guard let motion = motionManager.deviceMotion else {return}
                let attitude = motion.attitude
                let roll = attitude.roll * 180.0
                



              
                let rotationAngle = CGFloat(roll) * .pi / 720
//                print("rotation\(rotationAngle)")
//                let rotationAngle = CGFloat(roll) / 720
                
                levelView?.transform = CGAffineTransform(rotationAngle: rotationAngle)
                _ = Currenttolerance
              
                
                if rotationAngle >= finalAngle - 0.1 && rotationAngle <= finalAngle + 0.1 {
                    
                    self.levelView?.backgroundColor = UIColor.green
                } else {
                    
                    self.levelView?.backgroundColor = UIColor.red
                }
              
                finalAngleFromPicture = rotationAngle

            }
        } else {
            print("Device motion data is not available.")
        }
    }

  
    @objc func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        guard let currentCamera = currentCamera else {
            print("No current camera available.")
            return
        }
        
        do {
            try currentCamera.lockForConfiguration()
            
            let zoomFactor = currentZoomFactor * recognizer.scale
            currentCamera.videoZoomFactor = max(1.0, min(zoomFactor, maxZoomFactor))
            
            currentCamera.unlockForConfiguration()
        } catch {
            print("Error adjusting zoom: \(error)")
        }
        
        if recognizer.state == .ended {
            updateZoomFactor(currentCamera.videoZoomFactor)
        }
    }
  
    @objc func capturePhoto(_ sender: UIButton) {
       
        if timerDuration > 0 {
           
            captureButton.isEnabled = false
           
            var countdown = timerDuration
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                countdown -= 1
                if countdown <= 0 {
                   
                    self.captureImage()
                    timer.invalidate()
            
                    DispatchQueue.main.async {
                    
                        self.captureButton.isEnabled = true
                        
                        self.timerLabel.isHidden = true
                    }
                } else {
                    
                    self.updateCountdownLabel(Int(countdown))
                }
            }
          
            timerLabel.isHidden = false
            timer?.fire()
            
        }
        else {

            captureImage()
        }

        
    }
    func captureImage() {
        guard let stillImageOutput = stillImageOutput else {return}
       
        let photoSettings = AVCapturePhotoSettings()


        if isFlashOn {
           photoSettings.flashMode = .on
   
        } else {
            photoSettings.flashMode = .off
     
        }
        
        if stillImageOutput.isDepthDataDeliverySupported {
            photoSettings.isDepthDataDeliveryEnabled = true
        } else {
            photoSettings.isDepthDataDeliveryEnabled = false
        }
        stillImageOutput.capturePhoto(with: photoSettings, delegate: self)

    }
    func applyPortraitEffect(to image: UIImage) -> UIImage? {
        if isPortraitEffectEnabled {
       
            let context = CIContext(options: nil)
            if let ciImage = CIImage(image: image) {
                let filter = CIFilter(name: "CIGaussianBlur")
                filter?.setValue(ciImage, forKey: kCIInputImageKey)
                filter?.setValue(10.0, forKey: kCIInputRadiusKey) // Adjust blur radius as needed
                
                if let outputCIImage = filter?.outputImage,
                   let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
                    let blurredImage = UIImage(cgImage: outputCGImage)
                    return blurredImage
                }
            }
        }
        return image
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
           if let error = error {
               print("Error capturing photo: \(error)")
               return
           }
           
           guard let imageData = photo.fileDataRepresentation() else {
               print("Error getting photo data.")
               return
           }
           
           if let image = UIImage(data: imageData) {
  
//               savePhotoToLibrary(image)
//               uploadImage(image: image)
               if selectedAspectRatio == "1:1"  {
                   if let croppedImage = cropImageToSquare(image) {
                       capturedImage = croppedImage
                       let preview = photoPreviewViewController(frame: view.bounds)
                       preview.cameraVC = self
                       preview.imageView.image = croppedImage
                       view.addSubview(preview)
                   } else {
                       print("Error cropping image.")
                   }
               }else {
                   
                   capturedImage = image
                   let preview = photoPreviewViewController(frame: view.bounds)
                   preview.cameraVC = self
                   preview.imageView.image = capturedImage
                   view.addSubview(preview)
               }

               
                }
            
     
       }
    
    func cropImageToSquare(_ image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let imageSize = min(image.size.width, image.size.height)
        let croppedRect = CGRect(x: (image.size.width - imageSize) / 2.0,
                                 y: (image.size.height - imageSize) / 2.0,
                                 width: imageSize,
                                 height: imageSize)
        
        if let croppedCGImage = cgImage.cropping(to: croppedRect) {
            return UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
        }
        
        return nil
    }
            func savePhotoToLibrary(_ image: UIImage) {

            _ = AVCapturePhotoSettings()
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    print("Photo library access not authorized.")
                    return
                }
                
                PHPhotoLibrary.shared().performChanges {
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                } completionHandler: { [self] success, error in
                    if let error = error {
                        print("Error saving photo to library: \(error)")
                    } else {
                        print("Photo saved to library successfully.")
                        print("Zoom Level: \(self.currentZoomFactor)")
                        print("Exposure Value: \(currentExposureValue)")
                        print("Focus Level: \(currentFocusLevel)")
                        print ("Flash mode :\( String(describing: isFlashOn))")
                        print("Timer:\(timerDuration)")
                        print("Aspect Ratio :\(selectedAspectRatio)")
                        print(selectedlens)
                        print("currentCamera:\(positionString)")

                    }
                }
            }
        }
 
    @objc func flashButtonPressed(_ sender: UIButton) {
      
            isFlashOn = !isFlashOn
  
            let image = isFlashOn ? "bolt.circle" : "bolt.slash.circle"
            flashModeButton.setImage(UIImage(systemName: image)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        }
 
    
    func showFocusBox(at point: CGPoint) {
        guard let previewLayer = previewLayer else { return }
        
     
        let convertedPoint = previewLayer.convert(point, from: cameraView.layer)
        if !previewLayer.bounds.contains(convertedPoint) {

            boxView.isHidden = true
            return
        }
        
       
        let boxSize: CGFloat = 100.0
        let boxRect = CGRect(x: point.x - boxSize / 2, y: point.y - boxSize / 2, width: boxSize, height: boxSize)
        boxView.frame = boxRect
        boxView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.boxView.isHidden = true
        }
    }

     func showSlider(at point: CGPoint) {
         
         guard  let previewLayer = previewLayer else {return}
         
         let convertedPoint = previewLayer.convert(point, from: cameraView.layer)
         
         if !previewLayer.bounds.contains(convertedPoint) {
             exposureSlider.isHidden = true
             return
         }
         let yOffset: CGFloat = 2 * 35
         let sliderY =  point.y + yOffset
         exposureSlider.center = CGPoint(x: point.x , y: sliderY)
         exposureSlider.isHidden = false
          resetSliderHideTimer()
         DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
             self.exposureSlider.isHidden = true
             
         }
     }
  
     func resetSliderHideTimer() {
         // Invalidate the existing timer (if any)
        sliderHiderTimer?.invalidate()

         // Create a new timer to hide the slider after 5 seconds of inactivity
     sliderHiderTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
             self?.exposureSlider.isHidden = true
         }
     }
     


    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            let tapPoint = recognizer.location(in: cameraView)
            
            // Convert the tap point to the coordinate space of the camera view
            let convertedPoint = cameraView.convert(tapPoint, from: view)
            
            // Ensure that the tap point is within the bounds of the camera view
            if cameraView.bounds.contains(convertedPoint) {
                showFocusBox(at: convertedPoint)
                updateFocus(at: convertedPoint)
                showSlider(at: convertedPoint)
            }
        }
    }

  
    func updateZoomFactor(_ zoomFactor: CGFloat) {
        currentZoomFactor = zoomFactor
        
        
        guard let currentCamera = currentCamera else {
            print("current camera cannot available")
            return
        }
       // if activeCamera.position == .back {
            do {
                try currentCamera.lockForConfiguration()
                defer { currentCamera.unlockForConfiguration() }
                
                // Check if the active camera supports zooming
          
                    if currentCamera.activeFormat.videoMaxZoomFactor > 1.0 {
                        let maxZoomFactor = min(maxZoomFactor, currentCamera.activeFormat.videoMaxZoomFactor)
                        let scaledZoomFactor = max(1.0, min(zoomFactor, maxZoomFactor))
                        
                        
                        currentCamera.videoZoomFactor = scaledZoomFactor
                    }
                    
                  
                 else {
                    print("Zoom is not supported for the active camera.")
                }
            } catch {
                print("Error updating zoom factor: \(error)")
            }
        }
    

    
    func setupZoom(for camera: AVCaptureDevice) {
        do {
            try camera.lockForConfiguration()
            camera.videoZoomFactor = currentZoomFactor
            camera.unlockForConfiguration()
        } catch {
            print("Error setting up zoom: \(error)")
        }
    }

    func setupExposure(for camera: AVCaptureDevice) {
        do {
            try camera.lockForConfiguration()
            camera.exposureMode = .continuousAutoExposure
            camera.unlockForConfiguration()
        } catch {
            print("Error setting up exposure: \(error)")
        }
    }

    
    func updateCustomFocusAndExposure(at point: CGPoint) {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access the camera.")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            defer { backCamera.unlockForConfiguration() }
            
            // Convert the point from the camera view's coordinate system to the preview layer's coordinate system
            let convertedPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            // Update the custom focus and exposure points
            if backCamera.isFocusModeSupported(.autoFocus) && backCamera.isFocusPointOfInterestSupported {
                backCamera.focusMode = .autoFocus
                backCamera.focusPointOfInterest = convertedPoint
            }
            
            if backCamera.isExposureModeSupported(.autoExpose) && backCamera.isExposurePointOfInterestSupported {
                backCamera.exposureMode = .autoExpose
                backCamera.exposurePointOfInterest = convertedPoint
            }
        } catch {
            print("Error updating custom focus and exposure: \(error)")
        }
    }
    
    func updateFocusAndExposure(at point: CGPoint) {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access the camera.")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            defer { backCamera.unlockForConfiguration() }
            
            // Convert the point from the camera view's coordinate system to the preview layer's coordinate system
            let convertedPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            if backCamera.isFocusModeSupported(.continuousAutoFocus) && backCamera.isFocusPointOfInterestSupported {
                backCamera.focusMode = .continuousAutoFocus
                backCamera.focusPointOfInterest = convertedPoint
            }
            
            if backCamera.isExposureModeSupported(.continuousAutoExposure) && backCamera.isExposurePointOfInterestSupported {
                backCamera.exposureMode = .continuousAutoExposure
                backCamera.exposurePointOfInterest = convertedPoint
            }
        } catch {
            print("Error updating focus and exposure: \(error)")
        }
    }
    

    @objc func exposureSliderValueChanged(_ slider: UISlider) {
        let exposureValue = slider.value
        _ = max(exposureSlider.minimumValue, min(exposureSlider.maximumValue, exposureValue))
        
        // Apply the exposure value to the camera
        updateExposure(exposureValue)
    }

    
    func calculateExposureValue(_ exposureValue: Float, for device: AVCaptureDevice) -> Float {
        let maxExposureValue = device.maxExposureTargetBias
        let minExposureValue = device.minExposureTargetBias
        return (exposureValue - minExposureValue) / (maxExposureValue - minExposureValue)
    }
    func calculateFocusLevel(_ focusValue:  Float, for device: AVCaptureDevice) -> Float{
        let maxFocusValue = device.maxExposureTargetBias
        let minFocusValue = device.minExposureTargetBias
        return (focusValue - minFocusValue) / (maxFocusValue - minFocusValue)
    }
    
    func updateFocus(at point: CGPoint, isCloseDepth: Bool = false) {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access the camera.")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            defer { backCamera.unlockForConfiguration() }
            
            let convertedPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            if backCamera.isFocusPointOfInterestSupported {
                backCamera.focusPointOfInterest = convertedPoint
            }
            
            if backCamera.isFocusModeSupported(.continuousAutoFocus) {
                backCamera.focusMode = isCloseDepth ? .autoFocus : .continuousAutoFocus
                
                currentFocusLevel = calculateFocusLevel(backCamera.exposureTargetBias, for: backCamera)
            }
        } catch {
            print("Error updating focus: \(error)")
        }
    }
    
    
    
    func updateExposure(_ value: Float) {

        guard let currentCamera = currentCamera else {
            print("No current camera available")
            return
        }
        do {
            try currentCamera.lockForConfiguration()
            defer { currentCamera.unlockForConfiguration() }
            
            if currentCamera.isExposureModeSupported(.custom) {
                let minExposureValue = currentCamera.minExposureTargetBias
                let maxExposureValue = currentCamera.maxExposureTargetBias
                
                // Calculate the actual exposure value from the slider value
                let clampedValue = max(minExposureValue, min(maxExposureValue, value))
                currentCamera.setExposureTargetBias(clampedValue, completionHandler: nil)
                
                currentExposureValue = calculateExposureValue(clampedValue, for: currentCamera)
                
            }
        } catch {
            print("Error updating exposure: \(error)")
            
            
        }
        
    }
   
    func updateExposure2(_ value: Double) {
      //  if let backCamera = AVCaptureDevice.default(for: .video) {
            
        guard let currentCamera  = currentCamera  else {
            print("current camera did not works")
            
            return
        }
            do {
                //try backCamera.lockForConfiguration()
                
                try currentCamera.lockForConfiguration()

                // Calculate the relative exposure target bias within the valid range
                let minExposure = currentCamera.minExposureTargetBias
                let maxExposure = currentCamera.maxExposureTargetBias
    

                let clampedValue = min(maxExposure, max(minExposure, Float(value)))

                let relativePercentage = minExposure + (maxExposure - minExposure) * clampedValue

                currentCamera.setExposureTargetBias(relativePercentage, completionHandler: nil)

                currentCamera.unlockForConfiguration()
            } catch {
                print("Error updating exposure configuration: \(error)")
            }
        }
    
    func addGridView(cameraView: UIView) {
     let horizontalMargin = cameraView.bounds.size.width / 4
     let verticalMargin = cameraView.bounds.size.height / 4

     let gridView = GridView()
     gridView.translatesAutoresizingMaskIntoConstraints = false
     cameraView.addSubview(gridView)
     gridView.backgroundColor = UIColor.clear
     gridView.leftAnchor.constraint(equalTo: cameraView.leftAnchor, constant: horizontalMargin).isActive = true
     gridView.rightAnchor.constraint(equalTo: cameraView.rightAnchor, constant: -1 * horizontalMargin).isActive = true
     gridView.topAnchor.constraint(equalTo: cameraView.topAnchor, constant: verticalMargin).isActive = true
     gridView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor, constant: -1 * verticalMargin).isActive = true
    }

    func setupButtons() {
     
        let symbolconfig = UIImage.SymbolConfiguration(pointSize: 40)
//        let cameraImage = UIImage(systemName: "circle.circle.fill", withConfiguration: symbolconfig)?
//            .withTintColor(.white, renderingMode: .alwaysOriginal)
        
        let cameraImage = UIImage(named: "shutter")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        
        captureButton = UIButton(type: .system) // Use custom button type
        captureButton.setImage(cameraImage, for: .normal)
        
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        captureButton.addTarget(self, action: #selector(capturePhoto(_:)), for: .touchUpInside)
        view.addSubview(captureButton)
        
        
       
        
        let cameraswitchImage = UIImage(systemName: "arrow.triangle.2.circlepath.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        cameraSwitchButton = UIButton(type: .system)
        cameraSwitchButton.setImage(cameraswitchImage, for: .normal)
        cameraSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        cameraSwitchButton.setTitleColor(.white, for: .normal)
        cameraSwitchButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        
        cameraSwitchButton.addTarget(self, action: #selector(switchCameraButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(cameraSwitchButton)
        

        let offflashimage = UIImage(systemName: "bolt.slash.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        flashModeButton = UIButton(type: .system)
        flashModeButton.setImage(offflashimage, for: .normal)
        flashModeButton.translatesAutoresizingMaskIntoConstraints = false
        flashModeButton.setTitleColor(.white, for: .normal)
        flashModeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        flashModeButton.addTarget(self, action: #selector(flashButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(flashModeButton)
        
        
        
        aspectControll = UISegmentedControl(items: ["4:3","16:9","1:1"])
//        aspectControll?.frame = CGRect(x: 50, y: 100, width: 300, height: 40)
        aspectControll?.selectedSegmentTintColor = .systemYellow.withAlphaComponent(0.5)
        aspectControll?.clipsToBounds = true
        aspectControll?.layer.masksToBounds = true
        aspectControll?.layer.borderColor = UIColor.white.cgColor
        aspectControll?.addTarget(self, action: #selector(segmentControllValueChanged(_:)), for: .valueChanged)
        aspectControll?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aspectControll!)
        
        
        let timerimage = UIImage(systemName: "gauge.with.needle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        timerButton = UIButton(type: .system)
        timerButton.setImage(timerimage, for: .normal)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        timerButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        timerButton.addTarget(self, action: #selector(timerButtonTapped(_: )), for: .touchUpInside)
        view.addSubview(timerButton)
        
        
        timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.text = ""
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(timerLabel)
        
        
//           portraitEffectButton = UIButton(type: .system)
//           portraitEffectButton.setTitle("Portrait: On", for: .normal)
//           portraitEffectButton.setTitleColor(.green, for: .normal)
//           portraitEffectButton.translatesAutoresizingMaskIntoConstraints = false
//           portraitEffectButton.addTarget(self, action: #selector(portraitEffectButtonTapped(_:)), for: .touchUpInside)
//           view.addSubview(portraitEffectButton)
        
        
        
        wideControll = UISegmentedControl(items: ["1x", "0.5"])
        wideControll.contentScaleFactor.round()
        wideControll.selectedSegmentTintColor = .systemYellow.withAlphaComponent(0.5)
        wideControll.layer.masksToBounds = true
        wideControll.translatesAutoresizingMaskIntoConstraints = false
//        wideControll.selectedSegmentIndex = 0 // Select the default segment
        wideControll.addTarget(self, action: #selector(wideAngleValueChanged(_:)), for: .valueChanged)
        view.addSubview(wideControll)
        
        aspectLabel = UIView()
        aspectLabel.backgroundColor = .white.withAlphaComponent(0.5)
        aspectLabel.layer.masksToBounds = true
        aspectLabel.layer.cornerRadius = 15

        aspectLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aspectLabel)
        
        
        NSLayoutConstraint.activate([
            
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            // captureButton.widthAnchor.constraint(equalToConstant: captureButtonWidth),
            captureButton.heightAnchor.constraint(equalTo: captureButton.widthAnchor),
            
            
            flashModeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Align to the right edge
            flashModeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13), // Align the top with cameraSwitchButton's top
            flashModeButton.widthAnchor.constraint(equalToConstant: 50),
            flashModeButton.heightAnchor.constraint(equalToConstant: 50),
//            
//            portraitEffectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            portraitEffectButton.topAnchor.constraint(equalTo: flashModeButton.bottomAnchor, constant: 20),
            
//            aspectControll!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            aspectControll!.centerYAnchor.constraint(equalTo: view.bottomAnchor,constant: -130 ),
            
            cameraSwitchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // 20 points from the right edge
            cameraSwitchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),   // 20 points from the bottom edge
            cameraSwitchButton.widthAnchor.constraint(equalToConstant: 80), // Set the desired width
            cameraSwitchButton.heightAnchor.constraint(equalToConstant: 40),
      
            
            timerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -300),
            timerButton.bottomAnchor.constraint(equalTo: cameraSwitchButton.bottomAnchor),
            timerButton.widthAnchor.constraint(equalToConstant: 50),
            timerButton.heightAnchor.constraint(equalToConstant: 50),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            
            wideControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wideControll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -185),
            
            aspectControll!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aspectControll!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // Adjust constant as needed
//            aspectControll!.widthAnchor.constraint(equalToConstant: 133), // Set a specific width or adjust as needed
//            aspectControll!.heightAnchor.constraint(equalToConstant: 36), // Set a specific height or adjust as needed
            
 
        ])

    
        
    }
    
  
  

    func setupBoxAndSliderView() {
        
        boxView = UIView()
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.layer.borderWidth = 2.0
        boxView.layer.borderColor = UIColor.yellow.cgColor
        boxView.isHidden = true
        view.addSubview(boxView)
         
        
//            aeaftext = UILabel()
//            aeaftext.text = "AE/AF Locked"
//            aeaftext.font = .systemFont(ofSize: 12)
//            aeaftext.textColor = .white
//            aeaftext.isHidden = true
//            aeaftext.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(aeaftext)
        
        exposureSlider = UISlider()
       
        exposureSlider.minimumValue = -5.0
        exposureSlider.maximumValue = 5.0
        exposureSlider.value = 0.0
        exposureSlider.frame = CGRect(x: 50, y: 100, width: 20, height: 200)
        exposureSlider.addTarget(self, action: #selector(exposureSliderValueChanged(_:)), for: .valueChanged)
        exposureSlider.minimumTrackTintColor = .yellow
        exposureSlider.maximumTrackTintColor = .white
        exposureSlider.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

      let thumbImage = UIImage(systemName: "sun.max.fill" )?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        let thumbSize = CGSize(width: 45, height: 45)
  
        let resizedThumbImage = thumbImage?.resize(targetSize: thumbSize)
      
        exposureSlider.setThumbImage(resizedThumbImage, for: .normal)
        view.addSubview(exposureSlider)
       view.bringSubviewToFront(exposureSlider)
        
        exposureSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exposureSlider.widthAnchor.constraint(equalToConstant: 250), // Adjust width here
            exposureSlider.heightAnchor.constraint(equalToConstant: 50),
            exposureSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exposureSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               ])

        
    }
    
        
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert image to data")
            return
        }

        let url = URL(string: ApiUrl.host + ApiUrl.putApi)!
        let boundary = UUID().uuidString

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let authToken = "gAAAAABlx0wucQVJU6sob0_gyErXrwShtcmhgwlZ8cLBfRrI8HpFfgSvYX4x78wGS4yNC_XtrM2E8I31Tm3m4XBvc5w9ppmSFc82L79C_NYSjbePylr7ne9fGd-OltLVSA6WHfLkCan_BcBIvpioHjFmzB_FWgpgXg=="
        
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
     
        var data = Data()

        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"user_image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)

        let json_data  = [
               
                   "zoomLevel": currentZoomFactor,
                   "exposureValue": currentExposureValue,
                   "focusLevel": currentFocusLevel,
                   "flasMode" : isFlashOn,
                   "Timer" : timerDuration,
                   "aspectRatio" : selectedAspectRatio,
                   "cameralens" : selectedlens,
                   "cameraangle" : finalAngleFromPicture,
                   "cameraposition" : positionString
                   
                   
        ] as [String : Any]

        print(json_data)

        if let json = try? JSONSerialization.data(withJSONObject: json_data, options: []) {
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"json_data\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            data.append(json)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        }


        let task = URLSession.shared.uploadTask(with: request, from: data) { responseData, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    if let responseData = responseData {
                        do {
                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                            print("API Response: \(json)")
                        } catch {
                            print("Error parsing JSON: \(error)")
                        }
                    }
                } else {
                    print("HTTP Response Status Code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }
    

        func setupGestures() {

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
      view.addGestureRecognizer(pinchGesture)
        pinchGesture.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
       view.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        view.isUserInteractionEnabled = true

//           let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
//            longPressGesture.minimumPressDuration = 2
//            tapGesture.delegate = self
//         view.addGestureRecognizer(longPressGesture)
        
    }
}


class GridView: UIView {

 override func draw(_ rect: CGRect) {

     let firstColumnPath = UIBezierPath()
     firstColumnPath.move(to: CGPoint(x: bounds.width / 3, y: 0))
     firstColumnPath.addLine(to: CGPoint(x: bounds.width / 3, y: bounds.height))
     let firstColumnLayer = gridLayer()
     firstColumnLayer.path = firstColumnPath.cgPath
     layer.addSublayer(firstColumnLayer)

     let secondColumnPath = UIBezierPath()
     secondColumnPath.move(to: CGPoint(x: (2 * bounds.width) / 3, y: 0))
     secondColumnPath.addLine(to: CGPoint(x: (2 * bounds.width) / 3, y: bounds.height))
     let secondColumnLayer = gridLayer()
     secondColumnLayer.path = secondColumnPath.cgPath
     layer.addSublayer(secondColumnLayer)

     let firstRowPath = UIBezierPath()
     firstRowPath.move(to: CGPoint(x: 0, y: bounds.height / 3))
     firstRowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 3))
     let firstRowLayer = gridLayer()
     firstRowLayer.path = firstRowPath.cgPath
     layer.addSublayer(firstRowLayer)

     let secondRowPath = UIBezierPath()
     secondRowPath.move(to: CGPoint(x: 0, y: ( 2 * bounds.height) / 3))
     secondRowPath.addLine(to: CGPoint(x: bounds.width, y: ( 2 * bounds.height) / 3))
     let secondRowLayer = gridLayer()
     secondRowLayer.path = secondRowPath.cgPath
     layer.addSublayer(secondRowLayer)
 }
 private func gridLayer() -> CAShapeLayer {
     let shapeLayer = CAShapeLayer()
     shapeLayer.strokeColor = UIColor(white: 1.0, alpha: 0.3).cgColor
     shapeLayer.frame = bounds
     shapeLayer.fillColor = nil
     return shapeLayer
 }
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?
        CGSize(width: size.width * heightRatio, height: size.height * heightRatio) :
        CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}


