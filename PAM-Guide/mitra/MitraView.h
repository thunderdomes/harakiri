//
//  NasabahView.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "NAVFeed.h"
#import "HUD.h"


@interface MitraView : ViewController<UITableViewDataSource,UITableViewDelegate> {
    
    NSString *sessionID;
    NSString *ciftext;
    NSDictionary* json;
    NSArray *cifarray;
    IBOutlet UIScrollView *scroll;
    NSNumberFormatter *decimalFormatter;

}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic,copy) NSString *sessionID;

@property (nonatomic, strong) IBOutlet UILabel *customerName;
@property (nonatomic, strong) IBOutlet UILabel *cif;
@property (nonatomic, strong) IBOutlet UILabel *tanggalLahir;
@property (nonatomic, strong) IBOutlet UILabel *tanggaltransaksi;
@property (nonatomic, strong) IBOutlet UILabel *listfund;
@property (nonatomic, strong) IBOutlet UILabel *amountnonusd;
@property (nonatomic, strong) IBOutlet UILabel *amountusd;


@property (nonatomic, strong) IBOutlet UIViewController *subv;

@property (nonatomic, retain) IBOutlet UITableView *navTable;
@property (nonatomic, retain) IBOutlet UIButton *buttonHTTPRequest;

@property (nonatomic,retain) NSString *responseString1;
@property (nonatomic,retain) NSString *responseString2;

-(IBAction)httpRequest:(id)sender;
-(IBAction)back;


@end
