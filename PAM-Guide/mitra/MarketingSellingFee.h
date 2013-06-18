//
//  MarketingSellingFee.h
//  PAM-Guide
//
//  Created by Dave Harry on 6/7/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"
#import "HUD.h"

@interface MarketingSellingFee : UIViewController{

     NSNumberFormatter *decimalFormatter;
}

@property(nonatomic, weak) CKCalendarView *calendar;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic,retain) NSString *sessionID;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) NSString *date;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property(nonatomic, strong) NSString *strTanggalFrom;
@property(nonatomic, strong) NSString *strTanggalTo;
@property(nonatomic, strong) NSString *responseString1;
 @property(nonatomic, strong) IBOutlet UIScrollView *scroll;
@end
