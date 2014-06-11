//
//  Book.h
//  Book_CoreData
//
//  Created by 潇翔 汪 on 14-4-13.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * publishHouse;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *author;

@end
