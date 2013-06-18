//
//  TopUp.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/12/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "SBJson.h"

@interface TopUp : UIViewController<NIDropDownDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate>
{
    NSMutableArray *fundname;
    NSArray *custodianid;
    NSArray *bank;
    NSArray *noRek;
    NSArray *atasNama;
    NSArray *listAcc;
    NIDropDown *dropDown;
    NSDictionary *json;
    NSString *fundCode;
    
    IBOutlet UIButton *button;
	IBOutlet UIButton *upload;
    IBOutlet UIImageView *image;
	UIImagePickerController *imgPicker;
     IBOutlet UIImageView *img;
    UIPopoverController *popoverController;
    IBOutlet UIButton *yourBtn;
    
   

}

@property (nonatomic,retain) NSString *sessionID;
@property (nonatomic,retain) NSString *namaNasabah;
@property (nonatomic,retain) IBOutlet UILabel *labelNamaNasabah;
@property (nonatomic,retain) IBOutlet UILabel *labelNoRekening;
@property (nonatomic,retain) IBOutlet UILabel *labelNamaBank;
@property (nonatomic,retain) IBOutlet UILabel *labelCustAcc;
@property (nonatomic,retain) IBOutlet UILabel *labelCustName;
@property (nonatomic,retain) IBOutlet NIDropDown *dropDown;
@property (nonatomic,retain) NSString *responseString1;
@property (nonatomic,retain) NSString *responseString2;
//@property (nonatomic, retain) UIImagePickerController *imgPicker;


@end
