//
//  TopUp.m
//  PAM-Guide
//
//  Created by Dave Harry on 5/12/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "TopUp.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NIDropDown.h"
#import "AppDelegate.h"


@interface TopUp ()
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;

@end

@implementation TopUp
@synthesize labelNamaNasabah,namaNasabah,sessionID,dropDown,labelNoRekening,labelNamaBank,responseString1,responseString2,labelCustAcc,labelCustName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateCustodianLabel)
                                                     name:@"updatecustodianlabel"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateBankAccount)
                                                     name:@"updatelistbankaccount"
                                                   object:nil];

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    labelNamaNasabah.text = namaNasabah;
    
    //[self fundAndAcc];
   // [self customerAcc];
    [self httpRequest];
    
    
}
-(void)httpRequest
{
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonFundAndAccount.aspx"]];
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonCustomerAccount.aspx"]];

   
    ASIFormDataRequest *request1 = [ASIFormDataRequest requestWithURL:url1];
    
    [request1 setPostValue:sessionID forKey:@"sessionid"];
    [request1 setRequestMethod:@"POST"];
    [request1 addRequestHeader:@"Accept" value:@"application/json"];
    [request1 addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    

    [request1 setCompletionBlock:^{
        responseString1 = [request1 responseString];
        //[self checkIfBothRequestsComplete];
    }];
    request1.userInfo = [NSDictionary dictionaryWithObject:@"fundandaccount" forKey:@"type"];

    [request1 setDelegate:self];
    [request1 startAsynchronous];
    
    
    
                                
    ASIFormDataRequest *request2 = [ASIFormDataRequest requestWithURL:url2];
    [request2 setPostValue:sessionID forKey:@"sessionid"];
    
    [request2 setRequestMethod:@"POST"];
    [request2 addRequestHeader:@"Accept" value:@"application/json"];
    [request2 addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    


    [request2 setCompletionBlock:^{
        responseString2 = [request2 responseString];
        //[self checkIfBothRequestsComplete];
    }];
    [request2 setDelegate:self];
    request2.userInfo = [NSDictionary dictionaryWithObject:@"customeraccount" forKey:@"type"];
    [request2 startAsynchronous];

}

- (void)checkIfBothRequestsComplete
{
    if (self.responseString1 && self.responseString2) {
        
        fundname = [json valueForKeyPath:@"ListFundAccount.fundName"];
        custodianid = [json valueForKeyPath:@"ListFundAccount.custodianId"];
        bank = [json valueForKeyPath:@"ListCustAccount.Bank"];
        labelNamaBank.text = [bank objectAtIndex:0];
        NSLog(@"label:%@",labelNamaBank.text);
    }
    
}




- (void)requestFinished:(ASIFormDataRequest *)request
{

    NSString *responseString = [request responseString];
    NSLog(@"hasil response :%@",responseString);
    
    
    NSData *responseData = [request responseData];
    
    NSError* error;
    //NSDictionary
    json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"fundandaccount"]) {
        fundname = [json valueForKeyPath:@"ListFundAccount.fundName"];
        custodianid = [json valueForKeyPath:@"ListFundAccount.custodianId"];
    }
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"customeraccount"]) {
        bank = [json valueForKeyPath:@"ListCustAccount.Bank"];
        listAcc = [json valueForKeyPath:@"ListCustAccount.NoRekNama"];
        noRek = [json valueForKeyPath:@"ListCustAccount.NoRek"];
        atasNama = [json valueForKeyPath:@"ListCustAccount.AtasNama"];
        
//        labelNamaBank.text = [bank objectAtIndex:];
//        NSLog(@"label:%@",labelNamaBank.text);

    }


    
    //    for (int i=0;i<list.count;i++){
//        
//        NSDictionary *list = [[[json valueForKeyPath:@"ListFundAccount"] objectAtIndex:i] valueForKeyPath:@"custodianId"];
//       // NSLog(@"list ke 3:%@",list objectForKey:  }
}




- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}


- (IBAction)pilihTipeReksaDana:(id)sender

{
    
        
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :fundname :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
  
    

}

- (IBAction)pilihBankAccount:(id)sender

{
    
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :listAcc :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
        
}



