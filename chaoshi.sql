SET NAMES UTF8;
DROP DATABASE IF EXISTS cs;
CREATE DATABASE cs CHARSET=UTF8;
USE cs;

#用户�?
CREATE TABLE users(
	uid INT PRIMARY KEY AUTO_INCREMENT,
	uname VARCHAR(32),
	upwd VARCHAR(32),
	email VARCHAR(64),
	phone VARCHAR(16),
	gender INT                  #性别  0-�? 1-�?
);

#商品类型�?
CREATE TABLE pro_laptop(
	lid INT PRIMARY KEY AUTO_INCREMENT,
	lname VARCHAR(64)
);

#商品�?
CREATE TABLE product(
	pid INT PRIMARY KEY AUTO_INCREMENT,
	lid INT,					#商品类型
	pname VARCHAR(32),			#商品名称
	title VARCHAR(128),         #标�
	sub_title varchar(128), 	#������
	price DECIMAL(10,2),        #价格
	shelf_time BIGINT,          #上架时间
	sold_count INT,             #已售出的数量
	is_onsale BOOLEAN,          #是否促销�?
	color VARCHAR(64),           #颜色
  size varchar(64),            #尺寸
  expire BOOLEAN,               #是否已经失效
	FOREIGN KEY(lid) REFERENCES pro_laptop(lid)
);

#轮播图表
CREATE TABLE index_carousel(
	cid INT PRIMARY KEY AUTO_INCREMENT,
	img VARCHAR(128),
  title VARCHAR(128)
);

#购物�?
CREATE TABLE shoppingcart_item(
	iid INT PRIMARY KEY AUTO_INCREMENT,
	uid INT,			#用户编号
	pid INT,			#商品编号
  size VARCHAR(128),
  color VARCHAR(32),
	count INT,			#购买数量
	is_checked BOOLEAN,	#是否已勾选，确定购买
	FOREIGN KEY(pid) REFERENCES product(pid),
	FOREIGN KEY(uid) REFERENCES users(uid)
);

#收货地址�?
CREATE TABLE receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓�?
  province VARCHAR(16),       #�?
  city VARCHAR(16),           #�?
  county VARCHAR(16),         #�?
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签�?
  is_default BOOLEAN,         #是否为当前用户的默认收货地址
  FOREIGN KEY(uid) REFERENCES users(uid)
);

#用户订单�?
CREATE TABLE orders(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,
  aid INT,
  status INT,             #订单状�? 1-等待付款  2-等待发货  3-运输�? 4-已签�? 5-已取�?
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT,    #签收时间
  FOREIGN KEY(uid) REFERENCES users(uid),
  FOREIGN KEY(aid) REFERENCES receiver_address(aid)
);

#用户订单
CREATE TABLE order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  oid INT,              #订单编号
  pid INT,              #产品编号
  count INT,            #购买数量
  FOREIGN KEY(oid) REFERENCES orders(oid),
  FOREIGN KEY(pid) REFERENCES product(pid)
);

#首页商品�?
CREATE TABLE index_product(
  pid INT,
  lid INT,
  title VARCHAR(64),
  pic VARCHAR(128),
  price DECIMAL(10,2),
  href VARCHAR(128),
  seq_recommended TINYINT,
  seq_new_arrival TINYINT,
  seq_top_sale TINYINT,
  expire Boolean
);
CREATE TABLE product_pic(
  pic INT PRIMARY KEY AUTO_INCREMENT,
  pid INT,              #��Ʒ���
  sm VARCHAR(128),            #СͼƬ·��
  md VARCHAR(128),            #��ͼƬ·��
  lg VARCHAR(128)             #��ͼƬ·��
);
CREATE TABLE admins(
	a_aid INT PRIMARY KEY AUTO_INCREMENT,
	aname varchar(16),
	auwpd varchar(12),
  gender Boolean,
  names  varchar(16),
  phone  varchar(16),
	grade  varchar(32),
  expire  Boolean
);

