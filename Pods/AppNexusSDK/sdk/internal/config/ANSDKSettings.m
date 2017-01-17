/*   Copyright 2016 APPNEXUS INC
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "ANSDKSettings.h"
#import "ANSDKSettings+PrivateMethods.h"

@interface ANProdHTTPBaseUrlConfig : NSObject <ANBaseUrlConfig>

@end

@implementation ANProdHTTPBaseUrlConfig

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ANProdHTTPBaseUrlConfig *config;
    dispatch_once(&onceToken, ^{
        config = [[ANProdHTTPBaseUrlConfig alloc] init];
    });
    return config;
}

- (NSString *)webViewBaseUrl {
    return @"http://mediation.adnxs.com/";
}

- (NSString *)adRequestBaseUrl {
    return @"http://mediation.adnxs.com/mob";
}

@end

@interface ANProdHTTPSBaseUrlConfig : NSObject <ANBaseUrlConfig>

@end

@implementation ANProdHTTPSBaseUrlConfig

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ANProdHTTPSBaseUrlConfig *config;
    dispatch_once(&onceToken, ^{
        config = [[ANProdHTTPSBaseUrlConfig alloc] init];
    });
    return config;
}

- (NSString *)webViewBaseUrl {
    return @"https://mediation.adnxs.com/";
}

- (NSString *)adRequestBaseUrl {
    return @"https://mediation.adnxs.com/mob";
}

@end

@interface ANSDKSettings()

@property (nonatomic) id<ANBaseUrlConfig> baseUrlConfig;

@end

@implementation ANSDKSettings

+ (id)sharedInstance {
    static dispatch_once_t sdkSettingsToken;
    static ANSDKSettings *sdkSettings;
    dispatch_once(&sdkSettingsToken, ^{
        sdkSettings = [[ANSDKSettings alloc] init];
    });
    return sdkSettings;
}

- (id<ANBaseUrlConfig>)baseUrlConfig {
    if (!_baseUrlConfig) {
        if (self.HTTPSEnabled) {
            return [ANProdHTTPSBaseUrlConfig sharedInstance];
        } else {
            return [ANProdHTTPBaseUrlConfig sharedInstance];
        }
    } else {
        return _baseUrlConfig;
    }
}

@end