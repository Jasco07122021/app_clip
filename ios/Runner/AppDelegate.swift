import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var methodChannel: FlutterMethodChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        methodChannel = FlutterMethodChannel(
            name: "com.jasco.app/appClip",
            binaryMessenger: controller.binaryMessenger
        )
        
        let bundleIdentifier = Bundle.main.bundleIdentifier
        
        var targetType = "runner"
        
        if bundleIdentifier == "com.jasco.appClip.Clip" {
            targetType = "appclip"
        }
        
        var initialUrl: String? = nil
        
        if let url = launchOptions?[.url] as? URL {
            initialUrl = url.absoluteString
        }
        
        methodChannel?.setMethodCallHandler { (call, result) in
            switch call.method {
            case "getTargetType": result(targetType);
            case "getInitialUrl" : result(initialUrl);
            default: result(FlutterMethodNotImplemented);
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([any UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let url = userActivity.webpageURL {
            methodChannel?.invokeMethod("handleIncomingURL", arguments: url.absoluteString)
        }
        return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
}
