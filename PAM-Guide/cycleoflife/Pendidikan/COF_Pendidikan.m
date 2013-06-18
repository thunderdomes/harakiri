//
//  COFKendaraan.m
//  PAM-Guide
//
//  Created by Dave Harry on 4/29/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "COF_Pendidikan.h"

@interface COF_Pendidikan () 

@end

@implementation COF_Pendidikan

@synthesize nowdate,tanggal,tanggaldipilih,endDate,moneyfull1,moneyfull2,moneyfull3,moneyfull4,moneyfull5,moneyfull6,tanggaldipilih2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    
    
    slidehargavalue = [[NSUserDefaults standardUserDefaults] integerForKey:@"hargakendaraan"];
    sliderHarga.value = slidehargavalue;
    
    slideangkainflasi = [[NSUserDefaults standardUserDefaults] integerForKey:@"angkainflasi"];
    sliderTingkatInflasi.value = slideangkainflasi;
    
    slidedpvalue = [[NSUserDefaults standardUserDefaults] integerForKey:@"angkadp"];
    sliderDP.value = slidedpvalue;
    
    lamapinjamvalue = [[NSUserDefaults standardUserDefaults] integerForKey:@"lamapinjam"];
    lamaPinjam.value = lamapinjamvalue;
    
    if ([lamaPinjam value] == 1){
        labelTahunPinjam.text = @"1";
    }
    
    
    if ([lamaPinjam value] == 2){
        labelTahunPinjam.text = @"2";
        
    }
    if ([lamaPinjam value] == 3){
        labelTahunPinjam.text = @"3";
        
    }
    if ([lamaPinjam value] == 4){
        labelTahunPinjam.text = @"4";
        
    }
    if ([lamaPinjam value] == 5){
        labelTahunPinjam.text = @"5";
    }
    bungapinjamvalue = [[NSUserDefaults standardUserDefaults] integerForKey:@"bungapinjam"];
    bungaPinjam.value = bungapinjamvalue;
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"tanggaldipilih"];
    tanggaldipilih2.text = savedValue;
    


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
    
    // Setup the FX slider
//    [sliderTingkatInflasi setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [sliderTingkatInflasi setMaximumTrackImage:maxImage forState:UIControlStateNormal];
//    
//    [sliderDP setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [sliderDP setMaximumTrackImage:maxImage forState:UIControlStateNormal];
//
//    [isianLamaPinjaman setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [isianLamaPinjaman setMaximumTrackImage:maxImage forState:UIControlStateNormal];
//
//    [isianBungaPinjaman setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [isianBungaPinjaman setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    
    tipeReksadana = @"Reksa Dana Saham";
    
    moneyfull1.hidden = NO;
    moneyfull2.hidden = YES;
    moneyfull3.hidden = YES;
    moneyfull4.hidden = YES;
    moneyfull5.hidden = YES;
    moneyfull6.hidden = YES;
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    [sliderHarga addGestureRecognizer:panGesture];
    [sliderTingkatInflasi addGestureRecognizer:panGesture];
    [sliderDP addGestureRecognizer:panGesture];
    [lamaPinjam addGestureRecognizer:panGesture];
    [bungaPinjam addGestureRecognizer:panGesture];
    //[slider addGestureRecognizer:panGesture];
    panGesture.cancelsTouchesInView = NO;
    
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
            labeSliderlDP.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
        case 3:
            labelSliderLamaPinjaman.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
        case 4:
            labelSliderBungaPinjaman.text = [NSString stringWithFormat:@"%d", [slidevalue intValue]];
            break;
            
    }
    
    ((UISlider*)sender).value = [slidevalue intValue];
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

- (IBAction)changeSliderBungaPinjam:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    bungapinjamvalue = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:bungapinjamvalue forKey:@"bungapinjam"];
    
        
}

- (IBAction)changeSliderLamaPinjam:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    lamapinjamvalue = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:lamapinjamvalue forKey:@"lamapinjam"];
    
    if ([slidevalue intValue] == 1){
        labelTahunPinjam.text = @"1";
    }
    
    
    if ([slidevalue intValue] == 2){
        labelTahunPinjam.text = @"2";
        
    }
    if ([slidevalue intValue] == 3){
        labelTahunPinjam.text = @"3";
        
    }
    if ([slidevalue intValue] == 4){
        labelTahunPinjam.text = @"4";
        
    }
    if ([slidevalue intValue] == 5){
        labelTahunPinjam.text = @"5";
    }
    
}


