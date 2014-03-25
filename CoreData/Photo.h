//
//  Photo.h
//  CoreData
//
//  Created by 潇翔 汪 on 14-3-12.
//  Copyright (c) 2014年 NextTime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Anthor;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Anthor *anthor;

@end
