//
//  FundFactSheet.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/2/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kObserver @"vcRadioButtonItemFromGroupSelected"

@interface AutoDebet : UIViewController <UIDocumentInteractionControllerDelegate> {
    NSString *linkURL;
    IBOutlet UILabel *label;
    IBOutlet UIScrollView *scroll;
     NSMutableDictionary *observers;
    
}

@property (nonatomic,retain) NSString *sessionID;

@end
