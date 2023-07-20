import Flutter
import UIKit

public class FlutterDynamicIconsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_dynamic_icons", binaryMessenger: registrar.messenger())
    let instance = FlutterDynamicIconsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "supportsAlternateIcons":
      if (@available(iOS 10.3, *)) {
                result(@(UIApplication.sharedApplication.supportsAlternateIcons));
            } else {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                        message:@"Not supported on iOS ver < 10.3"
                                        details:nil]);
            }
    case "getAlternateIconName":
      if (@available(iOS 10.3, *)) {
                result(UIApplication.sharedApplication.alternateIconName);
            } else {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                        message:@"Not supported on iOS ver < 10.3"
                                        details:nil]);
            }
    case "setAlternateIconName":
       if (@available(iOS 10.3, *)) {
                @try {
                    NSString *iconName = call.arguments[@"iconName"];
                    if (iconName == [NSNull null]) {
                        iconName = nil;
                    }
                    [UIApplication.sharedApplication setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
                        if(error) {
                            result([FlutterError errorWithCode:@"Failed to set icon"
                                                    message:[error description]
                                                    details:nil]);
                        } else {
                            result(nil);
                        }
                    }];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@", exception.reason);
                    result([FlutterError errorWithCode:@"Failed to set icon"
                                            message:exception.reason
                                            details:nil]);
                }
            } else {
                result([FlutterError errorWithCode:@"UNAVAILABLE"
                                        message:@"Not supported on iOS ver < 10.3"
                                        details:nil]);
            }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
