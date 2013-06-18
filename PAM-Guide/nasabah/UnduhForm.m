//
//  FundFactSheet.m
//  PAM-Guide
//
//  Created by Dave Harry on 5/2/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "UnduhForm.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "VCRadioButton.h"
#import "DZWebBrowser.h"

#define kGroup1Name @"group1"
#define kGroup2Name @"group2"
#define kGroup2Name @"group3"
#define kGroup2Name @"group4"
#define kGroup2Name @"group5"
#define kObserver @"vcRadioButtonItemFromGroupSelected"

@interface UnduhForm ()

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;

@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton1;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton2;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton3;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton4;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton5;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton6;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton7;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton8;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton9;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton10;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton11;
@property (weak, nonatomic) IBOutlet VCRadioButton *nogroupRadioButton1;
@property (weak, nonatomic) IBOutlet VCRadioButton *nogroupRadioButton2;
@property (weak, nonatomic) IBOutlet VCRadioButton *nogroupRadioButton3;



@end

@implementation UnduhForm


@synthesize sessionID,fundCode,amountType,amountText,fromFund,toFund;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    group1.hidden = YES;
    group2.hidden = YES;
    group3.hidden = YES;
    group4.hidden = YES;
    group5.hidden = YES;
    buttonRedempt.hidden = YES;
    buttonSwitching.hidden = YES;
    
    
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)downloadPDF:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    

    NSURL *URL;
    
    switch ([(UIButton*)sender tag]) {
        case 1: URL = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin%20Dana%20Prima%202013-03.pdf.pdf"];
            break;
        case 2: URL = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/bersama_Maret%202013.pdf"];
            break;

    }
   //NSURL *URL = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin%20Dana%20Prima%202013-03.pdf.pdf"];
    
    if (URL) {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Present Open In Menu
        [self.documentInteractionController presentOpenInMenuFromRect:[button frame] inView:self.view animated:YES];
    }
}


