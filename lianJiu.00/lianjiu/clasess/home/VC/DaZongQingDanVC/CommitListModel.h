

#import <Foundation/Foundation.h>

@interface CommitListModel : NSObject

@property(nonatomic,copy)NSString *bulkItemId;//
@property(nonatomic,copy)NSString *bulkItemName;
@property(nonatomic,copy)NSString *bulkItemProductId;//
@property(nonatomic,copy)NSString *bulkItemPrice;//货物清单的单价
@property(nonatomic,copy)NSString *bulkItemAccountPrice;
@property(nonatomic,copy)NSString *bulkItemNum;//货物清单的数量
@property(nonatomic,copy)NSString *bulkItemCreated;


@property(nonatomic,copy)NSNumber *bulkItemUnit;
@property(nonatomic,copy)NSNumber *bulkItemVolume;




@property(nonatomic,copy)NSString *bulkItemPriceCurrent;//交货清单的单价
@property(nonatomic,copy)NSString *bulkItemNumModify;//交货清单的数量



+(instancetype)ModelWith:(NSDictionary *)dic;

@end
