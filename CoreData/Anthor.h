//
//  Anthor.h
//  CoreData
//
//  Created by 潇翔 汪 on 14-3-12.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Anthor : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photo;
@end

@interface Anthor (CoreDataGeneratedAccessors)

- (void)addPhotoObject:(Photo *)value;
- (void)removePhotoObject:(Photo *)value;
- (void)addPhoto:(NSSet *)values;
- (void)removePhoto:(NSSet *)values;

@end
