//
//  ViewController.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/14/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelLib.h"
#import "NewsFeed.h"
#import "NAVFeed.h"
#import "HUD.h"
#import "Login.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JTRevealSidebarV2Delegate.h"

@class SidebarViewController;


@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> 
{
    IBOutlet UIScrollView *fader;
    IBOutlet UIScrollView *chaptermenu;
    NewsFeed *_feed;
    NAVFeed *_navfeed;
    IBOutlet UITextField *usernametosend;
    IBOutlet UITextField *passwordtosend;
    
    
}

@property (nonatomic, strong) IBOutlet UIViewController *subv;
@property (nonatomic, retain) IBOutlet UITableView *myTable;
@property (nonatomic, retain) IBOutlet UITableView *navTable;
@property (nonatomic, retain) IBOutlet UIImageView *vertical;
@property (nonatomic, strong) SidebarViewController *leftSidebarViewController;
@property (nonatomic, strong) UITableView *rightSidebarView;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;


@end
