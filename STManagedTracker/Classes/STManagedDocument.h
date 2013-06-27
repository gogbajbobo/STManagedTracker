//
//  STGTManagedDocument.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/11/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface STManagedDocument : UIManagedDocument

@property(nonatomic, strong, readonly) NSManagedObjectModel *myManagedObjectModel;

+ (STManagedDocument *)documentWithUID:(NSString *)uid dataModelName:(NSString *)dataModelName;
+ (STManagedDocument *)documentWithUID:(NSString *)uid dataModelName:(NSString *)dataModelName prefix:(NSString *)prefix;

- (void)saveDocument:(void (^)(BOOL success))completionHandler;

@end
