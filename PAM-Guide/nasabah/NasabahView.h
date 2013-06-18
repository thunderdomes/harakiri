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


@interface NasabahView : ViewController<UITableViewDataSource,UITableViewDelegate> {
    
    NSString *sessionID;
    NSMutableDictionary *observers;

}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic,copy) NSString *sessionID;

@property (nonatomic, strong) IBOutlet UILabel *customerName;
@property (nonatomic, strong) IBOutlet UILabel *cif;
@property (nonatomic, strong) IBOutlet UILabel *tanggalLahir;
@property (nonatomic, strong) IBOutlet UILabel *alamat;
@property (nonatomic, strong) IBOutlet UILabel *alamat2;
@property (nonatomic, strong) IBOutlet UILabel *telepon;
@property (nonatomic, strong) IBOutlet UILabel *telepon2;
@property (nonatomic, strong) IBOutlet UILabel *email;
@property (nonatomic, strong) IBOutlet UILabel *expiredKTP;
@property (nonatomic, strong) IBOutlet UILabel *kodeAgent;
@property (nonatomic, strong) IBOutlet UILabel *namaAgent;
@property (nonatomic, strong) IBOutlet UILabel *noKontakAgent;
@property (nonatomic, strong) IBOutlet UILabel *emailAgent;
@property (nonatomic, strong) IBOutlet UILabel *cabangAgent;

@property (nonatomic, strong) IBOutlet UIViewController *subv;

@property (nonatomic, retain) IBOutlet UITableView *navTable;
@property (nonatomic, retain) IBOutlet UIImageView *vertical;

@end
