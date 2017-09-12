//
//  ViewController.m
//  waterdetection
//
//  Created by Lin Kuan Yu on 2017/8/27.
//  Copyright © 2017年 Lin Kuan Yu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myAddress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)callAlert:(NSString*)title andMessage:(NSString*)msg andConfirmButtonTitle:(NSString*)btnTitle
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:btnTitle
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnConfirmPressed:(id)sender {
    NSString * strAddress = [_myAddress text];
    NSMutableString* strDecAddress;
    BOOL isSegueToNextPage = NO;
    if (strAddress.length < 10) {
        [self callAlert:@"輸入錯誤" andMessage:@"長度太短" andConfirmButtonTitle:@"確定"];
        return;
    }
    
    unsigned int iAdd1 = 0;
    unsigned int iAdd2 = 0;
    unsigned int iAdd3 = 0;
    unsigned int iAdd4 = 0;
    
    @try {
        NSString* add1 = [strAddress  substringWithRange:NSMakeRange(0, 2)];
        NSString* add2 = [strAddress  substringWithRange:NSMakeRange(2, 2)];
        NSString* add3 = [strAddress  substringWithRange:NSMakeRange(4, 2)];
        NSString* add4 = [strAddress  substringWithRange:NSMakeRange(6, 2)];
        NSString* port5 = [strAddress  substringWithRange:NSMakeRange(8, 2)];
        
        [[NSScanner scannerWithString:add1] scanHexInt:&iAdd1];
        [[NSScanner scannerWithString:add2] scanHexInt:&iAdd2];
        [[NSScanner scannerWithString:add3] scanHexInt:&iAdd3];
        [[NSScanner scannerWithString:add4] scanHexInt:&iAdd4];
        
        if ([port5 isEqualToString:@"00"]) {
            strDecAddress = [NSMutableString stringWithFormat:@"http://%i.%i.%i.%i/",iAdd1,iAdd2,iAdd3,iAdd4];
        }else{
            strDecAddress = [NSMutableString stringWithFormat:@"http://%i.%i.%i.%i:%@/",iAdd1,iAdd2,iAdd3,iAdd4,port5];
        }
        
//        [self writeFile:strDecAddress];
        [self writeStringToFile:strDecAddress];
        
        NSString* readFiel = [self readStringFromFile];
        
        isSegueToNextPage = YES;
    } @catch (NSException *exception) {
        [self callAlert:@"輸入錯誤" andMessage:@"格式錯誤" andConfirmButtonTitle:@"確定"];
    } @finally {
        
    }
    
    if (isSegueToNextPage) {
        [self performSegueWithIdentifier:@"ShowWebView" sender:sender];
    }
    
}


-(void) writeStringToFile:(NSString *)aString{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = @"textFile.txt";
    NSString *fileAtPath = [filePath stringByAppendingString:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}

-(NSString *)readStringFromFile{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = @"textFile.txt";
    NSString *fileAtPath = [filePath stringByAppendingString:fileName];
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

@end
