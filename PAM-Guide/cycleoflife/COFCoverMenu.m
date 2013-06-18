//
//  COFCoverMenu.m
//  PAM-Guide
//
//  Created by Panin Sekuritas 2 on 5/30/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "COFCoverMenu.h"
#import "SubClassHajj.h"
#import "SubClassHoliday.h"
#import "SubClassEntrepreneur.h"
#import "SubClassRumah.h"
#import "SubClassPostDegree.h"
#import "SubClassMarried.h"
#import "SubClassHoliday.h"
#import "SubClassKendaraan.h"
#import "SubClassPensiun.h"
#import "SubClassPendidikan.h"


@interface COFCoverMenu ()

@end

@implementation COFCoverMenu
@synthesize subv;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSubMenu:(id)sender
{
        switch ([(UIButton*)sender tag]){
            case 1:
                self.subv = [[SubClassHoliday alloc] initWithNibName:@"SubClassHoliday" bundle:nil] ;
                break;
            case 2:
                self.subv = [[SubClassEntrepreneur alloc] initWithNibName:@"SubClassEntrepreneur" bundle:nil] ;
                break;
            case 3:
                self.subv = [[SubClassRumah alloc] initWithNibName:@"SubClassRumah" bundle:nil] ;
                break;
            case 4:
                self.subv = [[SubClassPendidikan alloc] initWithNibName:@"SubClassPendidikan" bundle:nil] ;
                break;
            case 6:
               self.subv = [[SubClassHoliday alloc] initWithNibName:@"SubClassHoliday" bundle:nil] ;
                break;
            case 5:
                self.subv = [[SubClassHajj alloc] initWithNibName:@"SubClassHajj" bundle:nil] ;
                break;
            //case 6:
                //self.subv = [[Chapter_4_1_1 alloc] initWithNibName:@"Chapter_4_1_6_ipad" bundle:nil] ;
                //break;
            case 7:
                self.subv = [[SubClassPostDegree alloc] initWithNibName:@"SubClassPostDegree" bundle:nil] ;
                break;
            case 8:
                self.subv = [[SubClassMarried alloc] initWithNibName:@"SubClassMarried" bundle:nil] ;
                break;
            case 9:
                self.subv = [[SubClassKendaraan alloc] initWithNibName:@"SubClassKendaraan" bundle:nil] ;
                break;
            case 10:
                self.subv = [[SubClassPensiun alloc] initWithNibName:@"SubClassPensiun" bundle:nil] ;
                break;
            default:
                self.subv = nil;
                break;
        }
//fader.hidden = NO;
//[[NSNotificationCenter defaultCenter] postNotificationName:@"photoshow" object:self];
//[[NSNotificationCenter defaultCenter] postNotificationName:@"hidepager" object:self]; remove by request
//[self presentPopupViewController:subv animationType:MJPopupViewAnimationFade];
//    subv.view.center = self.view.center;
//    [self.view addSubview:subv.view];

//    CGFloat parentWidth = self.view.bounds.size.width;
//    CGRect frame = CGRectMake(floor((parentWidth - 1024)/2),
//                              0,
//                              1024,
//                              768);
//    subv.view.frame = frame;

    [self.view addSubview:subv.view];
}

- (IBAction)back:(id)sender{
    [self.view removeFromSuperview];
}

@end
