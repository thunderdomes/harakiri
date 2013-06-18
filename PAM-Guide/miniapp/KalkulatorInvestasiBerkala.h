//
//  KalkulatorKebutuhanInvestasi.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/17/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "ViewController.h"

@interface KalkulatorInvestasiBerkala : ViewController
{
    IBOutlet UILabel *labelTingkatInflasi;
    IBOutlet UILabel *labelReturnInvestasi;
    
    IBOutlet UILabel *hasilInvestasiAkhir;
    IBOutlet UILabel *nilaiInvestasiPerTahun;
    IBOutlet UILabel *nilaiInvestasiPerSemester;
    IBOutlet UILabel *nilaiInvestasiPerKuartal;
    IBOutlet UILabel *nilaiInvestasiPerBulan;
    
    IBOutlet UISlider *sliderTingkatInflasi;
    IBOutlet UISlider *sliderReturnInvestasi;
    IBOutlet UITextField *teksTargetNilaInvestasi;
    IBOutlet UITextField *teksJangkaWaktu;

}

@end
