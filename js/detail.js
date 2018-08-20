//加载商品详细信息
$.ajax({
    url:"data/product-detail/product-detail.php",
    data:{pid:location.search.split('=')[1]},
    success:function(data){
        var details=data.product;
        var laptop=data.laptop;
        $('#detail-right h3').html(details.title);
        $('#detail-right p').html(details.sub_title);
        var html="";
        html +=`<b>售价:</b>
            <span>￥${details.price}</span>`;
        $('#pro-price').html(html);

        $('#mimg').attr('src',laptop.pics[0].lg);
        html="";
        html +=`<ul>`;
        for(var pic of laptop.pics){
            html +=`
            <li><img src="${pic.sm}" data-md="${pic.md}" data-lg="${pic.lg}"></li>
            `;
        }
        html +='</ul>';
        console.log(html);
        $('#img-list').html(html);

        html="";
        var arr=details.size.split(',');
        html +=`<ul>
        <li style="margin-right:20px;">尺寸</li>`;
        for(var i =0;i<arr.length;i++){
            html +=` <li class="chicun">
            <a href="javascript:void(0)" role="button">
                <span>${arr[i]}</span>
            </a>
            </li>`;
            console.log(html);
        }
        html +=`</ul>`;
        $('#sizes').html(html);

        var child=$('#sizes li');
        for(var i=0;i<child.length;i++){
            var a = child[i];
            var size;
            a.index = i;//给每个className为child的元素添加index属性;
            a.onclick = function () {
                if(!$(this).hasClass('selected')){
                    $(this).addClass('selected').siblings().removeClass('selected');
                    size=$(this).find('span').text();
                    console.log(size);
                }
            }
        }

        html="";
        arr=[];
        arr=details.color.split(',');
        html +=`<ul>
        <li style="margin-right:20px;">颜色</li>`;
        for(var i =0;i<arr.length;i++){
            html +=` <li class="yanse">
                <a href="javascript:void(0)" role="button">
                    <span>${arr[i]}</span>
                </a>
                </li>`;
            console.log(html);
        }
        html +=`</ul>`;
        $('#colors').html(html);

        var color=$('#colors li');
        var colors;
        for(var i=0;i<color.length;i++){
            var a=color[i];
            var color;
            a.index=i;
            a.onclick=function(){
                if(!$(this).hasClass('selected')){
                    $(this).addClass('selected').siblings().removeClass('selected');
                    colors=$(this).find('span').text();
                    console.log(colors);
                } 
            }
        }
        $('body').on('click',"#add-cart,#add-buy",function(e){
            e.preventDefault();
            var buycount=$('#count').val();
            console.log(size,colors,buycount);
            $.ajax({
                type:"GET",
                url:"data/cart/add.php",
                data:{pid:location.search.split('=')[1],color:colors,size:size,count:buycount},
                success:function(result){
                    console.log(result);
                 if(result.code===0){
                        alertMsg('添加成功！');
                        $('#alertMsg_btn1').click(function () {
                            console.log(234);
                            location.href = 'cart.html';
                        });
                    }else{
                        alertMsg('添加失败');
                    }
                },
                error:function(){
                    console.log("网络连接故障");
                }
            })
        });

    },
    error:function(){
        console.log("网络连接错误");
    }
});
$('#img-list').on('click', 'li img', function(){
    console.log(123);
    $('#mimg').attr('src', $(this).data('lg'));
  })
//控制购买的数量
var count=$('#count').val() *1;
console.log(count);
//增加数量
$('#next').click(function(){
    $('#count').val(count +=1);
})
//减少数量
$('#prev').click(function(){
    if(count >1){
        $('#count').val(count -=1);
    }
});

//加入购物车
