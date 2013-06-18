//
//  KalkulatorHasilInvestasi.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/26/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "KalkulatorHasilInvestasi.h"

@interface KalkulatorHasilInvestasi ()

@end

@implementation KalkulatorHasilInvestasi

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
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hitung:(id)sender
{
    
    NSString *nilaiInvestasi = teksNilaiInvestasi.text;
    NSString *jangkawaktu = teksJangkaWaktu.text;
    CGFloat strFloat = (CGFloat)[jangkawaktu floatValue];
    CGFloat strnilaInvestasi = (CGFloat)[nilaiInvestasi floatValue];
    float slidetingkatinvestasiplussatu= 1 + [sliderTingkatInflasi value] /100;
    
    float perkiraaninvestasiakhir = pow(slidetingkatinvestasiplussatu,strFloat) * strnilaInvestasi;
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:perkiraaninvestasiakhir]];
    
    perkiraanHasilInvestasi.text = numberAsString;
    
    
}

-(IBAction)sliderchange:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    

    labelTingkatInflasi.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
    

    ((UISlider*)sender).value = [slidevalue intValue];
}

- (IBAction)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
    
}


@end
