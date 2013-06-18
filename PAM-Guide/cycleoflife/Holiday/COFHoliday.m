//
//  COFKendaraan.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "COFHoliday.h"

@interface COFHoliday ()

@end

@implementation COFHoliday
@synthesize nowdate,tanggal,tanggaldipilih,endDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd/MM/YYYY"];
//    
//    NSDate *currentDate = [NSDate date];
//    nowdate = [formatter stringFromDate:currentDate];
    
    UIImage *minImage = [UIImage imageNamed:@"pam-ipad-investor-slider1-296.png"];
    UIImage *maxImage = [UIImage imageNamed:@"pam-ipad-investor-slider-296.png"];
    
    
    minImage=[minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    maxImage=[maxImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:5.0];
    
//    // Setup the FX slider
//    [sliderTingkatInflasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [sliderTingkatInflasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
//    
//    [sliderOrang setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [sliderOrang setMaximumTrackImage:maxImage forState:UIControlStateNormal];

        
    tipeReksadana = @"Reksa Dana Saham";
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    [sliderOrang addGestureRecognizer:panGesture];
    [sliderTingkatInflasi addGestureRecognizer:panGesture];
    [sliderBiayaTransport addGestureRecognizer:panGesture];
    [sliderBiayaAkomodasi addGestureRecognizer:panGesture];
    [sliderKebutuhanLain addGestureRecognizer:panGesture];
    //[slider addGestureRecognizer:panGesture];
    panGesture.cancelsTouchesInView = NO;

    
}

- (void)viewDidAppear:(BOOL)animated{
    jumlahorang = [[NSUserDefaults standardUserDefaults] integerForKey:@"jumlahorang"];
    sliderOrang.value = jumlahorang;
    
    angkainflasi =[[NSUserDefaults standardUserDefaults] integerForKey:@"angkainflasi"];
    sliderTingkatInflasi.value = angkainflasi;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderchange:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    switch ([(UISlider*)sender tag]) {
        case 1:
            labelTingkatInflasi.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
        case 2:
            labelOrang.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
    }
    
    ((UISlider*)sender).value = [slidevalue intValue];
}


-(IBAction)changeSeg{
	if(Segment.selectedSegmentIndex == 0){
        NSLog(@"1");
        tipeReksadana = @"Reksa Dana Saham";
	}
	if(Segment.selectedSegmentIndex == 1){
        NSLog(@"2");
        tipeReksadana = @"Reksa Dana Campuran";
	}
    if(Segment.selectedSegmentIndex == 2) {
        NSLog(@"3");
        tipeReksadana = @"Reksa Dana Pendapatan Tetap";
    }
    if(Segment.selectedSegmentIndex == 3) {
        NSLog(@"4");
        tipeReksadana = @"Reksa Dana Pasar Uang";
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tipeReksadana forKey:@"reksadana"];

}

- (IBAction)pickDate:(id)sender{
    

    
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //[self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.minimumDate = [self.dateFormatter dateFromString:@"12/09/2012"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"05/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(420,430, 230, 230);
    [self.view addSubview:calendar];
    
    //self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //[self.view addSubview:self.dateLabel];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
}

-(IBAction)changeSlider:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    if ([slidevalue intValue] == 0){
        self.konservatif.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-off-01-88x16.png"];
        //self.moderat.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-off-02-88x16.png"];
    }
    
    
    if ([slidevalue intValue] == 1){
        pilihReksaDana.text = @"Reksa Dana Pasar Uang";
        self.konservatif.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-on-01-88x16.png"];
        self.moderat.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-off-02-88x16.png"];
    }
    if ([slidevalue intValue] == 2){
        pilihReksaDana.text = @"Reksa Dana Pendapatan Tetap";
        self.moderat.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-on-02-88x16.png"];
    }
    if ([slidevalue intValue] == 3){
        pilihReksaDana.text = @"Reksa Dana Campuran";
        self.moderat.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-on-02-88x16.png"];
        self.agresif.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-off-03-88x16.png"];
    }
    if ([slidevalue intValue] == 5){
        pilihReksaDana.text = @"Reksa Dana Pasar Saham";
        self.agresif.image = [UIImage imageNamed: @"pam-ipad-cycleoflife-page1-button-on-03-88x16.png"];
    }
    
}



