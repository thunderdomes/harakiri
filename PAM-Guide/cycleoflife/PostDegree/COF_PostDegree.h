//
//  COFKendaraan.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface COF_PostDegree : UIViewController <CKCalendarDelegate,UIGestureRecognizerDelegate> {
    IBOutlet UISegmentedControl *Segment;
    IBOutlet UITextField *ticketFlight;
    IBOutlet UITextField *accomodation;
    IBOutlet UITextField *others;
    IBOutlet UISlider *sliderTingkatInflasi;
    IBOutlet UISlider *sliderBiaya;
    IBOutlet UISlider *sliderBiayaTransport;
    IBOutlet UISlider *sliderBiayaAkomodasi;
    IBOutlet UISlider *sliderJumlahSemester;
    IBOutlet UISlider *sliderBiayaSemester;
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
    NSString *valuetosave;
    NSInteger biayauangpangkal;
    NSInteger angkainflasi;
    NSInteger slideBiayaSemester;
    NSInteger biayaSemester;
    NSInteger slideBiayaAkomodasi;
    NSInteger jumlahsemester;
    NSInteger slideUangPangkal;
    NSInteger kebutuhanLainnya;
    
}

@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSString *nowdate;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih;
@property(nonatomic, strong) IBOutlet UILabel *tanggaldipilih2;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, strong) NSArray *disabledDates;
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
