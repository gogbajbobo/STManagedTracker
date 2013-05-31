//
//  STGTSessionManagement.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/24/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STManagedDocument.h"

@protocol STSessionManager <NSObject>

- (void)startSessionForUID:(NSString *)uid authDelegate:(id)authDelegate trackers:(NSDictionary *)trackers settings:(NSDictionary *)settings;
- (void)stopSessionForUID:(NSString *)uid;
- (void)sessionCompletionFinished:(id)session;
- (void)cleanCompletedSessions;

@end

@protocol STSettingsController <NSObject>

- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;

@end

@protocol STSession <NSObject>

+ (id <STSession>)initWithUID:(NSString *)uid authDelegate:(id)authDelegate trackers:(NSDictionary *)trackers settings:(NSDictionary *)settings;
- (void)completeSession;
- (void)dismissSession;
- (void)settingsLoadComplete;

@property (strong, nonatomic) STManagedDocument *document;
@property (nonatomic, strong) id <STSettingsController> settingsController;
@property (strong, nonatomic) NSString *status;

@end