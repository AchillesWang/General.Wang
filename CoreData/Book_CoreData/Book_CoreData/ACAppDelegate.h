//
//  ACAppDelegate.h
//  Book_CoreData
//
//  Created by 潇翔 汪 on 14-4-13.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ACAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(readonly,nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property(readonly,nonatomic,strong) NSManagedObjectModel* managedObjectModel;

@property(readonly,nonatomic,strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;


-(void)saveContext;

-(NSURL*)applicationDocumentDirectory;


@end
