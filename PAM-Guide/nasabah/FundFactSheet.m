//
//  FundFactSheet.m
//  PAM-Guide
//
//  Created by Dave Harry on 5/2/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "FundFactSheet.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SVModalWebViewController.h"
#import "DZWebBrowser.h"
#import "PBWebViewController.h"

#define kObserver @"vcRadioButtonItemFromGroupSelected"


@interface FundFactSheet ()
{
    int i;
}
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;


@end

@implementation FundFactSheet


@synthesize sessionID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [super addObserver:observer forKeyPath:@"vcRadioButtonItemFromGroupSelected" options:options context:context];
    [observers setValue:observer forKey:keyPath];
}

- (void)removeObserver:(NSObject*)observer forKeyPath:(NSString*)keyPath
{
    [super removeObserver:observer forKeyPath:@"vcRadioButtonItemFromGroupSelected"];
    [observers removeObjectForKey:keyPath];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonFFS.aspx"]];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    
//    
//    [request setPostValue:sessionID forKey:@"sessionid"];
//    [request setRequestMethod:@"POST"];
//    [request addRequestHeader:@"Accept" value:@"application/json"];
//    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
//    
//    
//    [request setDelegate:self];
//    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)download:(id)sender{
    
    i = [(UIButton*)sender tag];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonFFS.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];

}
-(IBAction)downloadPDF:(id)sender{
    
    UIButton *button = (UIButton *)sender;

    NSURL *url;
    
    switch ([(UIButton*)sender tag]) {
        case 1: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/bersama_Maret 2013.pdf"];//[NSURL URLWithString:@"https://panin-am.co.id/Resources/FFS/maksima_new_Maret 2013.pdf"];
            //openURL =[NSString stringWithFormat:@"https://panin-am.co.id/Resources/FFS/maksima_new_Maret 2013.pdf"];
            break;
        case 2: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/bersama_Maret 2013.pdf"];
            break;
        case 3: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/bersamaplus_new_Maret 2013.pdf"];
            break;
        case 4: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Gebyar Indonesia 2 - Mar 2013.pdf"];
            break;
        case 5: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Dana Syariah Saham 13-03.pdf"];
            break;
        case 6: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Dana Syariah Berimbang 13-03.pdf"];
            break;
        case 7: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Dana Unggulan - Mar 2013 (1).pdf"];
            break;
        case 8: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Dana Prima 2013-03.pdf.pdf"];
            break;
        case 9: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/USD Maret.pdf"];
            break;
        case 10: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Dana Prioritas - March 2013.pdf"];
            break;
        case 11: url = [NSURL fileURLWithPath:@"https://www.panin-am.co.id/Resources/FFS/Panin Dana Likuid - March 2013.pdf"];
            break;
            
//            SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:url];
//            [self presentModalViewController:browser animated:YES];
//            NSLog(@"link: %@",linkURL);
            
                   NSURL *URL = [NSURL URLWithString:linkURL];
           
                   DZWebBrowser *webBrowser = [[DZWebBrowser alloc] initWebBrowserWithURL:URL];
            
            
                   webBrowser.showProgress = YES;
                    webBrowser.allowSharing = YES;
                   webBrowser.resourceBundleName = @"custom-controls";
           
                  UINavigationController *webBrowserNC = [[UINavigationController alloc] initWithRootViewController:webBrowser];
           
                  [self presentViewController:webBrowserNC animated:YES completion:NULL];
         
    }
   /*
    if (url) {
//        // Initialize Document Interaction Controller
//        
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
//
//        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Present Open In Menu
        
       [self.documentInteractionController presentOpenInMenuFromRect:[button frame] inView:self.view animated:YES];
        
//        NSString *newAddress = [[NSString alloc]initWithFormat:@"%@",url];
//        
//        SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:newAddress];
//        [self presentModalViewController:browser animated:YES];
//        NSLog(@"link: %@",linkURL);
       
    }

    */
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
 
    
   //NSString *link = [json valueForKeyPath:@"ListFFS.fileNameID"];
    NSString *templink = [[[json valueForKeyPath:@"ListFFS"] objectAtIndex:i] valueForKeyPath:@"fileNameID"];
//    NSLog(@"link ke 1:%@",templink);
    
    NSString *templinkURL = [templink stringByReplacingOccurrencesOfString:@"&#47;"
                                                             withString:@"/"];
    
    linkURL = [templinkURL stringByReplacingOccurrencesOfString:@"&#32;"
                                                  withString:@" "];
//
//    SVModalWebViewController *browser = [[SVModalWebViewController alloc] initWithAddress:linkURL];
//    [self presentModalViewController:browser animated:YES];
//    NSLog(@"link:%@",linkURL);
    
    
  NSURL *URL = [[NSURL alloc] initWithString:[linkURL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    DZWebBrowser *webBrowser = [[DZWebBrowser alloc] initWebBrowserWithURL:URL];
    
    webBrowser.showProgress = YES;
    webBrowser.allowSharing = NO;
    webBrowser.resourceBundleName = @"custom-controls";
    
    UINavigationController *webBrowserNC = [[UINavigationController alloc] initWithRootViewController:webBrowser];
    
    [self presentViewController:webBrowserNC animated:YES completion:NULL];


}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}


- (IBAction)back:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}
@end
