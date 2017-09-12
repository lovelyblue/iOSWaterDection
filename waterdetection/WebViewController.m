//
//  WebViewController.m
//  waterdetection
//
//  Created by Lin Kuan Yu on 2017/9/12.
//  Copyright © 2017年 Lin Kuan Yu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *oWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString* address = [self readStringFromFile];
    if (address != NULL) {
        NSURL *url = [NSURL URLWithString:address];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_oWebView loadRequest:urlRequest];
    }
}
- (IBAction)logoutPressed:(id)sender {
    [self writeStringToFile:@""];
    [self performSegueWithIdentifier:@"showMain" sender:sender];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
