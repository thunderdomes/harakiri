//
//  FundFactSheet.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/2/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnduhForm : UIViewController <UIDocumentInteractionControllerDelegate> {
    
    IBOutlet UIScrollView *group1;
    IBOutlet UIScrollView *group2;
    IBOutlet UIScrollView *group3;
    IBOutlet UIScrollView *group4;
    IBOutlet UIScrollView *group5;
    
    IBOutlet UITextField  *amount;
    IBOutlet UIButton *buttonRedempt;
    IBOutlet UIButton *buttonSwitching;
}

@property (nonatomic,retain) NSString *sessionID;
@property (nonatomic,retain) NSString *fundCode;
@property (nonatomic,retain) NSString *amountType;
@property (nonatomic,retain) NSString *amountText;
@property (nonatomic,retain) NSString *fromFund;
@property (nonatomic,retain) NSString *toFund;



@end
