

#import "SetUpListHeadView.h"

@implementation SetUpListHeadView


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
    self.headLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 0, [UIScreen mainScreen].bounds.size.width/320.0*304, 1);
    self.rightLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*312, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.bottomLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 34, [UIScreen mainScreen].bounds.size.width/320.0*304, 1);
    self.cneter1Line.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*109, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.leftLine.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.center2Line.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*210, 0, [UIScreen mainScreen].bounds.size.width/320.0*1, 35);
    self.h0L.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*8, 0, [UIScreen mainScreen].bounds.size.width/320.0*102, 35);
    self.h1L.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*109, 0, [UIScreen mainScreen].bounds.size.width/320.0*102, 35);
    self.h2L.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/320.0*210, 0, [UIScreen mainScreen].bounds.size.width/320.0*102, 35);
    

}


@end
