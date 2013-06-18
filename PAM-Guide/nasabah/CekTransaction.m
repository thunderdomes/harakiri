//
//  CekTransaction.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/28/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "CekTransaction.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CKCalendarView.h"
#import "AppDelegate.h"
#import "NIDropDown.h"
#import "AppDelegate.h"
#import "SVWebViewController.h"
#import "DZWebBrowser.h"


@interface CekTransaction () <CKCalendarDelegate>

@end

@implementation CekTransaction
@synthesize jumlahTransaksi,periodeTransaksi,numberLabel,ftype,fvalue,sessionID,webView,label,tanggal,tanggaldipilih,btnSelect,fromLabel,toLabel,periode,strTanggalFrom,strTanggalTo,responseString1,responseString2,historyID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showScroll)
                                                     name:@"showperiode"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideScroll)
                                                     name:@"hideperiode"
                                                   object:nil];
        
      //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
      
    }
    return self;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      

    
//     [jumlahTransaksi setImage:[UIImage imageNamed:@"button-on.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
    //dayLabel.hidden = YES;
    buttonJumlahTransaksi.hidden = YES;
    //periodeLabel.hidden = YES;
    buttonPeriodeTransaksi.hidden = YES;
    btnSelect.hidden = YES;
    periode.hidden = YES;
    btnSelect.layer.borderWidth = 1;
    btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    btnSelect.layer.cornerRadius = 5;
    
}

- (void)viewDidUnload {
    //    [btnSelect release];
   // btnSelect = nil;
    //[self setBtnSelect:nil];
    
    [super viewDidUnload];
}

- (void)showScroll{
    periode.hidden = NO;
}

- (void)hideScroll{
    periode.hidden = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pilihTransaksi:(id) sender {
    UIButton *button = (UIButton*) sender;
    switch(button.tag)
    {
        case 1001:
            NSLog(@"button 1");
            btnSelect.hidden = NO;
            jumlahTransaksi.selected = YES;
            periodeTransaksi.selected = NO;
            //dayLabel.hidden = NO;
            //periodeLabel.hidden = YES;
            buttonJumlahTransaksi.hidden = NO;
            buttonPeriodeTransaksi.hidden =YES;
            ftype = @"1";
            break;
        case 1002:
            NSLog(@"button 2");
            periodeTransaksi.selected = YES;
            jumlahTransaksi.selected = NO;
            //dayLabel.hidden = YES;
            buttonJumlahTransaksi.hidden = YES;
            //periodeLabel.hidden = NO;
            buttonPeriodeTransaksi.hidden = NO;
            btnSelect.hidden = YES;
            ftype = @"2";
            break;
        default:
            break;
    }
}

- (IBAction)pilihJumlahTransaksi:(id)sender

{
    daysData = [[NSArray alloc] initWithObjects:@"5 Transaksi Terakhir", @"10 Transaksi Terakhir", @"15 Transaksi Terakhir",nil];
    
   NSArray * arrImage = [[NSArray alloc] init];
   arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :daysData :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
    
    
//    daysPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(700, 80, 126.0, 197.0)];
//    daysPickerView.dataSource = self;
//    daysPickerView.delegate = self;
//    daysPickerView.rowFont = [UIFont boldSystemFontOfSize:19.0];
//    daysPickerView.rowIndent = 10.0;
//    [daysPickerView reloadData];
//    [self.view addSubview:daysPickerView];

}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}


- (IBAction)pilihPeriodeTransaksi:(id)sender
{
    periodeData = [[NSArray alloc] initWithObjects:@"6 bulan Terakhir", @"1 Tahun Terakhir", @"3 Tahun Terakhir",@"Periode Tertentu", nil];
     NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :periodeData :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

//    periodePickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(600, 170, 126.0, 197.0)];
//    periodePickerView.dataSource = self;
//    periodePickerView.delegate = self;
//    periodePickerView.rowFont = [UIFont boldSystemFontOfSize:19.0];
//    periodePickerView.rowIndent = 10.0;
//    [periodePickerView reloadData];
//    [self.view addSubview:periodePickerView];
    
}

