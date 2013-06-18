//
//  CekSaldo.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/27/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModelLib.h"
#import "CKCalendarView.h"


@interface CekSaldo : UIViewController {
    IBOutlet UILabel *label;
    NSNumberFormatter *numberFormatter;
    NSNumberFormatter *decimalFormatter;
    NSNumberFormatter *percentFormatter;
}

@property (nonatomic,retain) NSString *sessionID;
@property (nonatomic,retain) IBOutlet UILabel *label;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih;

@property (nonatomic,strong) IBOutlet UILabel *labelNon;
@property (nonatomic,strong) IBOutlet UILabel *saldoNon;
@property (nonatomic,strong) IBOutlet UILabel *nabNon;
@property (nonatomic,strong) IBOutlet UILabel *nabAverageNon;
@property (nonatomic,strong) IBOutlet UILabel *penutupuanNon;
@property (nonatomic,strong) IBOutlet UILabel *modalNon;
@property (nonatomic,strong) IBOutlet UILabel *nilaiNon;
@property (nonatomic,strong) IBOutlet UILabel *untungNon;
@property (nonatomic,strong) IBOutlet UILabel *persenNon;

@end