INSERT users VALUES
(null,'dingding',123456,'123@qq.com',15830466929,1),
(null,'lingling',123456,'234@qq.com',13410853280,1),
(null,'doudou',123456,'sun@qq.com',18301846570,0),
(null,'yaya',123456,'456@qq.com',18710242046,0);

INSERT admins VALUES
(null,'linqiang',234567,1,'林强','普通管理员',15830466925,0),
(null,'lilei',234567,0,'李蕾','普通管理员',15830476929,0),
(null,'hanmei',107825,0,'韩梅','超级管理员',15854466929,0);

INSERT pro_laptop VALUES
(null,'女装'),
(null,'男装'),
(null,'户外'),
(null,'美妆'),
(null,'母婴');

INSERT index_carousel VALUES
(null,'img/lunbo1.jpg',"轮播图"),
(null,'img/lunbo2.jpg',"轮播图"),
(null,'img/lunbo3.jpg',"轮播图");

INSERT index_product VALUES
(1,1,'茉莉雅集人手常备冰肌弹力 真丝打底衬裙MLDLQ056','img/beixin.jpg',146,'product-detail.html?pid=1',1,1,1,0),
(2,1,'Artka阿卡夏季新优雅复古仙气吊带显瘦气质雪纺连衣裙LA10388Q预','img/qun1.jpg',429,'product-detail.html?pid=2',1,1,1,0),
(3,1,'ARMANI JEANS阿玛尼新款2018夏牛仔裤aj时尚休闲贴布修身长裤','img/ku1.jpg',539,'product-detail.html?pid=3',1,1,1,0),
(4,1,'韩都衣舍2018韩版女装夏新款宽松小心机上衣chic短袖T恤JW11153筱','img/duan1.jpg',69,'product-detail.html?pid=4',1,1,1,0),
(1,1,'茉莉雅集人手常备冰肌弹力 真丝打底衬裙MLDLQ056','img/beixin.jpg',146,'product-detail.html?pid=1',1,1,1,0),
(2,1,'Artka阿卡夏季新优雅复古仙气吊带显瘦气质雪纺连衣裙LA10388Q预','img/qun1.jpg',429,'product-detail.html?pid=2',1,1,1,0),
(3,1,'ARMANI JEANS阿玛尼新款2018夏牛仔裤aj时尚女士休闲贴布修身长裤','img/ku1.jpg',539,'product-detail.html?pid=3',1,1,1,0),
(4,1,'韩都衣舍2018韩版女装夏新款宽松小心机上衣chic短袖T恤JW11153筱','img/duan1.jpg',69,'product-detail.html?pid=4',1,1,1,0),
(25,3,'英国品牌RABNEUTRINOENDJKT户外800篷白鹅绒男款连帽羽绒服QDN50','img/mian1.jpg',1499,'product-detail.html?pid=25',1,1,1,0),
(26,3,'icebreaker拓冰者春夏羊毛男士短袖速干POLO衫运动休闲衫150gm','img/duan2.jpg',519,'product-detail.html?pid=26',1,1,1,0),
(27,3,'凯乐石户外男款格型快干短袖KG610118速干衬衣透气格子衬衫','img/duan3.jpg',519,'product-detail.html?pid=27',1,1,1,0),
(28,3,'NIAN JEEP户外速干裤男夏季薄款冲锋裤透气大码快干长裤登山裤男','img/ku2.jpg',86,'product-detail.html?pid=28',1,1,1,0),
(25,3,'英国品牌RABNEUTRINOENDJKT户外800篷白鹅绒男款连帽羽绒服QDN50','img/mian1.jpg',1499,'product-detail.html?pid=25',1,1,1,0),
(26,3,'icebreaker拓冰者春夏羊毛男士短袖速干POLO衫运动休闲衫150gm','img/duan2.jpg',519,'product-detail.html?pid=26',1,1,1,0),
(27,3,'凯乐石户外男款格型快干短袖KG610118速干衬衣透气格子衬衫','img/duan3.jpg',519,'product-detail.html?pid=27',1,1,1,0),
(28,3,'NIAN JEEP户外速干裤男夏季薄款冲锋裤透气大码快干长裤登山裤男','img/ku2.jpg',86,'product-detail.html?pid=28',1,1,1,0),
(31,4,'Thayers津尔氏金缕梅玫瑰爽肤水女 补水保湿 喷雾二次清洁水','img/meiguishui.jpg',39,'product-detail.html?pid=31',1,1,1,0),
(32,4,'韩国theSAEM得鲜茶树油脸部温和清洁无刺激眼唇部卸妆水液乳学生','img/shui1.jpg',29,'product-detail.html?pid=32',1,1,1,0),
(33,4,'膜法世家绿豆清肌护肤套装清洁控油保湿护肤化妆品','img/shui2.jpg',90,'product-detail.html?pid=33',1,1,1,0),
(34,4,'凡士林美白身体乳保湿滋润香体持久全身补水润肤乳400ml女烟酰胺','img/ru1.jpg',55,'product-detail.html?pid=34',1,1,1,0),
(31,4,'Thayers津尔氏金缕梅玫瑰爽肤水女 补水保湿 喷雾二次清洁水','img/meiguishui.jpg',39,'product-detail.html?pid=31',1,1,1,0),
(32,4,'韩国theSAEM得鲜茶树油脸部温和清洁无刺激眼唇部卸妆水液乳学生','img/shui1.jpg',29,'product-detail.html?pid=32',1,1,1,0),
(33,4,'膜法世家绿豆清肌护肤套装清洁控油保湿护肤化妆品','img/shui2.jpg',90,'product-detail.html?pid=33',1,1,1,0),
(34,4,'凡士林美白身体乳保湿滋润香体持久全身补水润肤乳400ml女烟酰胺','img/ru1.jpg',55,'product-detail.html?pid=34',1,1,1,0);