- (IBAction)changeSliderDP:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    slidedpvalue = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:slidedpvalue forKey:@"angkadp"];
    
    
}


- (IBAction)changeSliderInflasi:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    slideangkainflasi = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:slideangkainflasi forKey:@"angkainflasi"];
    
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:[slidehargavalue floatValue]] forKey:@"hargakendaraan"];
    
}


-(IBAction)changeSliderHarga:(id)sender
{
    
    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
    
    if ([slidevalue intValue] == 1){
        moneyfull2.hidden = YES;
        moneyfull3.hidden = YES;
        moneyfull4.hidden = YES;
        moneyfull5.hidden = YES;
        moneyfull6.hidden = YES;
        hargakendaraan = 20000000;
    }
    
    
    if ([slidevalue intValue] == 2){
        moneyfull2.hidden = NO;
        moneyfull3.hidden = YES;
        hargakendaraan = 50000000;
    }
    if ([slidevalue intValue] == 3){
        moneyfull3.hidden = NO;
        moneyfull4.hidden = YES;
        hargakendaraan = 100000000;
    }
    if ([slidevalue intValue] == 4){
         moneyfull4.hidden = NO;
        moneyfull5.hidden = YES;
        hargakendaraan = 200000000;
    }
    if ([slidevalue intValue] == 5){
        moneyfull5.hidden = NO;
        moneyfull6.hidden = YES;
        hargakendaraan = 500000000;
    }
    if ([slidevalue intValue] == 6){
        moneyfull6.hidden = NO;
        hargakendaraan = 1000000000;
    }
    
    slidehargavalue = [slidevalue intValue];
    
    [[NSUserDefaults standardUserDefaults] setInteger:slidehargavalue forKey:@"hargakendaraan"];
    [[NSUserDefaults standardUserDefaults] setInteger:hargakendaraan forKey:@"hargakendaraan1"];
    
    
    
    // [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:[slidehargavalue floatValue]] forKey:@"hargakendaraan"];

}

