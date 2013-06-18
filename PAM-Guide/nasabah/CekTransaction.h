//
//  CekTransaction.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/28/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPickerView.h"
#import "CKCalendarView.h"
#import "NIDropDown.h"

#define kObserver @"vcRadioButtonItemFromGroupSelected"


@interface CekTransaction : UIViewController <AFPickerViewDataSource, AFPickerViewDelegate,NIDropDownDelegate>
{
    AFPickerView *periodePickerView;
    AFPickerView *daysPickerView;
    NSArray *daysData;
    NSArray *periodeData;
    IBOutlet UIButton *buttonJumlahTransaksi;
    IBOutlet UIButton *buttonPeriodeTransaksi;
    NSString *ftype;
    NSString *fvalue;
    IBOutlet UILabel *label;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIScrollView *periode;
    
    IBOutlet UIButton *btnSelect;
    NIDropDown *dropDown;
    
    NSNumberFormatter *decimalFormatter;
    
}


@property(nonatomic, strong) IBOutlet UIButton *jumlahTransaksi;
@property(nonatomic, strong) IBOutlet UIButton *periodeTransaksi;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (nonatomic,copy) IBOutlet NSString *ftype;
@property (nonatomic,copy) IBOutlet NSString *fvalue;
@property (nonatomic,retain) NSString *sessionID;
@property (nonatomic,retain) NSArray *historyID;
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong) IBOutlet UILabel *label;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
@property (nonatomic, retain) IBOutlet NIDropDown *dropdown;
@property (retain, nonatomic) IBOutlet UIButton *btnDateFrom;
@property (retain, nonatomic) IBOutlet UIButton *btnDateTo;
@property(nonatomic, strong) IBOutlet UIScrollView *periode;
@property(nonatomic, strong) NSString *strTanggalFrom;
@property(nonatomic, strong) NSString *strTanggalTo;

@property (nonatomic,retain) NSString *responseString1;
@property (nonatomic,retain) NSString *responseString2;



@end
