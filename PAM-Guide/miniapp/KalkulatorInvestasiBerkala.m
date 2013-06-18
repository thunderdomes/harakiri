//
//  KalkulatorKebutuhanInvestasi.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/17/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "KalkulatorInvestasiBerkala.h"

@interface KalkulatorInvestasiBerkala ()

@end

@implementation KalkulatorInvestasiBerkala

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *minImage = [UIImage imageNamed:@"pam-ipad-investor-slider1-296.png"];
    UIImage *maxImage = [UIImage imageNamed:@"pam-ipad-investor-slider-296.png"];
    
    
    minImage=[minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    maxImage=[maxImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    
    // Setup the FX slider
    [sliderTingkatInflasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [sliderTingkatInflasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    
    [sliderReturnInvestasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [sliderReturnInvestasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderchange:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    switch ([(UISlider*)sender tag]) {
        case 1:
            labelTingkatInflasi.text = [NSString stringWithFormat:@"%d %%", [slidevalue intValue]];
            break;
        case 2:
            labelReturnInvestasi.text = [NSString stringWithFormat:@"%d %%", [slidevalue intValue]];
            break;
            
    }
    
    ((UISlider*)sender).value = [slidevalue intValue];
}

- (IBAction)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}

- (IBAction)hitung:(id)sender
{
    
    NSString *targetInvestasi = teksTargetNilaInvestasi.text;
    NSString *jangkawaktu = teksJangkaWaktu.text;
    CGFloat strFloat = (CGFloat)[jangkawaktu floatValue];
    CGFloat strTargetInvestasi = (CGFloat)[targetInvestasi floatValue];
    float slidetingkatinvestasiplussatu= 1 + [sliderTingkatInflasi value] /100;
    float slidereturninvestasiplussatu = 1 + [sliderReturnInvestasi value] /100;
    
    float targetinvestasiakhir = pow(slidetingkatinvestasiplussatu,strFloat) * strTargetInvestasi;
    
  //hitung investasi pertahun
    float part2 = (pow(slidereturninvestasiplussatu,strFloat)-1);
    float part3 = (part2/[sliderReturnInvestasi value])*slidereturninvestasiplussatu;
    
    //float hasilinvestasipertahun = targetinvestasiakhir/((pow(slidereturninvestasiplussatu,strFloat)-1)/([sliderReturnInvestasi value]*slidereturninvestasiplussatu));
    float hasilinvestasipertahun = (targetinvestasiakhir/part3)/100;
    
    //hitung investasi per semester
    float strfloatM2 = strFloat*2;
    float slidediv2 = ([sliderReturnInvestasi value]/100)/2;
    float part4 = 1 + slidediv2;
    float part5 = (pow(part4,strfloatM2)-1); //OK
    float part6 = part5/slidediv2*part4;

    NSLog(@"part 4,5 %f %f %f ",part4,part5,part6);
                    
    float hasilinvestasipersemester = targetinvestasiakhir/part6;
    
    //hitung investasi per kuartal
    float strfloatM4 = strFloat*4;
    float slidediv4 = ([sliderReturnInvestasi value]/100)/4;
    float part7 = 1 + slidediv4;
    float part8 = (pow(part7,strfloatM4)-1); //OK
    float part9 = part8/slidediv4*part7;
    float hasilinvestasiperkuartal = targetinvestasiakhir/part9;
    
    //hitung investasi per bulan
    float strfloatM12 = strFloat*12;
    float slidediv12 = ([sliderReturnInvestasi value]/100)/12;
    float part10 = 1 + slidediv12;
    float part11 = (pow(part10,strfloatM12)-1); //OK
    float part12 = part11/slidediv12*part10;
    
    float hasilinvestasiperbulan = targetinvestasiakhir/part12;
 
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:3];

    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:targetinvestasiakhir]];
    hasilInvestasiAkhir.text = numberAsString;
    
    NSString *numberAsString2 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:hasilinvestasipertahun]]; 
    nilaiInvestasiPerTahun.text = numberAsString2;//pertahun
    
    NSString *numberAsString3 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:hasilinvestasipersemester]];
    nilaiInvestasiPerSemester.text = numberAsString3; //persemester
    
    NSString *numberAsString4 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:hasilinvestasiperkuartal]];
    nilaiInvestasiPerKuartal.text = numberAsString4; //perkuartal
    
    NSString *numberAsString5 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:hasilinvestasiperbulan]];
    nilaiInvestasiPerBulan.text = numberAsString5; //perbulan
    

    
    
    
}

@end