- (void)requestFinished:(ASIFormDataRequest *)request
{
    
    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    NSData *responseData = [request responseData];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
   
    
    //NSLog(@"headers: %@", [request responseHeaders]);
    //NSLog(@"headers1: %@", [[request requestHeaders]description]);
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"link"])
    {
    NSString *link = [json valueForKeyPath:@"FormReedemLink"];
    
    NSString *linkURL = [link stringByReplacingOccurrencesOfString:@"&#47;"
                                                        withString:@"/"];
    NSLog(@"link:%@",linkURL);
    
    //SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:linkURL];
    //[self presentModalViewController:browser animated:YES];
    
    NSURL *URL = [[NSURL alloc] initWithString:[linkURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    DZWebBrowser *webBrowser = [[DZWebBrowser alloc] initWebBrowserWithURL:URL];
    
    webBrowser.showProgress = YES;
    webBrowser.allowSharing = NO;
    webBrowser.resourceBundleName = @"custom-controls";
    
    UINavigationController *webBrowserNC = [[UINavigationController alloc] initWithRootViewController:webBrowser];
    
    [self presentViewController:webBrowserNC animated:YES completion:NULL];
    }
    
    else{
        NSString *link = [json valueForKeyPath:@"FormSwitchingLink"];
        
        NSString *linkURL = [link stringByReplacingOccurrencesOfString:@"&#47;"
                                                            withString:@"/"];
        NSLog(@"link:%@",linkURL);
        
        //SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:linkURL];
        //[self presentModalViewController:browser animated:YES];
        
        NSURL *URL = [[NSURL alloc] initWithString:[linkURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        
        DZWebBrowser *webBrowser = [[DZWebBrowser alloc] initWebBrowserWithURL:URL];
        
        webBrowser.showProgress = YES;
        webBrowser.allowSharing = NO;
        webBrowser.resourceBundleName = @"custom-controls";
        
        UINavigationController *webBrowserNC = [[UINavigationController alloc] initWithRootViewController:webBrowser];
        
        [self presentViewController:webBrowserNC animated:YES completion:NULL];

    }
    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    //NSLog(@"error");
    NSError *error = [request error];
    NSLog(@"error:%@",error.description);

}


- (IBAction)back:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}


- (IBAction)formRedemption:(id)sender{
    
    group1.hidden = NO;
    group2.hidden = NO;
    group3.hidden = YES;
    group4.hidden = YES;
    buttonRedempt.hidden = NO;
    buttonSwitching.hidden = YES;
    
    // block of code to execute on selection and deselection
    RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
        if
            (radioButton.groupName) {
            NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                  radioButton.groupName,
                  (radioButton.selected)? @"selected" : @"deselected",
                  radioButton.selectedValue);
        fundCode = radioButton.selectedValue;
        }
        
        else
        {
            NSLog(@"RadioButton with value of:%@ was:%@",
                  radioButton.selectedValue,
                  (radioButton.selected)? @"selected" : @"deselected");
            amountType = radioButton.selectedValue;
        }
    };
    
    // assign the selection block to each radio button
    self.group1RadioButton1.selectionBlock = selectionBlock;
    self.group1RadioButton2.selectionBlock = selectionBlock;
    self.group1RadioButton3.selectionBlock = selectionBlock;
    self.group1RadioButton4.selectionBlock = selectionBlock;
    self.group1RadioButton5.selectionBlock = selectionBlock;
    self.group1RadioButton6.selectionBlock = selectionBlock;
    self.group1RadioButton7.selectionBlock = selectionBlock;
    self.group1RadioButton8.selectionBlock = selectionBlock;
    self.group1RadioButton9.selectionBlock = selectionBlock;
    self.group1RadioButton10.selectionBlock = selectionBlock;
    self.group1RadioButton11.selectionBlock = selectionBlock;
    
    self.nogroupRadioButton1.selectionBlock = selectionBlock;
    self.nogroupRadioButton2.selectionBlock = selectionBlock;
    self.nogroupRadioButton3.selectionBlock = selectionBlock;
    
    // this code below is used to tell a set of radio buttons they are in the same group
    // group names
    self.group1RadioButton1.groupName = kGroup1Name;
    self.group1RadioButton2.groupName = kGroup1Name;
    self.group1RadioButton3.groupName = kGroup1Name;
    self.group1RadioButton4.groupName = kGroup1Name;
    self.group1RadioButton5.groupName = kGroup1Name;
    self.group1RadioButton6.groupName = kGroup1Name;
    self.group1RadioButton7.groupName = kGroup1Name;
    self.group1RadioButton8.groupName = kGroup1Name;
    self.group1RadioButton9.groupName = kGroup1Name;
    self.group1RadioButton10.groupName = kGroup1Name;
    self.group1RadioButton11.groupName = kGroup1Name;
    
//    self.group2RadioButton1.groupName = kGroup2Name;
//    self.group2RadioButton2.groupName = kGroup2Name;
//    self.group2RadioButton3.groupName = kGroup2Name;
    
    // this code below gives each radio button a selection value
    self.group1RadioButton1.selectedValue = @"1";
    self.group1RadioButton2.selectedValue = @"10";
    self.group1RadioButton3.selectedValue = @"15";
    self.group1RadioButton4.selectedValue = @"18";
    self.group1RadioButton5.selectedValue = @"19";
    self.group1RadioButton6.selectedValue = @"23";
    self.group1RadioButton7.selectedValue = @"44";
    self.group1RadioButton8.selectedValue = @"46";
    self.group1RadioButton9.selectedValue = @"47";
    self.group1RadioButton10.selectedValue = @"48";
    self.group1RadioButton11.selectedValue = @"49";
    
     self.nogroupRadioButton1.selectedValue = @"0";
     self.nogroupRadioButton2.selectedValue = @"1";
     self.nogroupRadioButton3.selectedValue = @"2";

}

