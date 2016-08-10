/*   Copyright 2014 APPNEXUS INC
 
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

#import "ANNativeImpressionTrackerInfo.h"
#import "NSTimer+ANCategory.h"

@interface ANNativeImpressionTrackerInfo()

@property (nonatomic, readwrite, strong) NSURL *URL;
@property (nonatomic, readwrite, strong) NSDate *dateCreated;
@property (nonatomic, readwrite, assign, getter=isExpired) BOOL expired;
@property (nonatomic, readwrite, strong) NSTimer *expirationTimer;

@end

@implementation ANNativeImpressionTrackerInfo

- (instancetype)initWithURL:(NSURL *)URL {
    if (!URL) {
        return nil;
    }
    if (self = [super init]) {
        _URL = URL;
        _dateCreated = [NSDate date];
        [self createExpirationTimer];
    }
    return self;
}

- (void)createExpirationTimer {
    __weak ANNativeImpressionTrackerInfo *weakSelf = self;
    self.expirationTimer = [NSTimer an_scheduledTimerWithTimeInterval:kANNativeImpressionTrackerExpirationInterval
                                                                block:^{
                                                                    ANNativeImpressionTrackerInfo *strongSelf = weakSelf;
                                                                    strongSelf.expired = YES;
                                                                }
                                                              repeats:NO];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ URL: %@", NSStringFromClass([self class]), self.URL];
}

- (void)dealloc {
    [self.expirationTimer invalidate];
}

@end