- (void)updateCustodianLabel {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    appDelegate.arrayCustodianID = custodianid;
    labelNoRekening.text = appDelegate.custodianID;
     NSLog(@"di top up:%@",appDelegate.custodianID);


}
- (void)updateBankAccount {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    appDelegate.arrayCustodianID = custodianid;
    labelNamaBank.text = [bank objectAtIndex:appDelegate.index];
    labelCustAcc.text = [noRek objectAtIndex:appDelegate.index];
    labelCustName.text = [atasNama objectAtIndex:appDelegate.index];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

-(void)sendSessionID
{
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonTopUpOnline.aspx"]];
    
    
    ASIFormDataRequest *request_2 = [ASIFormDataRequest requestWithURL:url1];
    
    [request_2 setPostValue:sessionID forKey:@"sessionid"];
    [request_2 setRequestMethod:@"POST"];
    [request_2 addRequestHeader:@"Accept" value:@"application/json"];
    [request_2 addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    [request_2 setDelegate:self];
    [request_2 startAsynchronous];
    

    
}
- (IBAction)test

{
    
    
   // NSString *jsonString = @"{jsondetail={\"FundCode\":\"1\",\"TotalAmount\":1000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"}";

    NSError *error;
    NSHTTPURLResponse *responseCode = nil;
    
    NSDictionary* jsonDict = @{@"SessionID":@("2013052015272402215820239"),@"FundCode": @(1), @"TotalAmount":@(1000000), @"PaymentType":@(0), @"Bank":@"AAA BANK",@"BankAccountNo": @"123456789",@"Amount":@"1000000",
                               @"DepositFile":@"asset.PNG"};
    
    
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:&error];
    
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonTopUpOnline.aspx"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url1];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //NSURLResponse *response;
    NSHTTPURLResponse *response = nil;
    
    NSData *POSTReply =  [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:POSTReply options:kNilOptions error:nil] );
    
    

   // NSError *error = [[NSError alloc] init];
    
    

    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
        NSLog(@"%@",jsonData);
        NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            NSLog(@"Login SUCCESS");
            //  [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
            
        } else {
            
            NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
            //[self alertStatus:error_msg :@"Login Failed!"];
        }
        
    } else {
        if (error) NSLog(@"Error: %@", error);
        // [self alertStatus:@"Connection Failed" :@"Login Failed!"];
    }
}



- (IBAction)uploadImage {
    
    //[self sendSessionID];
    
    
    //NSString *jsonRequest = @"{\"username\":\"user\",\"password\":\"letmein\"}";
    
    //NSString *jsonRequest = @"{\"jsondetail\":[{\"SessionID\":\"2013052015272402215820239\",\"FundCode\":\"1\",\"TotalAmount\":1000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"}]}";
  
   NSString *jsonRequest = @"{\"jsondetail\":[{\"FundCode\":\"1\",\"TotalAmount\":1000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"},{\"FundCode\":\"1\",\"TotalAmount\":2000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"}]}";

    NSLog(@"Request: %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:@"http://www.panin-am.co.id:800/jsonTopUpOnline.aspx"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   // NSString *postString = @"sessionid=2013052015272402215820239";
    //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
  

    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
        NSLog(@"%@",jsonData);
        NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            NSLog(@"Login SUCCESS");
            //  [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
            
        } else {
            
            NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
            //[self alertStatus:error_msg :@"Login Failed!"];
        }
        
    } else {
        if (error) NSLog(@"Error: %@", error);
        // [self alertStatus:@"Connection Failed" :@"Login Failed!"];
    }
}

    
//    
//    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] initWithURL:url];
//    
//    //NSData *requestData1 = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
//    
//    [request1 setHTTPMethod:@"POST"];
//    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//     NSString *postString = @"sessionid=2013052015272402215820239";
//    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];

/*
	
   // NSDictionary *dict = @{@"jsondetail":@{@"SessionID":@"2013052015272402215820239",@"FundCode":@"1",@"TotalAmount":@"1000000",@"PaymentType":@"0",@"BankName":@"CIMB NIaga",@"BankAccountNo":@"123456789",@"BankAccountName":@"PT Panin Asset Management",@"Amount":@"1000000",@"DepositEvidenceFile":@"asset.PNG"}};
 
   NSString *post = [NSString stringWithFormat:@"SessionID=%@&FundCode=%@&TotalAmount=%@&PaymentType=%@&BankName=%@&BankAccountNo=%@&BankAccountName=%@Amount=%@&DepositEvidenceFile=%@",@"2013052015272402215820239",@"1",@"1000000",@"0",@"CIMB NIaga",@"123456789",@"PT Panin Asset Management",@"1000000",@"asset.PNG"];
    
      // NSString *post5 = [NSString stringWithFormat:@"jsondetail={"@"SessionID=%@&FundCode=%@&TotalAmount=%@&PaymentType=%@&BankName=%@&BankAccountNo=%@&BankAccountName=%@Amount=%@&DepositEvidenceFile=%@",@"2013052015272402215820239",@"1",@"1000000",@"0",@"CIMB NIaga",@"123456789",@"PT Panin Asset Management",@"1000000",@"asset.PNG""}"];
    
    NSString *post1 = @"jsondetail={\"SessionID\":\"2013052015272402215820239\",\"FundCode\":\"1\",\"TotalAmount\":1000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"}";
    
    // NSString *post2 = @"jsondetail={\"SessionID\":\"2013052015272402215820239\",\"FundCode\":\"1\",\"TotalAmount\":1000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"},{\"SessionID\":\"2013052015272402215820239\",\"FundCode\":\"1\",\"TotalAmount\":2000000,\"PaymentType\":\"0\",\"BankName\":\"CIMB Niaga\",\"BankAccountNo\":\"123456789\",\"Amount\":\"1000000\",\"DepositEvidenceFile\":\"asset.PNG\"}";
      
    NSURL *url=[NSURL URLWithString:@"http://www.panin-am.co.id:800/jsonTopUpOnline.aspx"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSData *requestData = [NSData dataWithBytes:[post1 UTF8String] length:[post1 length]];

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];  //new
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //new
    //[request setHTTPBody:postData];
    [request setHTTPBody: requestData];
    //[request setHTTPBody:[post1 dataUsingEncoding:NSUTF8StringEncoding]];
    
   //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
        NSLog(@"%@",jsonData);
        NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            NSLog(@"Login SUCCESS");
          //  [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
            
        } else {
            
            NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
            //[self alertStatus:error_msg :@"Login Failed!"];
        }
        
    } else {
        if (error) NSLog(@"Error: %@", error);
       // [self alertStatus:@"Connection Failed" :@"Login Failed!"];
    }
}

*/

