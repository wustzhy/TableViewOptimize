# TableViewOptimize

带圆角图片4种(高、低性能)处理方式，实测

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    ZYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID
                                             cellSize:CGSizeMake(self.frame.size.width, _cellHeight)];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];

    switch (_cellType) {
        case ZCellType_localImage_GloabalQueueCorner:   // FPS>55 微抖
        {
            
            // --------------- way_1 --------------- //
            // ----- use globalQueue 👇
            // simulator:   imageView != Color Blended Layer , 绿色
            // device:      FPS 估计57 , 微小抖
            
            [ZYTool zy_getCornerImageWith:[UIImage imageNamed:@"imagee"]
                                fillColor:[UIColor whiteColor]
                                   ivSize:cell.imageView1.bounds.size
                                 complete:^(UIImage *image) {
                                     
                                     [cell.imageView1 setImage:image];

                                 }];
            [ZYTool zy_getCornerImageWith:[UIImage imageNamed:@"imagee"]
                                fillColor:[UIColor whiteColor]
                                   ivSize:cell.imageView2.bounds.size
                                 complete:^(UIImage *image) {
                                     
                                     [cell.imageView2 setImage:image];
                                     
                                 }];

        }
            break;
            
        case ZCellType_cornerRadius:    // 无网络图 , 本地图 , 流畅
        {
            
            // --------------- way_2 --------------- //
            // simulator:   imageView = Color Blended Layer , 红色(同UILabel)
            // device:      FPS = 流畅
            [cell.imageView1 setImage:[UIImage imageNamed:@"imagee"]];
            cell.imageView1.layer.cornerRadius = cell.imageView1.bounds.size.height/2;
            cell.imageView1.layer.masksToBounds = YES;
            
            [cell.imageView2 setImage:[UIImage imageNamed:@"imagee"]];
            cell.imageView2.layer.cornerRadius = cell.imageView2.bounds.size.height/2;
            cell.imageView2.layer.masksToBounds = YES;
            
        }
            break;
        case ZCellType_webImageMainQueueLoad:       // 卡顿明显 FPS<50
        {
            UIImage * image1 = [self loadImageWithUrlStr:self.urlStrArray[indexPath.row%self.urlStrArray.count]];
            UIImage * image2 = [self loadImageWithUrlStr:self.urlStrArray[self.urlStrArray.count-1 - indexPath.row%self.urlStrArray.count]];
            
            cell.imageView1.image = image1;
            cell.imageView2.image = image2;
        }
            break;
            
        case ZCellType_webImageYYCorner:    // FPS >55 微抖
        {
            
            [cell.imageView1 yy_setImageWithURL:[NSURL URLWithString:self.urlStrArray[indexPath.row%self.urlStrArray.count]]
                                    placeholder:[UIImage imageNamed:@"imagee"]
                                        options:kNilOptions
                                     completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                         NSLog(@"image1 finished == %@",image);
                                     }];
            
            [cell.imageView2 yy_setImageWithURL:[NSURL URLWithString:self.urlStrArray[self.urlStrArray.count-1 - indexPath.row%self.urlStrArray.count]]
                                    placeholder:[UIImage imageNamed:@"imagee"]
                                        options:kNilOptions
                                       progress:nil
                                      transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                          NSLog(@"image before transform == %@",image);
                                          return [image yy_imageByRoundCornerRadius:image.size.height/2];
                                      }
                                     completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                         NSLog(@"image2 finished == %@",image);
                                     }];
            
        }
            break;
            
        default:
            break;
    }

    
    return cell;
}
```
