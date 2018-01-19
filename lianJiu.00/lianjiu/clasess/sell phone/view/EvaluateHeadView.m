

#import "EvaluateHeadView.h"

@implementation EvaluateHeadView


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
    self.headIV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*52);
    self.backIV.frame = CGRectMake(0, self.headIV.frame.origin.y+self.headIV.frame.size.height+4, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/320.0*153);
    
    self.leftIV.frame = CGRectMake(0, self.backIV.frame.origin.y+self.backIV.frame.size.height+4, [UIScreen mainScreen].bounds.size.width/320.0*105, [UIScreen mainScreen].bounds.size.width/320.0*94);
    self.centerIV.frame = CGRectMake(self.leftIV.frame.size.width+3, self.backIV.frame.origin.y+self.backIV.frame.size.height+4, [UIScreen mainScreen].bounds.size.width/320.0*105, [UIScreen mainScreen].bounds.size.width/320.0*94);
    
    
    self.rightIV.frame = CGRectMake(self.centerIV.frame.origin.x+self.centerIV.frame.size.width+2, self.backIV.frame.origin.y+self.backIV.frame.size.height+4, [UIScreen mainScreen].bounds.size.width/320.0*105, [UIScreen mainScreen].bounds.size.width/320.0*94);
    
    
    
    
    
    
    
    self.hsfsL.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.width/320.0*178, [UIScreen mainScreen].bounds.size.width-20, 20);
    
     self.pgBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*113, [UIScreen mainScreen].bounds.size.width/320.0*147, [UIScreen mainScreen].bounds.size.width/320.0*94,28);
    
    self.pgBtn.layer.borderWidth = 1.5;
    self.pgBtn.layer.cornerRadius = 4;;
    self.pgBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.priceL.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.width/320.0*118, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width/320.0*21);
    

     self.pgjgL.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.width/320.0*89, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.width/320.0*21);
    

}


@end
