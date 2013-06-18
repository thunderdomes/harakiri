//
//  COFKendaraan.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface COFMarriage: UIViewController <CKCalendarDelegate> {
    IBOutlet UISegmentedControl *Segment;
    IBOutlet UISlider *sliderTingkatInflasi;
    IBOutlet UISlider *sliderDP;
    IBOutlet UILabel *labelTingkatInflasi;
    IBOutlet UILabel *labeSliderlDP;
    IBOutlet UILabel *labelDanaDP;
    IBOutlet UILabel *labelInvestasiSekarang;
    IBOutlet UILabel *labelInvestasiPerBulan;
    IBOutlet UITextField *teksHargaKendaraan;
}

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSString *nowdate;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, strong) NSArray *disabledDates;



@end
