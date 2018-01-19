


#import "ZSWViewController.h"

@interface ZSWViewController ()

@end

@implementation ZSWViewController
{
    UIWebView *webView ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    webView  = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:webView];
    
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
