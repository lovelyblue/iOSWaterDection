//
//  BlankViewController.m
//  waterdetection
//
//  Created by Lin Kuan Yu on 2017/9/12.
//  Copyright © 2017年 Lin Kuan Yu. All rights reserved.
//7c.6c.69.96  <--yahoo

#import "BlankViewController.h"

@interface BlankViewController ()

@end

@implementation BlankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString* address = [self readStringFromFile];
    if (![address isEqualToString:@""] && address != NULL) {
        [self performSegueWithIdentifier:@"BtoWebView" sender:nil];
    }else
    {
        [self performSegueWithIdentifier:@"BtoMain" sender:nil];
    }
}

-(NSString *)readStringFromFile{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = @"textFile.txt";
    NSString *fileAtPath = [filePath stringByAppendingString:fileName];
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
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
