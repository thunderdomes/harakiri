//
//  COFKendaraan.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface COFHoliday : UIViewController <CKCalendarDelegate,UIGestureRecognizerDelegate> {
    IBOutlet UISegmentedControl *Segment;
    IBOutlet UITextField *ticketFlight;
    IBOutlet UITextField *accomodation;
    IBOutlet UITextField *others;
    IBOutlet UISlider *sliderTingkatInflasi;
    IBOutlet UISlider *sliderOrang;
    IBOutlet UISlider *sliderBiayaTransport;
    IBOutlet UISlider *sliderBiayaAkomodasi;
    IBOutlet UISlider *sliderKebutuhanLain;
    IBOutlet UILabel *labelTingkatInflasi;
    IBOutlet UILabel *labelOrang;
    IBOutlet UILabel *labelJumlahDanaDibutuhkan;
    IBOutlet UILabel *labelInvestasiSekarang;
    IBOutlet UILabel *labelInvestasiPerBulan;
    
    IBOutlet UILabel *labelTanggalDPDiperlukan;
    IBOutlet UILabel *labelTipeReksaDana;
    IBOutlet UILabel *pilihReksaDana;
    IBOutlet UILabel *labelJumlahOrang;

    
    NSString *tipeReksadana;
    NSInteger jumlahorang;
    NSInteger angkainflasi;
    NSInteger slideBiayaTransport;
    NSInteger biayaTransport;
    NSInteger slideBiayaAkomodasi;
    NSInteger biayaAkomodasi;
    NSInteger slideKebutuhanLainnya;
    NSInteger kebutuhanLainnya;
    
}

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSString *nowdate;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property (nonatomic, strong) IBOutlet UIImageView *konservatif;
@property (nonatomic, strong) IBOutlet UIImageView *moderat;
@property (nonatomic, strong) IBOutlet UIImageView *agresif;


-(IBAction)pickDate:(id)sender;


@end
