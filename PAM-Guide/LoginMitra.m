//
//  Login.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "LoginMitra.h"
#import "MitraView.h"
#import "Reachability.h"
#import "KeychainItemWrapper.h"

@interface LoginMitra ()

@end

@implementation LoginMitra
@synthesize subv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(back)
                                                     name:@"back"
                                                   object:nil];

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

- (IBAction)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}

- (IBAction)gotoMitraView:(id)sender{
   
        //    CGRect r = [subv.view frame];
    //    r.origin.x = 0;
    //    r.origin.y = 0;
    //    [subv.view setFrame:r];
    
    if(([usernametosend.text isEqualToString:@""] || passwordtosend.text== nil )) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Anda Belum Memasukkan Username/Password!" delegate:self
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    else{
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        
        if (networkStatus == NotReachable)
        {
            KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MitraLogin" accessGroup:nil];
            
            [keychainItem setObject:usernametosend.text forKey:(__bridge id)(kSecValueData)];
            [keychainItem setObject:passwordtosend.text forKey:(__bridge id)(kSecAttrAccount)];
            
            NSString *username = [keychainItem objectForKey:(__bridge id)(kSecValueData)];
            NSString *password = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
            
            if ([username isEqualToString:usernametosend.text] || [password isEqualToString:passwordtosend.text])
            {
                MitraView *mitra = [[MitraView alloc]initWithNibName:@"MitraView" bundle:nil];
                self.subv = mitra;

            }
        }
            else{
                
                MitraView *mitra = [[MitraView alloc]initWithNibName:@"MitraView" bundle:nil];
                self.subv = mitra;
                mitra.username = usernametosend.text;
                mitra.password = passwordtosend.text;
                subv.view.center = self.view.center;
                [self.view addSubview:subv.view];

            }
        }
        
    subv.view.center = self.view.center;
    [self.view addSubview:subv.view];
        
    [self.view endEditing:YES];   

    

    
//    self.subv = [[NasabahView alloc]initWithNibName:@"NasabahView" bundle:nil];
//    subv.view.center = self.view.center;
////    CGRect r = [subv.view frame];
////    r.origin.x = 0;
////    r.origin.y = 0;
////    [subv.view setFrame:r];
//     subv.view.center = self.view.center;
//     [self.view addSubview:subv.view];
//    
// 
   

}

- (void)requestFinished:(ASIFormDataRequest *)request
{
    NSString *responseString = [request responseString];
    //NSLog(@"hasil response :%@",responseString);
    
    
    NSData *responseData = [request responseData];
    
     //NSLog(@"headers: %@", [request responseHeaders]);
     //NSLog(@"headers1: %@", [[request requestHeaders]description]);
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    //your code here
    return YES;
}

@end
