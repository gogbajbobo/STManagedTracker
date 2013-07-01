//
//  STDatum.h
//  STManagedTracker
//
//  Created by Maxim Grigoriev on 7/1/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class STComment;

@interface STDatum : NSManagedObject

@property (nonatomic, retain) NSDate * cts;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * lts;
@property (nonatomic, retain) NSDate * sqts;
@property (nonatomic, retain) NSDate * sts;
@property (nonatomic, retain) NSDate * ts;
@property (nonatomic, retain) NSData * xid;
@property (nonatomic, retain) NSSet *comments;
@end

@interface STDatum (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(STComment *)value;
- (void)removeCommentsObject:(STComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