- (IBAction)formSwitching:(id)sender{
    
    group1.hidden = YES;
    group2.hidden = NO;
    group3.hidden = NO;
    group4.hidden = NO;
    buttonRedempt.hidden = YES;
    buttonSwitching.hidden = NO;
    
    // block of code to execute on selection and deselection
    RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
        if
            (radioButton.groupName) {
                NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                      radioButton.groupName,
                      (radioButton.selected)? @"selected" : @"deselected",
                      radioButton.selectedValue);
                fundCode = radioButton.selectedValue;
            }
        
        else
        {
            NSLog(@"RadioButton with value of:%@ was:%@",
                  radioButton.selectedValue,
                  (radioButton.selected)? @"selected" : @"deselected");
            amountType = radioButton.selectedValue;
        }
    };
    
    // assign the selection block to each radio button
    self.group1RadioButton1.selectionBlock = selectionBlock;
    self.group1RadioButton2.selectionBlock = selectionBlock;
    self.group1RadioButton3.selectionBlock = selectionBlock;
    self.group1RadioButton4.selectionBlock = selectionBlock;
    self.group1RadioButton5.selectionBlock = selectionBlock;
    self.group1RadioButton6.selectionBlock = selectionBlock;
    self.group1RadioButton7.selectionBlock = selectionBlock;
    self.group1RadioButton8.selectionBlock = selectionBlock;
    self.group1RadioButton9.selectionBlock = selectionBlock;
    self.group1RadioButton10.selectionBlock = selectionBlock;
    self.group1RadioButton11.selectionBlock = selectionBlock;
    
    self.nogroupRadioButton1.selectionBlock = selectionBlock;
    self.nogroupRadioButton2.selectionBlock = selectionBlock;
    self.nogroupRadioButton3.selectionBlock = selectionBlock;
    
    // this code below is used to tell a set of radio buttons they are in the same group
    // group names
    self.group1RadioButton1.groupName = kGroup1Name;
    self.group1RadioButton2.groupName = kGroup1Name;
    self.group1RadioButton3.groupName = kGroup1Name;
    self.group1RadioButton4.groupName = kGroup1Name;
    self.group1RadioButton5.groupName = kGroup1Name;
    self.group1RadioButton6.groupName = kGroup1Name;
    self.group1RadioButton7.groupName = kGroup1Name;
    self.group1RadioButton8.groupName = kGroup1Name;
    self.group1RadioButton9.groupName = kGroup1Name;
    self.group1RadioButton10.groupName = kGroup1Name;
    self.group1RadioButton11.groupName = kGroup1Name;
    
    //    self.group2RadioButton1.groupName = kGroup2Name;
    //    self.group2RadioButton2.groupName = kGroup2Name;
    //    self.group2RadioButton3.groupName = kGroup2Name;
    
    // this code below gives each radio button a selection value
    self.group1RadioButton1.selectedValue = @"1";
    self.group1RadioButton2.selectedValue = @"10";
    self.group1RadioButton3.selectedValue = @"15";
    self.group1RadioButton4.selectedValue = @"18";
    self.group1RadioButton5.selectedValue = @"19";
    self.group1RadioButton6.selectedValue = @"23";
    self.group1RadioButton7.selectedValue = @"44";
    self.group1RadioButton8.selectedValue = @"46";
    self.group1RadioButton9.selectedValue = @"47";
    self.group1RadioButton10.selectedValue = @"48";
    self.group1RadioButton11.selectedValue = @"49";
    
    self.nogroupRadioButton1.selectedValue = @"0";
    self.nogroupRadioButton2.selectedValue = @"1";
    self.nogroupRadioButton3.selectedValue = @"2";
    
}


- (IBAction)submitForm:(id)sender{
    

    if ([amountType isEqual: @"0"]) amountText = @"0";
    else  amountText = amount.text;

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonFormReedem.aspx"]];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setPostValue:fundCode forKey:@"fund"];
    [request setPostValue:amountType forKey:@"amountype"];
    [request setPostValue:amountText forKey:@"amount"];
    NSLog(@"yang dikirim:%@,%@,%@,%@",sessionID,fundCode,amountType,amountText);
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    request.userInfo = [NSDictionary dictionaryWithObject:@"link" forKey:@"type"];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (IBAction)submitFormSwitching:(id)sender{
    
    
    if ([amountType isEqual: @"0"]) amountText = @"0";
    else  amountText = amount.text;
    
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonFormSwitching.aspx"]];
    
    ASIFormDataRequest *request2 = [ASIFormDataRequest requestWithURL:url2];
    
    
    [request2 setPostValue:sessionID forKey:@"sessionid"];
    [request2 setPostValue:@"1" forKey:@"fromfund"];
    [request2 setPostValue:@"15" forKey:@"tofund"];
    [request2 setPostValue:amountType forKey:@"amountype"];
    [request2 setPostValue:amountText forKey:@"amount"];
    [request2 setRequestMethod:@"POST"];
    [request2 addRequestHeader:@"Accept" value:@"application/json"];
    [request2 addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request2 setDelegate:self];
    [request2 startAsynchronous];
}

@end
