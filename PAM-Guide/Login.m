//
//  Login.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "Login.h"
#import "NasabahView.h"
#import "KeychainItemWrapper.h"
#import "Reachability.h"



@interface Login ()

@end

@implementation Login
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

- (IBAction)gotoNasabahView:(id)sender{
   
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
             KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"AppLogin" accessGroup:nil];
             
             [keychainItem setObject:usernametosend.text forKey:(__bridge id)(kSecValueData)];
             [keychainItem setObject:passwordtosend.text forKey:(__bridge id)(kSecAttrAccount)];
             
             NSString *username = [keychainItem objectForKey:(__bridge id)(kSecValueData)];
             NSString *password = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
          
             if ([username isEqualToString:usernametosend.text] || [password isEqualToString:passwordtosend.text])
             {
                 NasabahView *nasabah = [[NasabahView alloc]initWithNibName:@"NasabahView" bundle:nil];
                 self.subv = nasabah;

             }
                 
                                                                      
         }else
         {
          
             NasabahView *nasabah = [[NasabahView alloc]initWithNibName:@"NasabahView" bundle:nil];
             self.subv = nasabah;
             
             nasabah.username = usernametosend.text;
             nasabah.password = passwordtosend.text;
             
         }
         

//        NasabahView *nasabah = [[NasabahView alloc]initWithNibName:@"NasabahView" bundle:nil];
//        self.subv = nasabah;
//        
//        nasabah.username = usernametosend.text;
//        nasabah.password = passwordtosend.text;
        
        
        subv.view.center = self.view.center;
        [self.view addSubview:subv.view];
        
    }

[self.view endEditing:YES];   

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
