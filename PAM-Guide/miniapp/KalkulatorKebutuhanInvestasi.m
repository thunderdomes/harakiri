//
//  KalkulatorKebutuhanInvestasi.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/17/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "KalkulatorKebutuhanInvestasi.h"

@interface KalkulatorKebutuhanInvestasi ()

@end

@implementation KalkulatorKebutuhanInvestasi

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
            labelTingkatInflasi.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
        case 2:
            labelReturnInvestasi.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
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
    
    
    float hasilinvestasisaatini = targetinvestasiakhir/pow(slidereturninvestasiplussatu,strFloat);
    NSLog(@"hasil investasi saat ini %f",hasilinvestasisaatini);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];

    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:targetinvestasiakhir]];

    hasilInvestasiAkhir.text = numberAsString;
    

    NSString *numberAsString2 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:hasilinvestasisaatini]];
    
    hasilInvestasiSaatIni.text = numberAsString2;
        
    
}

@end
