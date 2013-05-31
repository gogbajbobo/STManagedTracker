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
+ (NSString *)normalizeValue:(NSString *)value forKey:(NSString *)key;
+ (BOOL)isPositiveDouble:(NSString *)value;
+ (BOOL)isBool:(NSString *)value;
+ (BOOL)isValidTime:(NSString *)value;
+ (BOOL)isValidURI:(NSString *)value;

+ (STSettingsController *)initWithSettings:(NSDictionary *)startSettings;



- (NSString *)addNewSettings:(NSDictionary *)newSettings forGroup:(NSString *)group;

- (NSArray *)currentSettings;

- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;


@property (nonatomic, strong) NSMutableDictionary *startSettings;
@property (nonatomic, strong) id <STSession> session;

@end
