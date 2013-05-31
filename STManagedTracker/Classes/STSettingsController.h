//
//  STHTSettingsController.h
//  geotracking
//
//  Created by Maxim Grigoriev on 1/24/13.
//  Copyright (c) 2013 Maxim V. Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "STSessionManagement.h"

//#define mapYandex 0
//#define mapApple 1

@interface STSettingsController : NSObject <STSettingsController>

+ (NSDictionary *)defaultSettings;

+ (STSettingsController *)initWithSettings:(NSDictionary *)startSettings;

+ (NSString *)normalizeValue:(NSString *)value forKey:(NSString *)key;

- (NSString *)addNewSettings:(NSDictionary *)newSettings forGroup:(NSString *)group;

- (NSArray *)currentSettings;

- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;


@property (nonatomic, strong) NSMutableDictionary *startSettings;
@property (nonatomic, strong) id <STSession> session;

@end
