//
//  Login.h
//  PAM-Guide
//
//  Created by Dave Harry on 4/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@interface LoginMitra : UIViewController <ASIHTTPRequestDelegate>{
    IBOutlet UITextField *usernametosend;
    IBOutlet UITextField *passwordtosend;
    
}

@property (nonatomic, strong) IBOutlet UIViewController *subv;

@end
