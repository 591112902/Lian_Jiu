//
//  CategoryTableCell.h
//  RGCategoryView
//
//  Created by Arvin on 15/10/28.
//  Copyright © 2015年 com.roroge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface CategoryTableCellFirst : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *rmtjLabel;





-(void)configCellWithTitle:(NSDictionary *)dataDic andIndexPath:(NSIndexPath *)indexPath andSelectIndexPath:(NSIndexPath *)selectIndexPath;

@end