- (IBAction)changeSliderJumlahOrang:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    jumlahorang = [slidevalue intValue];
    
   
    
    if ([slidevalue intValue] == 1){
        labelJumlahOrang.text = @"1";
    }
    
    
    if ([slidevalue intValue] == 2){
        labelJumlahOrang.text = @"2";
        
    }
    if ([slidevalue intValue] == 3){
        labelJumlahOrang.text = @"3";
        
    }
    if ([slidevalue intValue] == 4){
        labelJumlahOrang.text = @"4";
        
    }
    if ([slidevalue intValue] == 5){
        labelJumlahOrang.text = @"5";
    }
    if ([slidevalue intValue] == 6){
        labelJumlahOrang.text = @"5";
    }
    if ([slidevalue intValue] == 7){
        labelJumlahOrang.text = @"5";
    }
    if ([slidevalue intValue] == 8){
        labelJumlahOrang.text = @"5";
    }
    if ([slidevalue intValue] == 9){
        labelJumlahOrang.text = @"5";
    }
    if ([slidevalue intValue] == 10){
        labelJumlahOrang.text = @"5";
    }
     [[NSUserDefaults standardUserDefaults] setInteger:jumlahorang forKey:@"jumlahorang"];
}




- (IBAction)changeSliderInflasi:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    angkainflasi = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:angkainflasi forKey:@"angkainflasi"];
    
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:[slidehargavalue floatValue]] forKey:@"hargakendaraan"];
    
}


-(IBAction)changeSliderBiayaTransport:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    if ([slidevalue intValue] == 1){
        biayaTransport = 500000;
    }
    
    if ([slidevalue intValue] == 2){
        biayaTransport = 50000000;
    }
    if ([slidevalue intValue] == 3){
        biayaTransport = 100000000;
    }
    if ([slidevalue intValue] == 4){
        biayaTransport = 200000000;
    }
    if ([slidevalue intValue] == 5){
        biayaTransport = 300000000;
    }
    if ([slidevalue intValue] == 6){
        biayaTransport = 50000000;
    }
    
    slideBiayaTransport = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:slideBiayaTransport forKey:@"biayatransport"];
    [[NSUserDefaults standardUserDefaults] setInteger:biayaTransport forKey:@"biayatransport1"];
    
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:[slidehargavalue floatValue]] forKey:@"hargakendaraan"];
    
}

-(IBAction)changeSliderBiayaAkomodasi:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    if ([slidevalue intValue] == 1){
        biayaAkomodasi = 500000;
    }
    
    if ([slidevalue intValue] == 2){
        biayaAkomodasi = 50000000;
    }
    if ([slidevalue intValue] == 3){
        biayaAkomodasi = 100000000;
    }
    if ([slidevalue intValue] == 4){
        biayaAkomodasi = 200000000;
    }
    if ([slidevalue intValue] == 5){
        biayaAkomodasi = 300000000;
    }
    if ([slidevalue intValue] == 6){
        biayaAkomodasi = 50000000;
    }
    
    slideBiayaAkomodasi = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:slideBiayaAkomodasi forKey:@"biayaakomodasi"];
    [[NSUserDefaults standardUserDefaults] setInteger:biayaAkomodasi forKey:@"biayaakomodasi1"];
    
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:[slidehargavalue floatValue]] forKey:@"hargakendaraan"];
    
}

-(IBAction)changeSliderKebutuhanLainnya:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    if ([slidevalue intValue] == 1){
        kebutuhanLainnya = 500000;
    }
    
    if ([slidevalue intValue] == 2){
        kebutuhanLainnya = 50000000;
    }
    if ([slidevalue intValue] == 3){
        kebutuhanLainnya = 100000000;
    }
    if ([slidevalue intValue] == 4){
        kebutuhanLainnya = 200000000;
    }
    if ([slidevalue intValue] == 5){
        kebutuhanLainnya = 300000000;
    }
    if ([slidevalue intValue] == 6){
        kebutuhanLainnya = 50000000;
    }
    
    slideKebutuhanLainnya = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:slideKebutuhanLainnya forKey:@"kebutuhanlainnya"];
    [[NSUserDefaults standardUserDefaults] setInteger:kebutuhanLainnya forKey:@"kebutuhanlainnya1"];
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:[slidehargavalue floatValue]] forKey:@"hargakendaraan"];
    
}


- (IBAction)back{
    // [self.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backbuttonpressed" object:self];
    
    
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
    
    
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //endDate = [dateFormatter dateFromString:tanggal];
    endDate = date;
    [self.calendar removeFromSuperview];
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    return [date laterDate:self.minimumDate] == date;
}

- (IBAction)back:(id)sender{
    [self.view removeFromSuperview];
}

