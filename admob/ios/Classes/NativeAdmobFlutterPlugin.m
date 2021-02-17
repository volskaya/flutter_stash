#import "AdmobPlugin.h"
#if __has_include(<admob/admob-Swift.h>)
#import <admob/admob-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "admob-Swift.h"
#endif

@implementation AdmobPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAdmobPlugin registerWithRegistrar:registrar];
}
@end