//-(IBAction)changeLabelHarga:(id)sender
//{
//    
//    NSNumber *slidevalue = [[NSNumber alloc] initWithFloat:((UISlider*)sender).value];
//    
//    if ([slidevalue intValue] == 1){
//        labelTahunPinjam.text = @"1";
//    }
//    
//    
//    if ([slidevalue intValue] == 2){
//        labelTahunPinjam.text = @"2";
//
//    }
//    if ([slidevalue intValue] == 3){
//        labelTahunPinjam.text = @"3";
//
//    }
//    if ([slidevalue intValue] == 4){
//        labelTahunPinjam.text = @"4";
//
//    }
//    if ([slidevalue intValue] == 5){
//        labelTahunPinjam.text = @"5";
//    }
//    
//}


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
    
    calendar.frame = CGRectMake(400,390, 280, 300);
    [self.view addSubview:calendar];
    
    //self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //[self.view addSubview:self.dateLabel];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
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
    //tanggaldipilih2.text = tanggal;
    
    NSString *valueToSave = tanggal;
    [[NSUserDefaults standardUserDefaults]
     setObject:valueToSave forKey:@"tanggaldipilih"];
    
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
    
    hargakendaraan = [[NSUserDefaults standardUserDefaults]integerForKey:@"hargakendaraan1"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    //NSDate *currentDate = [NSDate date];

    NSDate *startDate = [NSDate date];
    
    //endDate = ...;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSDate *endDate1 = [df dateFromString: tanggaldipilih2.text];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned int unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate1  options:0];
    float months = [comps month]+1;
    //float months = round(month);
    NSLog(@"Beda Bulan:%f",months);
    
    
    float a = slideangkainflasi;
    float tempslideinvestasi = a/100;
    
   // float slidetingkatinvestasiplussatu = 1 + (slideangkainflasi /100);
    float slidetingkatinvestasiplussatu = 1 + tempslideinvestasi;
    
    float b = slidedpvalue;
    float dp = b /100;
    NSLog(@"slidedpvalue:%f",b);
    NSLog(@"dp:%f",dp);
    
    float inflasi = pow(slidetingkatinvestasiplussatu,0.083333); 
    float inflasiPerBulan = inflasi-1;
    NSLog (@"inflasi per bulan = %f",inflasiPerBulan);
    
    float satuPlusInflasiPerBulan = (1+inflasiPerBulan);
    float infestasipowmonths = pow(satuPlusInflasiPerBulan,months);
    float c = hargakendaraan;
    //float hargaKendaraan = c;
    //CGFloat strHargaKendaraan = (CGFloat)[hargaKendaraan floatValue];
    float jumlahDanaDP = infestasipowmonths*c*dp;
    
    NSLog(@"jumlah dp:%f",jumlahDanaDP);
    NSLog(@"harga kendaraan :%f",c);
    NSLog(@"investasi pow months:%f",infestasipowmonths);
    

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
    
    float investasiSekarangSaham = jumlahDanaDP/pow(returnBulananSahamPlusSatu,months);
    float investasiSekarangCampuran = jumlahDanaDP/pow(returnBulananCampuranPlusSatu,months);
    float investasiSekarangPendapatanTetap = jumlahDanaDP/pow(returnPendapatanTetapPlusSatu,months);
    float investasiSekarangPasarUang = jumlahDanaDP/pow(returnPasarUangPlusSatu,months);
    
    float pow_temp = pow(returnBulananSahamPlusSatu,months);
    float pow1 = pow_temp-1;
    float part1 = (pow1 /returnBulananSaham)*returnBulananSahamPlusSatu;
    float investasiPerBulanSaham = jumlahDanaDP/part1;
    
    float pow_temp2 = pow(returnBulananCampuranPlusSatu,months);
    float pow2 = pow_temp2-1;
    float part2 = (pow2 /returnBulananCampuran)*returnBulananCampuranPlusSatu;
    float investasiPerBulanCampuran = jumlahDanaDP/part2;

    float pow_temp3 = pow(returnPendapatanTetapPlusSatu,months);
    float pow3 = pow_temp3-1;
    float part3 = (pow3/returnPendapatanTetap)*returnPendapatanTetapPlusSatu;
    float investasiPerBulanPendapatanTetap = jumlahDanaDP/part3;
    
    float pow_temp4 = pow(returnPasarUangPlusSatu,months);
    float pow4 = pow_temp4-1;
    float part4 = (pow4/returnPasarUang)*returnPasarUangPlusSatu;
    float investasiPerBulanPasarUang = jumlahDanaDP/part4;


    NSLog (@"investasi skrg saham:%f",jumlahDanaDP); 
    NSLog (@"return bulanan saham pow satu%f",pow1);
    NSLog (@"return bulanan saham%f",returnBulananSaham);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    
    
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:jumlahDanaDP]];
    
    labelDanaDP.text = numberAsString;
    
    NSString *numberAsString2 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiSekarangSaham]];
    NSString *numberAsString21 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiSekarangCampuran]];
    NSString *numberAsString22 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiSekarangPendapatanTetap]];
    NSString *numberAsString23 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiSekarangPasarUang]];
    NSString *numberAsString3 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiPerBulanSaham]];
    NSString *numberAsString31 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiPerBulanCampuran]];
    NSString *numberAsString32 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiPerBulanPendapatanTetap]];
    NSString *numberAsString33 = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:investasiPerBulanPasarUang]];
    
    if ([tipeReksadana isEqualToString:@"Reksa Dana Saham"])
    {
        labelInvestasiSekarang.text = numberAsString2;
         labelInvestasiPerBulan.text = numberAsString3;
    }
    if([tipeReksadana isEqualToString:@"Reksa Dana Campuran"])
    {
        labelInvestasiSekarang.text = numberAsString21;
        labelInvestasiPerBulan.text = numberAsString31;
    }
    if([tipeReksadana isEqualToString:@"Reksa Dana Campuran"])
    {
        labelInvestasiSekarang.text = numberAsString22;
        labelInvestasiPerBulan.text = numberAsString32;
    }
    if([tipeReksadana isEqualToString:@"Reksa Dana Pendapatan Tetap"])
    {
        labelInvestasiSekarang.text = numberAsString23;
        labelInvestasiPerBulan.text = numberAsString33;
    }
    
    
   // labelInvestasiPerBulan.text = numberAsString3;
    
    labelTanggalDPDiperlukan.text = tanggal;
    
    labelTipeReksaDana.text = tipeReksadana;


}

- (IBAction)back{
   // [self.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backbuttonpressed" object:self];

    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UISlider class]]) {
        // prevent recognizing touches on the slider
        return NO;
    }
    return NO;
}


@end
