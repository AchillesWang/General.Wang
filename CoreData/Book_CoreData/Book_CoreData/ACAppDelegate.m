//
//  ACAppDelegate.m
//  Book_CoreData
//
//  Created by 潇翔 汪 on 14-4-13.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import "ACAppDelegate.h"


@implementation ACAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
-(void)saveContext
{
    NSError* error = nil;
    NSManagedObjectContext* managedObjectContext = self.managedObjectContext;
    if (managedObjectContext) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unreolved error %@,%@",error,[error userInfo]);
            abort();
        }
    }
}
//模型管理
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator* persistentStoreCoordinator = self.persistentStoreCoordinator;
    if (persistentStoreCoordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        _managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
    }
    return _managedObjectContext;
}
//模型
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL* modeURL = [[NSBundle mainBundle] URLForResource:@"Books" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modeURL];
    return _managedObjectModel;
}
//存储管理
-(NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    NSError* error = nil;
    NSURL* storeURL = [[self applicationDocumentDirectory] URLByAppendingPathComponent:@"Books.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        //初始化失败
        NSLog(@"Unreolved error，%@，%@",error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}
-(NSURL*)applicationDocumentDirectory
{
    NSLog(@"%@",NSHomeDirectory());
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}
@end