//    NSError *error;
//
//
//    NSData *body = [NSJSONSerialization dataWithJSONObject:dict
//                                                   options:NSJSONWritingPrettyPrinted
//                                                     error:&error];
//    
//    
//    
//    NSMutableData * myMutableData = [[NSMutableData alloc] init];
//    [myMutableData appendData:body];
//    
//    //NSString *dataString = [NSString stringWithFormat:@"{\"shared_items\":%@,\"shared_list\":%@,\"facebook_id\":%@}",[sharedItems JSONRepresentation],[sharedList JSONRepresentation],facebookID];
//    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonTopUpOnline.aspx"]];
//    
//    NSString *string = [[NSString alloc] initWithData:body
//                                             encoding:NSUTF8StringEncoding];
//    NSLog(@"json:%@",string);
    
    //NSMutableData *requestBody = [[NSMutableData alloc] initWithData:[dict dataUsingEncoding:NSUTF8StringEncoding]];
    
    
 //   ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
   ////[request setPostValue:sessionID forKey:@"sessionid"];
   //// [request setPostBody:myMutableData];
//
//    [request setRequestMethod:@"POST"];
//    [request addRequestHeader:@"Accept" value:@"application/json"];
//    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
//    [request appendPostData:body];
//    [request setDelegate:self];
//    [request startAsynchronous];
    //new di comment
    
//    NSString *theURL = [NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonTopUpOnline.aspx"];
//    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:theURL]];
//    [theRequest setHTTPMethod:@"POST"];
//    
//    // Serialize my data.
//    NSData *theData = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:nil];
//    
//    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [theRequest setValue:[NSString stringWithFormat:@"%d", [theData length]] forHTTPHeaderField:@"Content-Length"];
//    [theRequest setHTTPBody:theData];


    
    /*
	 turning the image into a NSData object
	 getting the image back out of the UIImageView
	 setting the quality to 90
     */
//	NSData *imageData = UIImageJPEGRepresentation(img.image, 90);
//	// setting up the URL to post to
//	NSString *urlString = @"http://iphone.zcentric.com/test-upload.php";

	// setting up the request object now
	//NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	//[request setURL:[NSURL URLWithString:urlString]];
	//[request setHTTPMethod:@"POST"];
	
	/*
	 add some header info now
	 we always need a boundary when we post a file
	 also we need to set the content type
	 
	 You might want to generate a random boundary.. this is just the same
	 as my output from wireshark on a valid html post
     */
	//NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	//NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	//[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	/*
	 now lets create the body of the post
     */
	//NSMutableData *body = [NSMutableData data];
	//[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[NSData dataWithData:imageData]];
//	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	// setting the body of the post to the reqeust
	//[request setHTTPBody:body];
	
	// now lets make the connection to the web
	//NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	//NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	//NSLog(returnString);



- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void) connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if([[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        //return YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) showCameraUI {
    
    //BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL hasCamera = NO;
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = hasCamera ? UIImagePickerControllerSourceTypeCamera :    UIImagePickerControllerSourceTypePhotoLibrary;
    
    popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
    CGRect popoverRect = [self.view convertRect:[yourBtn frame]
                                       fromView:[yourBtn superview]];
    
    popoverRect.size.width = MIN(popoverRect.size.width, 100) ;
    popoverRect.origin.x = popoverRect.origin.x;
    
    [popoverController
     presentPopoverFromRect:popoverRect
     inView:self.view
     permittedArrowDirections:UIPopoverArrowDirectionAny
     animated:YES];
  

}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    img.image= image;
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController=nil;
    }
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    
    NSString *imageName = [imagePath lastPathComponent];
    NSLog(@"imageName:%@",imageName);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController=nil;
    }
    
}

- (void)pickerDone:(id)sender
{
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController=nil;
    }
}

- (IBAction)back:(id)sender{
    [self.view removeFromSuperview];
}
@end
