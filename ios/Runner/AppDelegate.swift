import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "com.jasco.app/target",
            binaryMessenger: controller.binaryMessenger
        )
        
        let bundleIdentifier = Bundle.main.bundleIdentifier
        
        var targetType = "runner"
        
        if bundleIdentifier == "com.jasco.appClip.Clip" {
            targetType = "appclip"
        }
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "getTargetType" {
                result(targetType)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
