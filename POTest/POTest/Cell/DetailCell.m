
//  Created by Henry.
//  Copyright © 2021 . All rights reserved.
//

#import "DetailCell.h"
#import "Util.h"

@interface DetailCell()

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *poIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [_iconImageView setImage:[UIImage imageNamed:@"po"]];
}

// MARK: - Statics
+ (NSString*)identifier {
    return NSStringFromClass([DetailCell class]);
}

// MARK: - Object
- (void)updateWithPOID:(double)poId
                items:(double)items
       lastUpdatedData:(NSString*)last_update_date{
    
    _poIdLabel.text = [NSString stringWithFormat:@"ID: %1.0f", poId];
    _itemLabel.text = [NSString stringWithFormat:@"Number of Items: %1.0f", items];
    _dataLabel.text =  [NSString stringWithFormat:@"Last updated: %@", [Util setDateWithString:last_update_date]];
    [_iconImageView setImage:[UIImage imageNamed:@"po"]];
  

}

// MARK: - Helper
- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _borderView.layer.borderWidth = 0.5;
    _borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _borderView.layer.cornerRadius = 4;
}



@end
