

#import "JDEvaluateHeadView.h"

@implementation JDEvaluateHeadView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 
 
 
- (void)drawRect:(CGRect)rect {
    
    self.backIV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*153);
    
    
    
    self.hsfsL.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.width/320.0*121, [UIScreen mainScreen].bounds.size.width-20, 21);
    
     self.pgBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*113, [UIScreen mainScreen].bounds.size.width/320.0*90, [UIScreen mainScreen].bounds.size.width/320.0*94,28);
    
    self.pgBtn.layer.borderWidth = 1.5;
    self.pgBtn.layer.cornerRadius = 4;;
    self.pgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.priceL.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.width/320.0*61, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width/320.0*21);
    

     self.pgjgL.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.width/320.0*32, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width/320.0*21);
    

}


@end