#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (pickerView == daysPickerView)
        return [daysData count];
    else return [periodeData count];
   // return 100;
}




- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == daysPickerView)
        return [daysData objectAtIndex:row];
    else return [periodeData objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%i", row + 1];
}




#pragma mark - AFPickerViewDelegate

//- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
//{
//    if (pickerView == daysPickerView) {
//        self.dayLabel.text = [daysData objectAtIndex:row];
//        if ([self.dayLabel.text isEqual: @"5 Transaksi Terakhir"]) fvalue = @"5";
//         else
//            fvalue = [self.dayLabel.text substringToIndex:2];
//        NSLog(@"fvalue:%@",fvalue);
//        [pickerView removeFromSuperview];
//    }
//    else {
//        //self.numberLabel.text = [NSString stringWithFormat:@"%i", row + 1];
//        self.periodeLabel.text = [periodeData objectAtIndex:row];
//        if ([self.periodeLabel.text isEqual: @"Pilih Periode Transaksi"]) fvalue = @"0";
//        if ([self.periodeLabel.text isEqual: @"6 bulan Terakhir"]) fvalue = @"1";
//        if ([self.periodeLabel.text isEqual: @"1 Tahun Terakhir"]) fvalue = @"2";
//        if ([self.periodeLabel.text isEqual: @"3 Tahun Terakhir"]) fvalue = @"3";
//        if ([self.periodeLabel.text isEqual: @"Periode Tertentu"]) fvalue = @"4";
//        
//        NSLog(@"fvalue:%@",fvalue);
//        [pickerView removeFromSuperview];
//        
//    }
//}

