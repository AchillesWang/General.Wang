//
//  ACAddAuthorController.m
//  Book_CoreData
//
//  Created by 潇翔 汪 on 14-4-13.
//  Copyright (c) 2014年 潇翔 汪. All rights reserved.
//

#import "ACAddAuthorController.h"
#import "ACAppDelegate.h"
#import "Author.h"

@interface ACAddAuthorController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) ACAppDelegate* appDelegate;
@end

@implementation ACAddAuthorController

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
    self.appDelegate = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
}
- (IBAction)completingTheAdd:(id)sender {
    NSString* authorName = self.name.text;
    NSString* authorDesc = self.desc.text;
    if (authorName && authorName.length>0 && authorDesc && authorDesc.length>0) {
        Author* author = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:self.appDelegate.managedObjectContext];
        author.name = authorName;
        author.authorDesc = authorDesc;
        NSError* error = nil;
        if ([self.appDelegate.managedObjectContext save:&error]) {
            NSLog(@"添加成功!");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"添加失败!:%@,%@",error,[error userInfo]);
        }
    }
}
- (IBAction)finishEdit:(id)sender {
    [sender resignFirstResponder];
}


@end
