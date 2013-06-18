//
//  KalkulatorKebutuhanInvestasi.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/17/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "ViewController.h"
#import "AFPickerView.h"
#import "CKCalendarView.h"
#import "NIDropDown.h"

@interface SimulasiBerkala : ViewController <AFPickerViewDataSource,AFPickerViewDelegate,CKCalendarDelegate,NIDropDownDelegate>
{
    
    AFPickerView *tipeReksaDanaPicker;
    NSArray *listReksaDana;
    NSString *ftype;
    NSString *fvalue;
    NSString *fvaluestring;
    NSString *tipeReksaDana;
    
    IBOutlet UILabel *labelTingkatInflasi;
    IBOutlet UILabel *labelReturnInvestasi;
    
    IBOutlet UILabel *hasilInvestasiAkhir;
    IBOutlet UILabel *hasilInvestasiSaatIni;
    
    IBOutlet UITextField *teksTargetNilaInvestasi;
    IBOutlet UITextField *teksJangkaWaktu;
    NIDropDown *dropDown;
    

}

@property (strong, nonatomic) IBOutlet UILabel *tipeLabel;
@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;
@property(nonatomic, strong) NSString *strTanggalFrom;
@property(nonatomic, strong) NSString *strTanggalTo;
@property(nonatomic, strong) NSString *tanggal;
@property(nonatomic, strong) NSString *strTanggalNAB;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) IBOutlet UILabel *tanggalFrom;
@property(nonatomic, strong) IBOutlet UILabel *tanggalTo;
@property(nonatomic, strong) IBOutlet UILabel *tanggalNAB;
@property(nonatomic, strong) IBOutlet UITextField *teksTanggalInvestasiBerkala;
@property(nonatomic, strong) IBOutlet UITextField *teksJumlahInvestasi;
@property (nonatomic,retain) NSString *sessionID;


@property(nonatomic, strong) IBOutlet UILabel *labelNominalInvestasi;
@property(nonatomic, strong) IBOutlet UILabel *labelTipeReksaDana;
@property(nonatomic, strong) IBOutlet UILabel *labelPeriode;
@property(nonatomic, strong) IBOutlet UILabel *labelTotalInvestasi;
@property(nonatomic, strong) IBOutlet UILabel *labelNilaiPasarInvestasi;
@property(nonatomic, strong) IBOutlet UILabel *labelKeuntungan;
@property (nonatomic, retain) IBOutlet NIDropDown *dropdown;

@end