- (IBAction)cekTransaksi:(id)sender{
    
    //dropDown = [[NIDropDown alloc]init];
    
    //fvalue = dropDown.fvaluepass;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    fvalue  = appDelegate.fvalueGlobalString;
    
    [scroll removeFromSuperview];
    

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonCheckTransactionHistory.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setPostValue:ftype forKey:@"fType"];
    [request setPostValue:fvalue forKey:@"fVal"];
    [request setPostValue:strTanggalFrom forKey:@"sDate"];
    [request setPostValue:strTanggalTo forKey:@"eDate"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    [request setCompletionBlock:^{
        responseString1 = [request responseString];
        //[self checkIfBothRequestsComplete];
    }];
    request.userInfo = [NSDictionary dictionaryWithObject:@"cektransaction" forKey:@"type"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    
   


}

- (void)requestFinished:(ASIFormDataRequest *)request
{
    [scroll removeFromSuperview];
    
    NSString *responseString = [request responseString];
    NSLog(@"hasil response transaksi:%@",responseString);
    
    
    NSData *responseData = [request responseData];
    
    //NSLog(@"headers: %@", [request responseHeaders]);
    //NSLog(@"headers1: %@", [[request requestHeaders]description]);
    
//// NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"useThisJSONString(%@)", responseString]];
////    NSLog (@"1. result: %@", result);
//    
//    NSURL *urlforWebView= [NSURL URLWithString:[json objectForKey:@"fundName"]];
//    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:urlforWebView];
//    [webView loadRequest:urlRequest];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData //1
    
                              options:kNilOptions
    
                          error:&error];
    
    NSArray *transaksi = [json objectForKey:@"TransactionHistory"]; //2
    
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"cektransaction"]) {
        historyID = [json valueForKeyPath:@"TransactionHistory.transHistoryID"];
        
    }
    if ([[request.userInfo objectForKey:@"type"] isEqualToString:@"historylink"]) {
        NSString *link = [json valueForKeyPath:@"FileLink"];        
    
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

    
    int y =20;
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 200, 900, 420)];
    scroll.contentSize = CGSizeMake(200, 3300);
    [scroll setShowsVerticalScrollIndicator:NO];
    
    //[scroll removeFromSuperview];
    
    [self.view addSubview:scroll];
    
    UIFont *myFont = [ UIFont fontWithName: @"Avenir" size: 12.0 ];
    
    for (int i=0;i<transaksi.count;i++){
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [decimalFormatter setMaximumFractionDigits:3];
        [decimalFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];

        NSDictionary *tempDict = [transaksi objectAtIndex:i];
        
        
                
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(1, y, 33, 33);
        UIImage *buttonImageNormal = [UIImage imageNamed:@"pam-ipad-button-pdf-23x30.png"];
        [button setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self
                   action:@selector(getFileMethod:)
         forControlEvents:UIControlEventTouchDown];

        
        NSString *transdate = [tempDict objectForKey:@"transDate"];
        UILabel *transdateLabel =[[UILabel alloc] initWithFrame:CGRectMake(48,y,70,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        transdateLabel.font = myFont;
        transdateLabel.minimumFontSize = 12.0;
        transdateLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        transdateLabel.adjustsFontSizeToFitWidth = YES;
        transdateLabel.text = @" ";
        transdateLabel.text = [NSString stringWithFormat:@"%@",transdate];
        
        NSString *descriptions = [tempDict objectForKey:@"descriptions"];
        UILabel *descriptionLabel =[[UILabel alloc] initWithFrame:CGRectMake(150,y,50,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        descriptionLabel.font = myFont;
        descriptionLabel.minimumFontSize = 12.0;
        descriptionLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        descriptionLabel.adjustsFontSizeToFitWidth = YES;
        descriptionLabel.text = @" ";
        descriptionLabel.text = [NSString stringWithFormat:@"%@",descriptions];
        
        NSString *fundName = [tempDict objectForKey:@"fundName"];
        UILabel *testLabel =[[UILabel alloc] initWithFrame:CGRectMake(205,y,200,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        testLabel.font = myFont;
        testLabel.minimumFontSize = 12.0;
        testLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        testLabel.adjustsFontSizeToFitWidth = YES;
        testLabel.text = @" ";
        testLabel.text = [NSString stringWithFormat:@"%@",fundName];
     

        
        NSString *feepercent = [tempDict objectForKey:@"feePercent"];
        UILabel *feepercentLabel =[[UILabel alloc] initWithFrame:CGRectMake(470,y,25,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        feepercentLabel.font = myFont;
        feepercentLabel.minimumFontSize = 12.0;
        feepercentLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        feepercentLabel.adjustsFontSizeToFitWidth = YES;
        feepercentLabel.text = @" ";
        [feepercentLabel setBackgroundColor:[UIColor clearColor]];
        feepercentLabel.text = [NSString stringWithFormat:@"%@",feepercent];
        
        NSString *groosamount = [tempDict objectForKey:@"netAmmount"];
        UILabel *grossammountLabel =[[UILabel alloc] initWithFrame:CGRectMake(500,y,90,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        grossammountLabel.font = myFont;
        grossammountLabel.minimumFontSize = 12.0;
        grossammountLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        grossammountLabel.adjustsFontSizeToFitWidth = YES;
        grossammountLabel.text = @" ";
        grossammountLabel.textAlignment = NSTextAlignmentRight;
        [grossammountLabel setBackgroundColor:[UIColor clearColor]];
        //grossammountLabel.text = [NSString stringWithFormat:@"%@",groosamount];
        
        grossammountLabel.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[groosamount floatValue]]];
        
        NSString *nav = [tempDict objectForKey:@"NAV"];
        UILabel *navLabel =[[UILabel alloc] initWithFrame:CGRectMake(665,y,90,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        navLabel.font = myFont;
        navLabel.minimumFontSize = 12.0;
        navLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        navLabel.adjustsFontSizeToFitWidth = YES;
        navLabel.text = @" ";
         [navLabel setBackgroundColor:[UIColor clearColor]];
        navLabel.text = [NSString stringWithFormat:@"%@",nav];
        
        NSString *unit = [tempDict objectForKey:@"unit"];
        UILabel *unitLabel =[[UILabel alloc] initWithFrame:CGRectMake(740,y,68,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        unitLabel.font = myFont;
        unitLabel.minimumFontSize = 12.0;
        unitLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        unitLabel.adjustsFontSizeToFitWidth = YES;
        unitLabel.text = @" ";
         [unitLabel setBackgroundColor:[UIColor clearColor]];
        unitLabel.text = [NSString stringWithFormat:@"%@",unit];
        
        NSString *unitbalance = [tempDict objectForKey:@"unitBalance"];
        UILabel *unitbalanceLabel =[[UILabel alloc] initWithFrame:CGRectMake(850,y,70,21)];
        //label = (UILabel *)[self.view viewWithTag:i+1];
        unitbalanceLabel.font = myFont;
        unitbalanceLabel.minimumFontSize = 12.0;
        unitbalanceLabel.textColor =  [UIColor colorWithRed:2.0/255.0 green:143.0/255.0 blue:159.0/255.0 alpha:1.0];
        unitbalanceLabel.adjustsFontSizeToFitWidth = YES;
        [unitbalanceLabel setBackgroundColor:[UIColor clearColor]];
        unitbalanceLabel.text = @" ";
        unitbalanceLabel.text = [NSString stringWithFormat:@"%@",unitbalance];
        


        y = y+32;
        
        [scroll addSubview:testLabel];
        [scroll addSubview:transdateLabel];
        [scroll addSubview:descriptionLabel];
        [scroll addSubview:feepercentLabel];
        [scroll addSubview:grossammountLabel];
        [scroll addSubview:navLabel];
        [scroll addSubview:unitLabel];
        [scroll addSubview:unitbalanceLabel];
        [scroll addSubview:button];
    
        
    }
    
    
}

-(IBAction)getFileMethod:(id)sender
{
    int i = [(UIButton*)sender tag];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonCheckTransactionHistoryLink.aspx"]];
    
    ASIFormDataRequest *request2 = [ASIFormDataRequest requestWithURL:url];
    
    
    [request2 setPostValue:sessionID forKey:@"sessionid"];
    [request2 setPostValue:[historyID objectAtIndex:i] forKey:@"historyid"];
    
    [request2 setRequestMethod:@"POST"];
    [request2 addRequestHeader:@"Accept" value:@"application/json"];
    [request2 addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    [request2 setCompletionBlock:^{
        responseString2 = [request2 responseString];
        //[self checkIfBothRequestsComplete];
    }];
    request2.userInfo = [NSDictionary dictionaryWithObject:@"historylink" forKey:@"type"];
    
    [request2 setDelegate:self];
    [request2 startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}

- (IBAction)pickDate:(id)sender{
    
   
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    //[self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"2012-09-12"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"2013-01-05"],
                           [self.dateFormatter dateFromString:@"2013-01-06"],
                           [self.dateFormatter dateFromString:@"2013-01-06"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    switch ([(UIButton*)sender tag]) {
        case 1:  calendar.tag = 1;
            break;
        case 2: calendar.tag = 2;
            break;
    }

    
    calendar.frame = CGRectMake(450,230, 280, 300);
    [self.view addSubview:calendar];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
}


- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    //self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    tanggal = [self.dateFormatter stringFromDate:date];
    NSLog(@"Date:%@",tanggal);

    if(calendar.tag == 1) {
        
        fromLabel.text = tanggal;
        strTanggalFrom = tanggal;
        NSLog(@"strtanggal:%@",strTanggalFrom);
    }
    if(calendar.tag == 2) {
        
        toLabel.text = tanggal;
       strTanggalTo = tanggal;
    }
    
     [self.calendar removeFromSuperview];

    
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return [date laterDate:self.minimumDate] == date;
}

- (IBAction)back:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closefader" object:self];
    [self.view removeFromSuperview];
}



@end
