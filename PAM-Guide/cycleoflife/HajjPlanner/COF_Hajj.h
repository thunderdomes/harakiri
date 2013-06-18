//
//  COFKendaraan.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface COF_Hajj : UIViewController <CKCalendarDelegate,UIGestureRecognizerDelegate> {
    IBOutlet UISegmentedControl *Segment;
    
    IBOutlet UISlider *sliderTipeReksadana;
    IBOutlet UISlider *sliderTingkatInflasi;
    IBOutlet UISlider *sliderModalUsaha;
    IBOutlet UISlider *sliderKebutuhanLainnya;

    
    IBOutlet UILabel *labelTingkatInflasi;
    IBOutlet UILabel *labeSliderlDP;
    IBOutlet UILabel *labelSliderLamaPinjaman;
    IBOutlet UILabel *labelSliderBungaPinjaman;
    IBOutlet UILabel *labelDanaDP;
    IBOutlet UILabel *labelInvestasiSekarang;
    IBOutlet UILabel *labelInvestasiPerBulan;
    IBOutlet UILabel *labelTanggalDPDiperlukan;
    IBOutlet UILabel *labelTipeReksaDana;
    IBOutlet UILabel *labelTahunPinjam;
    
    IBOutlet UITextField *teksHargaKendaraan;
    IBOutlet UILabel *pilihReksaDana;
 
    
    NSString *tipeReksadana;
    NSString *valuetosave;
    NSInteger slidereksadana;
    NSInteger slidemodalusaha;
    NSInteger slidehargavalue;
    NSInteger slideangkainflasi;
    NSInteger slidekebutuhanlainnya;
    NSInteger jumlahorang;
    NSInteger lamapinjamvalue;
    NSInteger bungapinjamvalue;
    NSInteger modalusaha;
    NSInteger kebutuhan;
}

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSString *nowdate;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih2;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, retain) NSDate *endDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property(nonatomic, strong) NSNumber *stepper;
@property (nonatomic, strong) IBOutlet UIImageView *konservatif;
@property (nonatomic, strong) IBOutlet UIImageView *moderat;
@property (nonatomic, strong) IBOutlet UIImageView *agresif;
@property (nonatomic, strong) IBOutlet UIImageView *moneyfull1;
@property (nonatomic, strong) IBOutlet UIImageView *moneyfull2;
@property (nonatomic, strong) IBOutlet UIImageView *moneyfull3;
@property (nonatomic, strong) IBOutlet UIImageView *moneyfull4;
@property (nonatomic, strong) IBOutlet UIImageView *moneyfull5;
@property (nonatomic, strong) IBOutlet UIImageView *moneyfull6;


-(IBAction)pickDate:(id)sender;




@end
