# LBScrollLabel


**效果**

![](http://www.luobbe.com/content/images/2015/09/scrollLabel.gif)

**使用**

```
LBScrollLabel *tempLB = [[LBScrollLabel alloc] initWithFrame:CGRectMake(20, 100, CGRectGetWidth(self.view.frame) - 40, 30)];
tempLB.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green
tempLB.text = @"Scroll label, from bottom to top!";
[tempLB beginScrollWithDirection:LBScrollLabelDirection_Top];
[self.view addSubview:tempLB];

```