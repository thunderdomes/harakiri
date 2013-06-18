//
//  CekSaldo.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/27/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "CekSaldo.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CKCalendarView.h"

#define kObserver @"vcRadioButtonItemFromGroupSelected"

@interface CekSaldo () <CKCalendarDelegate>

{
    float temptotal;
}
@end

@implementation CekSaldo
@synthesize sessionID,label,tanggal,tanggaldipilih,date,labelNon,saldoNon,nabNon,penutupuanNon,modalNon,nilaiNon,untungNon,persenNon,nabAverageNon;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"vcRadioButtonItemFromGroupSelected" object:nil];
    }
    return self;
}


- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *currentDate = [NSDate date];
    date = [formatter stringFromDate:currentDate];
    [self loadData:date];
    
}

- (void)loadData:(NSString*)tanggalSend

{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    
//    NSDate *currentDate = [NSDate date];
//    date = [formatter stringFromDate:currentDate];
    
    //NSString *date;
    //date = [NSString stringWithFormat:@"2013-04-27"];
    //NSLog(@"Trying to sign in with sessionid:%@ date:%@",sessionID,date);
   // NSLog(@"Trying to sign in with sessionid:%@ date:%@",sessionID,tanggalSend);
    //tanggaldipilih.text = date;
    tanggaldipilih.text = tanggalSend;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.panin-am.co.id:800/jsonCheckBalance.aspx"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:sessionID forKey:@"sessionid"];
    [request setPostValue:tanggalSend forKey:@"date"];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    
    
    [request setDelegate:self];
    [request startAsynchronous];

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
    
    NSArray *saldo = [json objectForKey:@"Balance"]; //2
    NSLog(@"Saldo :%d",saldo.count);
    
    
    //trial
//    NSArray *innerString = [json valueForKey:@"Balance"];
//    NSString *namaCurrency = (NSString *) [[json valueForKey:@"Balance"] valueForKey:@"Currency"];
//    NSLog(@"innerstring count:%d",innerString.count);
//    
//    for (NSDictionary *content in innerString)
//    {
//        NSString *type = [content objectForKey:@"Currency"];
//        if ([type isEqualToString:@"IDR"])
//            NSLog(@"IDR");
//    {

    
     
    //mark
    int counter = saldo.count -9;
     NSLog(@"counter :%d",counter);
    
    //for (int i=0;counter;i++){
    int i = 0;
    do {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        [numberFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        [numberFormatter setCurrencySymbol:@""];
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [decimalFormatter setMaximumFractionDigits:3];
        [decimalFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        
        percentFormatter = [[NSNumberFormatter alloc] init];
        [percentFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [percentFormatter setCurrencySymbol:@""];
        [percentFormatter setMaximumFractionDigits:2];
        [percentFormatter setMinimumFractionDigits:0];
        [percentFormatter setAlwaysShowsDecimalSeparator:YES];
        
        NSDictionary *tempDict = [saldo objectAtIndex:i];
        NSString *fundName = [tempDict objectForKey:@"fundName"];
        label = (UILabel *)[self.view viewWithTag:i+1];
        label.textAlignment = UITextAlignmentRight;
        label.text = [NSString stringWithFormat:@"%@",fundName];
        NSLog(@" i: %d ,fundname:%@",i,fundName);
        i++;
    } while (i<=counter);
   // }
    
    int j = 0;
    do {

        
        NSDictionary *tempDict = [saldo objectAtIndex:j];
        NSString *unit = [tempDict objectForKey:@"unit"];
        label = (UILabel *)[self.view viewWithTag:j+21];
        //NSString *unit = [numberFormatter stringFromNumber:
        //label.text = [NSString stringWithFormat:@"%@",unit];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[unit floatValue]]];
        //NSLog(@"unit:%@",unit);
        j++;
    } while (j<=counter);



    int k = 0;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:k];
        NSString *average = [tempDict objectForKey:@"averageNAv"];
        label = (UILabel *)[self.view viewWithTag:k+41];
        //label.text = [NSString stringWithFormat:@"%@",average];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[average floatValue]]];
        //NSLog(@"average:%@",average);
        k++;
    }while (k<=counter);

    
    int l = 0;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:l];
        NSString *closing = [tempDict objectForKey:@"closingNAV"];
        label = (UILabel *)[self.view viewWithTag:l+61];
        //label.text = [NSString stringWithFormat:@"%@",closing];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[closing floatValue]]];
        //NSLog(@"closing:%@",closing);
        l++;
    }while (l<=counter);

    int m = 0;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:m];
        NSString *fundvalue = [tempDict objectForKey:@"fundValue"];
        label = (UILabel *)[self.view viewWithTag:m+81];
        //label.text = [NSString stringWithFormat:@"%@",fundvalue];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[fundvalue floatValue]]];

        //NSLog(@"fundvalue:%@",fundvalue);;
        m++;
    }while (m<=counter);
    
    int n = 0;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:n];
        NSString *marketvalue = [tempDict objectForKey:@"marketValue"];
        label = (UILabel *)[self.view viewWithTag:n+101];
        //label.text = [NSString stringWithFormat:@"%@",marketvalue];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[marketvalue floatValue]]];
        n++;
     }while (n<=counter);

    int o = 0;
    do {
        NSDictionary *tempDict = [saldo objectAtIndex:o];
        NSString *gainorlost = [tempDict objectForKey:@"gainOrLost"];
        label = (UILabel *)[self.view viewWithTag:o+121];
        //label.text = [NSString stringWithFormat:@"%@",gainorlost];
        label.textAlignment = UITextAlignmentRight;
        label.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[gainorlost floatValue]]];
        o++;
    }while (o<=counter);

    int p = 0;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:p];
        NSString *gainorlostpercent = [tempDict objectForKey:@"gainOrLostPercentage"];
        label = (UILabel *)[self.view viewWithTag:p+141];
        //label.text = [NSString stringWithFormat:@"%@",gainorlostpercent];
        label.textAlignment = UITextAlignmentRight;
        label.text = [NSString stringWithFormat:@" %@ %%",[percentFormatter stringFromNumber:[NSNumber numberWithFloat:[gainorlostpercent floatValue]]]];
        p++;
    }while (p<=counter);
    
    
    int counter1 = 10;
    NSLog(@"counter 1:%d",counter);
    
    //for (int i=0;counter;i++){
    int a = 4;
    do {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:0];
        [numberFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        [numberFormatter setCurrencySymbol:@""];
        
        decimalFormatter = [[NSNumberFormatter alloc] init];
        [decimalFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [decimalFormatter setMaximumFractionDigits:3];
        [decimalFormatter setMinimumFractionDigits:0];
        [decimalFormatter setAlwaysShowsDecimalSeparator:NO];
        
        percentFormatter = [[NSNumberFormatter alloc] init];
        [percentFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
        [percentFormatter setCurrencySymbol:@""];
        [percentFormatter setMaximumFractionDigits:2];
        [percentFormatter setMinimumFractionDigits:0];
        [percentFormatter setAlwaysShowsDecimalSeparator:YES];
        
        NSDictionary *tempDict = [saldo objectAtIndex:a];
        NSString *fundName = [tempDict objectForKey:@"fundName"];
        label = (UILabel *)[self.view viewWithTag:a+1];
        label.textAlignment = UITextAlignmentRight;
        label.text = [NSString stringWithFormat:@"%@",fundName];
        NSLog(@" i: %d ,fundname:%@",i,fundName);
        a++;
    } while (a<=counter1);
    // }
    
    int b = 4;
    do {
        
        
        NSDictionary *tempDict = [saldo objectAtIndex:b];
        NSString *unit = [tempDict objectForKey:@"unit"];
        label = (UILabel *)[self.view viewWithTag:b+21];
        //NSString *unit = [numberFormatter stringFromNumber:
        //label.text = [NSString stringWithFormat:@"%@",unit];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[unit floatValue]]];
        //NSLog(@"unit:%@",unit);
        b++;
    } while (b<=counter1);
    
    
    
    int c = 4;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:c];
        NSString *average = [tempDict objectForKey:@"averageNAv"];
        label = (UILabel *)[self.view viewWithTag:c+41];
        //label.text = [NSString stringWithFormat:@"%@",average];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[average floatValue]]];
        //NSLog(@"average:%@",average);
        c++;
    }while (c<=counter1);
    
    
    int d = 4;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:d];
        NSString *closing = [tempDict objectForKey:@"closingNAV"];
        label = (UILabel *)[self.view viewWithTag:d+61];
        //label.text = [NSString stringWithFormat:@"%@",closing];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[closing floatValue]]];
        //NSLog(@"closing:%@",closing);
        d++;
    }while (d<=counter1);
    
    int e = 4;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:e];
        NSString *fundvalue = [tempDict objectForKey:@"fundValue"];
        label = (UILabel *)[self.view viewWithTag:e+81];
        //label.text = [NSString stringWithFormat:@"%@",fundvalue];
        
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[fundvalue floatValue]]];
        
        //NSLog(@"fundvalue:%@",fundvalue);;
        
        float total = temptotal +  [fundvalue floatValue];
        float grandtotal = total+[fundvalue floatValue];
        NSLog(@"total:%f",grandtotal);
        
        e++;
        
    }while (e<=counter1);
    
    int f = 4;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:f];
        NSString *marketvalue = [tempDict objectForKey:@"marketValue"];
        label = (UILabel *)[self.view viewWithTag:f+101];
        //label.text = [NSString stringWithFormat:@"%@",marketvalue];
        [label setBackgroundColor:[UIColor clearColor]];
        label.textAlignment = UITextAlignmentRight;
        label.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[marketvalue floatValue]]];
        f++;
    }while (f<=counter1);
    
    int g = 4;
    do {
        NSDictionary *tempDict = [saldo objectAtIndex:g];
        NSString *gainorlost = [tempDict objectForKey:@"gainOrLost"];
        label = (UILabel *)[self.view viewWithTag:g+121];
        //label.text = [NSString stringWithFormat:@"%@",gainorlost];
        label.textAlignment = UITextAlignmentRight;
        [label setBackgroundColor:[UIColor clearColor]];
        label.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[gainorlost floatValue]]];
        g++;
    }while (g<=counter1);
    
    int h = 4;
    do {
        
        NSDictionary *tempDict = [saldo objectAtIndex:h];
        NSString *gainorlostpercent = [tempDict objectForKey:@"gainOrLostPercentage"];
        label = (UILabel *)[self.view viewWithTag:h+141];
        //label.text = [NSString stringWithFormat:@"%@",gainorlostpercent];
        label.textAlignment = UITextAlignmentRight;
        [label setBackgroundColor:[UIColor clearColor]];
        label.text = [NSString stringWithFormat:@" %@ %%",[percentFormatter stringFromNumber:[NSNumber numberWithFloat:[gainorlostpercent floatValue]]]];
        h++;
    }while (h<=counter1);
    

    
    
    
    
    NSDictionary *USD = [saldo objectAtIndex:3];
    labelNon.text = [USD objectForKey:@"fundName"];
    NSString *unit = [USD objectForKey:@"unit"];
    saldoNon.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:[unit floatValue]]];

    NSString *average = [USD objectForKey:@"averageNAv"];
    nabAverageNon.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[average floatValue]]];
                          
    NSString *closing = [USD objectForKey:@"closingNAV"];
    nabNon.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[closing floatValue]]];
    
    NSString *modal = [USD objectForKey:@"fundValue"];
    modalNon.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[modal floatValue]]];
    
    NSString *market = [USD objectForKey:@"marketValue"];
    nilaiNon.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[market floatValue]]];

    NSString *untung = [USD objectForKey:@"gainOrLost"];
    untungNon.text = [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:[untung floatValue]]];
    
    NSString *persen = [USD objectForKey:@"gainOrLostPercentage"];
    persenNon.text = [NSString stringWithFormat:@" %@ %%",[percentFormatter stringFromNumber:[NSNumber numberWithFloat:[persen floatValue]]]];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"error");
    NSError *error = [request error];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickDate:(id)sender{
    
//    UINavigationController *navigation = [[UINavigationController alloc] init];
//	CalendarViewController *controller = [[CalendarViewController alloc] init];
//	[navigation pushViewController:controller animated:NO];
//	[controller setCalendarViewControllerDelegate:self];
//	
//    [self.view addSubview:navigation.view];

    
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
    
    calendar.frame = CGRectMake(450,230, 280, 300);
    [self.view addSubview:calendar];
    
    //self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //[self.view addSubview:self.dateLabel];
    
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
    tanggaldipilih.text = tanggal;
    [self loadData:tanggal];
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
