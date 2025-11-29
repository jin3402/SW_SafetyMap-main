import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // .env 파일에서 API 키 읽기
    if let envPath = Bundle.main.path(forResource: ".env", ofType: nil) {
      if let envContent = try? String(contentsOfFile: envPath, encoding: .utf8) {
        for line in envContent.split(separator: "\n") {
          let trimmed = String(line).trimmingCharacters(in: .whitespaces)
          if trimmed.hasPrefix("GOOGLE_MAPS_API_KEY=") {
            let apiKey = String(trimmed.dropFirst("GOOGLE_MAPS_API_KEY=".count))
            GMSServices.provideAPIKey(apiKey)
            break
          }
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
