import UIKit
import Flutter
import YandexMapsMobile
import YooKassaPayments

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    YMKMapKit.setLocale("ru_RU") // Your preferred language. Not required, defaults to system language
    YMKMapKit.setApiKey("9aab96b7-29dd-405b-a42f-aa7660852345") // Your generated API key
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
