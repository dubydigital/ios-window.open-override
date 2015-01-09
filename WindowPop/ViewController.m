//
//  ViewController.m
//  WindowPop
//
//  Created by Mark Dubouzet on 1/8/15.
//  Copyright (c) 2015 Mark Dubouzet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSURL *url = [[NSURL alloc] initWithString:@"http://www.dubydigital.com"];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    [self.webView setDelegate:self];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"scheme: %@ url: %@ ", [[request URL] scheme], [[request URL] absoluteString]);
    if([[[request URL] scheme] isEqualToString:@"http"]){
        return NO;
    }
    return  YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"var kimbo = window.open = function"];
    
    NSString * scriptString =
    @"window.open = function (open) {           \n"
    "  return function (url, name, features) {     \n"
    "    return open.call(window, 'xxx:'+url, name, features);   \n"
    "};                              \n"
    "}(window.open); ";
    [webView stringByEvaluatingJavaScriptFromString:scriptString];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