INSERT product VALUES
(1,1,'衬裙','茉莉雅集人手常备冰肌弹力 真丝打底衬裙MLDLQ056','冰肌弹力真丝打底衬裙',146,150123456789,4560,false,'黑色,粉色','S,M,L',0),
(2,1,'连衣裙','Artka阿卡夏季新优雅复古仙气吊带显瘦气质雪纺连衣裙LA10388Q预','优雅复古仙气吊带显瘦气质',429,150123458789,2360,false,'水清','S,M,L',0),
(3,1,'裤子','ARMANI JEANS阿玛尼新款2018夏牛仔裤aj时尚休闲贴布修身长裤','时尚潮流 韩式休闲',539,150123458789,2220,false,'黑色','w30,W31,w32',0),
(4,1,'短袖','韩都衣舍2018韩版女装夏新款宽松小心机上衣chic短袖T恤JW11153筱','字母印花 个性破洞 宽松百搭',69,150123458789,2220,false,'黑色,黄色,白色,粉色','M,L',0),
(5,1,'短裙','半身裙2018新款女夏装不规则防走光衬衫格子裙韩版学生a字短裙潮','第二次元美少女不规则防走光衬衫格子半身裙',49,150123458789,154,false,'红黑,黑色,深蓝','S,M,L',0),
(6,1,'裤子','Artka阿卡夏季新蕾丝拼接印花高腰垂感开叉雪纺阔腿裤KA15082X预','开衩拼接蕾丝系带 度假浪漫',161.9,150123458789,456,false,'花','S,M,L',0),
(7,1,'短袖','乐町2018夏季新款t恤女短袖韩范chic红色上衣复古学生心机打底衫','爱心字母刺绣 醒目红色',109.5,150123458789,345,false,'红色','S,M,L',0),
(8,1,'裤子','【商场同款】哥弟女裤2018夏季新款高腰阔腿裤女七分休闲裤190062','哥弟招牌面料',400,150123458789,218,false,'黑色,藏蓝色','S,M,L',0),
(9,1,'裙子','拉夏贝尔雪纺连衣裙女夏2018新款名媛气质仙女裙短袖长裙碎花裙子','名媛气质仙女裙',299,150123458789,300,false,'印花','S,M,L',0),
(10,1,'短袖','乐町白色短袖t恤女ins超火的上衣2018夏装新款女装半袖绣花上衣潮','爱心字母刺绣 木耳边点缀',109.00,150123458789,255,false,'白色,墨绿','S,M,L',0),
(11,1,'短袖','诗凡黎2018夏季新款学生纯棉v领上衣体恤韩范宽松纯色短袖t恤女','100%棉 七色可选 柔软透气',125,150123458789,450,false,'黄色,卡其,白色,浅灰','M,L,XL',0),
(12,1,'连衣裙','糖力2018夏装新款裸色欧美甜美亮片星星网纱裙摆绑带吊带连衣裙女','新款裸色 甜美亮片星星网纱裙',296,150123458789,340,false,'裸色','XS,S,M,L',0),
(13,2,'裤子','花花公子夏季休闲裤男士超薄冰丝小脚裤韩版潮流九分裤修身小西裤','冰丝薄款花花公子九分裤 修身小西裤',116,150123458789,1000,false,'黑色,卡其,宝蓝','28,29,30',0),
(14,2,'短袖','Armani/阿玛尼夏季新款男士polo衫 商务休闲翻领短袖时尚简约T恤','商务休闲 低调奢华',435,150123458789,450,false,'黑色,白色','XS,S,M,L',0),
(15,2,'短袖','衬衫男士短袖夏季寸纯棉休闲修身韩版长袖2018新款潮7七分袖衬衣','活动期间 退换货运费',59,150123458789,210,false,'灰色,浅蓝,白色','XS,S,M,L',0),
(16,2,'裤子','男装 休闲九分裤(仿毛料) 407402 优衣库UNIQLO','初上市价格249元',149,150123458789,15,false,'灰色,藏青','S',0),
(17,2,'裤子','夏季薄款弹力破洞九分牛仔裤韩版潮流修身小脚裤男士休闲哈伦裤子','69一件，108两件，破洞九分！',59.10,150123458789,1050,false,'蓝色,黑色','27,28,29',0),
(18,2,'短袖','短袖男T恤2018夏季新款男士翻领半袖POLO衫韩版潮流百搭薄款衣服','可自由搭配 纯棉',62,150123458789,2015,false,'灰色,浅蓝,白色','M,L,XL',0),
(19,2,'短裤','亚麻短裤男裤子夏天宽松五分沙滩裤夏季男士七分裤棉麻休闲大裤衩','宽松五分沙滩裤',44.1,150123458789,1045,false,'黑色,藏青,卡其','M,L,XL',0),
(20,2,'短袖','Armani/阿玛尼新款男装AJ个性简约印花休闲时尚圆领短袖男士T恤','海外直供 香港菜鸟GFC仓发货',429,150123458789,675,false,'黑色,白色','M,L,XL',0),
(21,2,'裤子','裤子男士韩版潮流棉麻亚麻夏季港风宽松休闲运动小脚修身9九分裤','亚麻夏季港风 宽松休闲运动',79,150123458789,340,false,'黑色,灰色','M,L,XL',0),
(22,2,'短裤','男士夏季短裤男5五分裤韩版修身潮休闲宽松沙滩中裤子7七分裤夏天','韩版修身 休闲宽松沙滩',49,150123458789,123,false,'黑色,卡其','M,L,XL',0),
(23,3,'户外','法国伯希和户外皮肤衣男女防紫外线防晒衣轻薄透气防晒服运动风衣','UPF40+ 轻薄透气 时尚简约',142,150123458789,234,false,'浅粉,浅蓝,深灰','S,M,L',0),
(24,3,'户外','探路者皮肤风衣女男春夏新款情侣户外防风防泼水遮阳轻薄透气','防风防泼水遮阳 轻薄透气',119,150123458789,345,false,'粉女,蓝男','M,L,XL',0),
(25,3,'户外','英国品牌RABNEUTRINOENDJKT户外800篷白鹅绒男款连帽羽绒服QDN50','户外800篷白鹅绒',1499,150123458789,210,false,'红色','S,M,L',0),
(26,3,'户外','icebreaker拓冰者春夏羊毛男士短袖速干POLO衫运动休闲衫150gm','速干 运动休闲衫',774,150123458789,1204,false,'黑色,深蓝','M,L,XL',0),
(27,3,'户外','NIAN JEEP户外速干裤男夏季薄款冲锋裤透气大码快干长裤登山裤男','透气大码快干',86,150123458789,234,false,'深灰,军绿','M,L,XL',0),
(28,3,'户外','凯乐石户外男款格型快干短袖KG610118速干衬衣透气格子衬衫','透气 格子',199,150123458789,678,false,'蓝色','M,L,XL',0),
(29,3,'户外','德国波梵森皮肤衣户外春夏透气防晒衣男女防晒服轻薄运动皮肤风衣','全包边处理 防泼水 穿着凉爽舒适',89,150123458789,567,false,'粉红女,蓝灰男','M,L,XL',0),
(30,3,'户外','TECTOP探拓户外速干裤男夏季薄款运动快干裤徒步长裤弹力登山裤女','弹力速干透气',169,150123458789,679,false,'粉红女,黑色男','M,L,XL',0),
(31,4,'美妆','Thayers津尔氏金缕梅玫瑰爽肤水女 补水保湿 喷雾二次清洁水','清爽润肤 滋润不油腻',49,150123458789,789,false,'无','100ml,200ml',0),
(32,4,'美妆','韩国theSAEM得鲜茶树油脸部温和清洁无刺激眼唇部卸妆水液乳学生','温和清洁无刺激',43,150123458789,4507,false,'无','200ml,150ml',0),
(33,4,'美妆','膜法世家绿豆清肌护肤套装清洁控油保湿护肤化妆品','清肌护肤 控油保湿',249.9,150123458789,450,false,'无','500ml',0),
(34,4,'美妆','凡士林美白身体乳保湿滋润香体持久全身补水润肤乳400ml女烟酰胺','烟酰胺补水保湿滋润润肤乳',55,150123458789,236,false,'无','400ml',0),
(35,4,'美妆','丸美弹力蛋白精华晚霜50g 提拉紧致 美妆正品专卖 保湿补水','抚平肌肤细纹 紧致面部轮廓 夜间滋养',201,150123458789,456,false,'无','50g',0),
(36,4,'美妆','DHC橄榄滋养套装 卸妆洁面滋润呵护基础护肤化妆品美妆官方直售','深层清洁 滋润保湿',529,150123458789,2340,false,'无','400ml',0),
(37,4,'美妆','草木之心薄棉卸妆棉双面压边省水卸妆化妆美妆美容工具200片','双面设计 棉絮不残留',29.9,150123458789,456,false,'无','200',0),
(41,5,'母婴','巴拉巴拉童装小童宝宝连衣裙夏装2018新款甜美漏肩裙洋气裙子','纯棉面料；落肩设计，个性时尚',119,150123458789,456,false,'白蓝,白黑','90cm,100cm',0),
(42,5,'母婴','davebella戴维贝拉2018夏装新款连衣裙 宝宝网纱裙 DB7536','时尚网纱拼接设计 蝴蝶结点缀 蓬松有型',159,150123458789,2340,false,'烟紫','66cm,73cm',0),
(43,5,'母婴','美德乐250ML婴儿储奶瓶 奶瓶PP2个装 大容量储奶 配件 标准口径','食品级材质专业安全 防裂防摔 可冷藏冷冻',115,150123458789,456,false,'黄','250ml',0)
;

