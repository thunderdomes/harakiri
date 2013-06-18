//
//  FundFactSheet.h
//  PAM-Guide
//
//  Created by Dave Harry on 5/2/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundFactSheet : UIViewController <UIDocumentInteractionControllerDelegate> {
    NSString *linkURL;
    NSString *openURL;
    NSMutableDictionary *observers;

}

@property (nonatomic,retain) NSString *sessionID;

@end
