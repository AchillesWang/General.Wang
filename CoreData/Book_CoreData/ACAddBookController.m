//
//  ACAddBookController.m
//  Book_CoreData
//
//  Created by 汪潇翔 on 14-4-14.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import "ACAddBookController.h"
#import "ACAppDelegate.h"
#import "Book.h"

@interface ACAddBookController ()
@property (weak, nonatomic) IBOutlet UITextField *SN;
@property (weak, nonatomic) IBOutlet UITextField *bookName;
@property (weak,nonatomic) ACAppDelegate* appDelegate;
@end

@implementation ACAddBookController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = [UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)completeAdd:(id)sender {
    NSString* name = self.bookName.text;
    NSString* publishHome = self.SN.text;
    if (name && name.length>0 && publishHome && publishHome.length>0) {
        Book* book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.appDelegate.managedObjectContext];
        book.name = name;
        book.publishHouse = publishHome;
        book.author = self.author;
        NSError* error = nil;
        if (![self.appDelegate.managedObjectContext save:&error]) {
            NSLog(@"存储错误:%@,%@",error,[error userInfo]);
        }else{
            NSLog(@"添加成功!");
        }
    }
}


@end