INSERT product_pic VALUES
(null,1,'img/product/sm/a1.jpg','img/product/md/a1.jpg','img/product/lg/a1.jpg'),
(null,1,'img/product/sm/a2.jpg','img/product/md/a1.jpg','img/product/lg/a2.jpg'),
(null,2,'img/product/sm/b1.jpg','img/product/md/b1.jpg','img/product/lg/b1.jpg'),
(null,2,'img/product/sm/b2.jpg','img/product/md/b1.jpg','img/product/lg/b2.jpg'),
(null,2,'img/product/sm/b3.jpg','img/product/md/b1.jpg','img/product/lg/b3.jpg'),
(null,3,'img/product/sm/c1.jpg','img/product/md/c1.jpg','img/product/lg/c1.jpg'),
(null,3,'img/product/sm/c2.jpg','img/product/md/c1.jpg','img/product/lg/c2.jpg'),
(null,3,'img/product/sm/c3.jpg','img/product/md/c1.jpg','img/product/lg/c3.jpg'),
(null,4,'img/product/sm/duan1.jpg','img/product/md/duan1.jpg','img/product/lg/duan1.jpg'),
(null,4,'img/product/sm/duan2.jpg','img/product/md/duan1.jpg','img/product/lg/duan2.jpg'),
(null,4,'img/product/sm/duan3.jpg','img/product/md/duan1.jpg','img/product/lg/duan3.jpg'),
(null,5,'img/product/sm/d1.jpg','img/product/md/d1.jpg','img/product/lg/d1.jpg'),
(null,5,'img/product/sm/d2.jpg','img/product/md/d1.jpg','img/product/lg/d2.jpg'),
(null,6,'img/product/sm/e1.jpg','img/product/md/e1.jpg','img/product/lg/e1.jpg'),
(null,6,'img/product/sm/e2.jpg','img/product/md/e1.jpg','img/product/lg/e2.jpg'),
(null,6,'img/product/sm/e3.jpg','img/product/md/e1.jpg','img/product/lg/e3.jpg'),
(null,7,'img/product/sm/f1.jpg','img/product/md/f1.jpg','img/product/lg/f1.jpg'),
(null,7,'img/product/sm/f2.jpg','img/product/md/f1.jpg','img/product/lg/f2.jpg'),
(null,7,'img/product/sm/f3.jpg','img/product/md/f1.jpg','img/product/lg/f3.jpg'),
(null,8,'img/product/sm/g1.jpg','img/product/md/g1.jpg','img/product/lg/g1.jpg'),
(null,8,'img/product/sm/g2.jpg','img/product/md/g1.jpg','img/product/lg/g2.jpg'),
(null,8,'img/product/sm/g3.jpg','img/product/md/g1.jpg','img/product/lg/g3.jpg'),
(null,9,'img/product/sm/h1.jpg','img/product/md/h1.jpg','img/product/lg/h1.jpg'),
(null,9,'img/product/sm/h2.jpg','img/product/md/h1.jpg','img/product/lg/h2.jpg'),
(null,9,'img/product/sm/h3.jpg','img/product/md/h1.jpg','img/product/lg/h3.jpg'),
(null,10,'img/product/sm/i1.jpg','img/product/md/i1.jpg','img/product/lg/i1.jpg'),
(null,10,'img/product/sm/i2.jpg','img/product/md/i1.jpg','img/product/lg/i2.jpg'),
(null,10,'img/product/sm/i3.jpg','img/product/md/i1.jpg','img/product/lg/i3.jpg'),
(null,11,'img/product/sm/j1.jpg','img/product/md/j1.jpg','img/product/lg/j1.jpg'),
(null,11,'img/product/sm/j2.jpg','img/product/md/j1.jpg','img/product/lg/j2.jpg'),
(null,11,'img/product/sm/j3.jpg','img/product/md/j1.jpg','img/product/lg/j3.jpg'),
(null,12,'img/product/sm/k1.jpg','img/product/md/k1.jpg','img/product/lg/k1.jpg'),
(null,12,'img/product/sm/k2.jpg','img/product/md/k1.jpg','img/product/lg/k2.jpg'),
(null,12,'img/product/sm/k3.jpg','img/product/md/k1.jpg','img/product/lg/k3.jpg'),
(null,13,'img/product/sm/l1.jpg','img/product/md/l1.jpg','img/product/lg/l1.jpg'),
(null,13,'img/product/sm/l2.jpg','img/product/md/l1.jpg','img/product/lg/l2.jpg'),
(null,13,'img/product/sm/l3.jpg','img/product/md/l1.jpg','img/product/lg/l3.jpg'),
(null,14,'img/product/sm/m1.jpg','img/product/md/m1.jpg','img/product/lg/m1.jpg'),
(null,14,'img/product/sm/m2.jpg','img/product/md/m1.jpg','img/product/lg/m2.jpg'),
(null,15,'img/product/sm/n1.jpg','img/product/md/n1.jpg','img/product/lg/n1.jpg'),
(null,15,'img/product/sm/n2.jpg','img/product/md/n1.jpg','img/product/lg/n2.jpg'),
(null,15,'img/product/sm/n3.jpg','img/product/md/n1.jpg','img/product/lg/n3.jpg'),
(null,16,'img/product/sm/o1.jpg','img/product/md/o1.jpg','img/product/lg/o1.jpg'),
(null,16,'img/product/sm/o2.jpg','img/product/md/o1.jpg','img/product/lg/o2.jpg'),
(null,16,'img/product/sm/o3.jpg','img/product/md/o1.jpg','img/product/lg/o3.jpg'),
(null,17,'img/product/sm/p1.jpg','img/product/md/p1.jpg','img/product/lg/p1.jpg'),
(null,17,'img/product/sm/p2.jpg','img/product/md/p1.jpg','img/product/lg/p2.jpg'),
(null,17,'img/product/sm/p3.jpg','img/product/md/p1.jpg','img/product/lg/p3.jpg'),
(null,18,'img/product/sm/q1.jpg','img/product/md/q1.jpg','img/product/lg/q1.jpg'),
(null,18,'img/product/sm/q2.jpg','img/product/md/q1.jpg','img/product/lg/q2.jpg'),
(null,18,'img/product/sm/q3.jpg','img/product/md/q1.jpg','img/product/lg/q3.jpg'),
(null,19,'img/product/sm/r1.jpg','img/product/md/r1.jpg','img/product/lg/r1.jpg'),
(null,19,'img/product/sm/r2.jpg','img/product/md/r1.jpg','img/product/lg/r2.jpg'),
(null,20,'img/product/sm/s1.jpg','img/product/md/s1.jpg','img/product/lg/s1.jpg'),
(null,20,'img/product/sm/s2.jpg','img/product/md/s1.jpg','img/product/lg/s2.jpg'),
(null,21,'img/product/sm/t1.jpg','img/product/md/t1.jpg','img/product/lg/t1.jpg'),
(null,21,'img/product/sm/t2.jpg','img/product/md/t1.jpg','img/product/lg/t2.jpg'),
(null,22,'img/product/sm/u1.jpg','img/product/md/u1.jpg','img/product/lg/u1.jpg'),
(null,22,'img/product/sm/u2.jpg','img/product/md/u1.jpg','img/product/lg/u2.jpg'),
(null,23,'img/product/sm/v1.jpg','img/product/md/v1.jpg','img/product/lg/v1.jpg'),
(null,23,'img/product/sm/v2.jpg','img/product/md/v1.jpg','img/product/lg/v2.jpg'),
(null,24,'img/product/sm/w1.jpg','img/product/md/w1.jpg','img/product/lg/w1.jpg'),
(null,24,'img/product/sm/w2.jpg','img/product/md/w1.jpg','img/product/lg/w2.jpg'),
(null,25,'img/product/sm/x1.jpg','img/product/md/x1.jpg','img/product/lg/x1.jpg'),
(null,25,'img/product/sm/x2.jpg','img/product/md/x1.jpg','img/product/lg/x2.jpg'),
(null,26,'img/product/sm/y1.jpg','img/product/md/y1.jpg','img/product/lg/y1.jpg'),
(null,26,'img/product/sm/y2.jpg','img/product/md/y1.jpg','img/product/lg/y2.jpg'),
(null,27,'img/product/sm/z1.jpg','img/product/md/z1.jpg','img/product/lg/z1.jpg'),
(null,27,'img/product/sm/z2.jpg','img/product/md/z1.jpg','img/product/lg/z2.jpg'),
(null,28,'img/product/sm/la1.jpg','img/product/md/la1.jpg','img/product/lg/la1.jpg'),
(null,28,'img/product/sm/la2.jpg','img/product/md/la1.jpg','img/product/lg/la2.jpg'),
(null,29,'img/product/sm/yun1.jpg','img/product/md/yun1.jpg','img/product/lg/yun1.jpg'),
(null,29,'img/product/sm/yun2.jpg','img/product/md/yun1.jpg','img/product/lg/yun2.jpg'),
(null,30,'img/product/sm/gan1.jpg','img/product/md/gan1.jpg','img/product/lg/gan1.jpg'),
(null,30,'img/product/sm/gan2.jpg','img/product/md/gan1.jpg','img/product/lg/gan2.jpg'),
(null,31,'img/product/sm/shuang1.jpg','img/product/md/shuang1.jpg','img/product/lg/shuang1.jpg'),
(null,31,'img/product/sm/shuang2.jpg','img/product/md/shuang1.jpg','img/product/lg/shuang2.jpg'),
(null,32,'img/product/sm/seam1.jpg','img/product/md/seam1.jpg','img/product/lg/seam1.jpg'),
(null,32,'img/product/sm/seam2.jpg','img/product/md/seam1.jpg','img/product/lg/seam2.jpg'),
(null,33,'img/product/sm/mo1.jpg','img/product/md/mo1.jpg','img/product/lg/mo1.jpg'),
(null,33,'img/product/sm/mo2.jpg','img/product/md/mo1.jpg','img/product/lg/mo2.jpg'),
(null,34,'img/product/sm/ru1.jpg','img/product/md/ru1.jpg','img/product/lg/ru1.jpg'),
(null,34,'img/product/sm/ru2.jpg','img/product/md/ru1.jpg','img/product/lg/ru2.jpg'),
(null,35,'img/product/sm/yan1.jpg','img/product/md/yan1.jpg','img/product/lg/yan1.jpg'),
(null,35,'img/product/sm/yan2.jpg','img/product/md/yan1.jpg','img/product/lg/yan2.jpg'),
(null,36,'img/product/sm/xie1.jpg','img/product/md/xie1.jpg','img/product/lg/xie1.jpg'),
(null,36,'img/product/sm/xie2.jpg','img/product/md/xie1.jpg','img/product/lg/xie2.jpg'),
(null,37,'img/product/sm/mian1.jpg','img/product/md/mian1.jpg','img/product/lg/mian1.jpg'),
(null,37,'img/product/sm/mian2.jpg','img/product/md/mian1.jpg','img/product/lg/mian2.jpg'),
(null,41,'img/product/sm/ba1.jpg','img/product/md/ba1.jpg','img/product/lg/ba1.jpg'),
(null,41,'img/product/sm/ba2.jpg','img/product/md/ba1.jpg','img/product/lg/ba2.jpg'),
(null,42,'img/product/sm/bao1.jpg','img/product/md/bao1.jpg','img/product/lg/bao1.jpg'),
(null,42,'img/product/sm/bao2.jpg','img/product/md/bao1.jpg','img/product/lg/bao2.jpg'),
(null,43,'img/product/sm/nai1.jpg','img/product/md/nai1.jpg','img/product/lg/nai1.jpg'),
(null,43,'img/product/sm/nai2.jpg','img/product/md/nai1.jpg','img/product/lg/nai2.jpg')
;
INSERT shoppingcart_item VALUES (null,1,4,'S','黄色',2,0);