- (IBAction)hitung:(id)sender{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    //NSDate *currentDate = [NSDate date];

    NSDate *startDate = [NSDate date];
    
    //endDate = ...;
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    float months = [comps month]+1;
    NSLog(@"Beda Bulan:%f",months);
    
    float slidetingkatinvestasiplussatu = 1 + [sliderTingkatInflasi value] /100;
    //float dp = [sliderDP value] /100;
    
    float jumlahorang = [sliderOrang value];
    
    float inflasi = pow(slidetingkatinvestasiplussatu,0.083333);
    float inflasiPerBulan = inflasi-1;
    NSLog (@"inflasi per bulan = %f",inflasiPerBulan);
    
    float satuPlusInflasiPerBulan = (1+inflasiPerBulan);
    float infestasipowmonths = pow(satuPlusInflasiPerBulan,months);
    
    
    NSString *tiket = ticketFlight.text;
    CGFloat strTiketFlight = (CGFloat)[tiket floatValue];
    
    NSString *accomodate = accomodation.text;
    CGFloat strAccomodation = (CGFloat)[accomodate floatValue];
    
    NSString *theothers = others.text;
    CGFloat strOthers = (CGFloat)[theothers floatValue];
    
    float totalExpense = (strTiketFlight+strAccomodation+strOthers)*jumlahorang;
    
    //float tempdanaYangDibutuhkan = pow(inflasiPerBulan,months);
    float danaYangDibutuhkan = infestasipowmonths*totalExpense;
    
    NSLog(@"dtotal expense:%f",totalExpense);
    NSLog(@"dana yang dibutuhkan:%f",danaYangDibutuhkan);
    
    
    //float danaYangDibutuhkan = infestasipowmonths*strHargaKendaraan*dp;
    

    float tempreturnBulananSaham = pow(1.2,0.083333);
    float returnBulananSaham = tempreturnBulananSaham -1;
    float tempreturnCampuran = pow(1.15,0.083333);
    float returnBulananCampuran = tempreturnCampuran -1;
    float tempreturnPendapatanTetap = pow(1.1,0.083333);
    float returnPendapatanTetap = tempreturnPendapatanTetap -1;
    float tempreturnPasarUang = pow(1.05,0.083333);
    float returnPasarUang = tempreturnPasarUang -1;
    
    float returnBulananSahamPlusSatu = returnBulananSaham+1;
    float returnBulananCampuranPlusSatu = returnBulananCampuran+1;
    float returnPendapatanTetapPlusSatu = returnPendapatanTetap+1;
    float returnPasarUangPlusSatu = returnPasarUang+1;
    
    float investasiSekarangSaham = danaYangDibutuhkan/pow(returnBulananSahamPlusSatu,months);
    
    float pow_temp = pow(returnBulananSahamPlusSatu,months);
    float pow1 = pow_temp-1;
    float part1 = (pow1 /returnBulananSaham)*returnBulananSahamPlusSatu;
    float investasiPerBulanSaham = danaYangDibutuhkan/part1;
    
    float pow_temp2 = pow(returnBulananCampuranPlusSatu,months);
    float pow2 = pow_temp2-1;
    float part2 = (pow2 /returnBulananCampuran)*returnBulananCampuranPlusSatu;
    float investasiPerBulanCampuran = danaYangDibutuhkan/part2;

    float pow_temp3 = pow(returnPendapatanTetapPlusSatu,months);
    float pow3 = pow_temp3-1;
    float part3 = (pow3/returnPendapatanTetap)*returnPendapatanTetapPlusSatu;
    float investasiPerBulanPendapatanTetap = danaYangDibutuhkan/part3;
    
    float pow_temp4 = pow(returnPasarUangPlusSatu,months);
    float pow4 = pow_temp4-1;
    float part4 = (pow4/returnPasarUang)*returnPasarUangPlusSatu;
    //float investasiPerBulanPasarUang = danaYangDibutuhkan/part4;


    //NSLog (@"investasi skrg saham:%f",danaYangDibutuhkan);
    NSLog (@"return bulanan saham pow satu%f",pow1);
    NSLog (@"return bulanan saham%f",returnBulananSaham);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    
   NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:danaYangDibutuhkan]];
    
    labelJumlahDanaDibutuhkan.text = numberAsString;
    
    NSString *numberAsString2 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiSekarangSaham]];
    labelInvestasiSekarang.text = numberAsString2;
    
    NSString *numberAsString3 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiPerBulanSaham]];
    labelInvestasiPerBulan.text = numberAsString3;
    
    labelTanggalDPDiperlukan.text = tanggal;
    
    labelTipeReksaDana.text = tipeReksadana;



}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UISlider class]]) {
        // prevent recognizing touches on the slider
        return NO;
    }
    return NO;
}


@end
