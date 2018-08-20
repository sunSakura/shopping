window.onload=function(){
    var lists=document.getElementById('lists');
    var lunbo=document.getElementById('lunbo');

    function animate(){
        var juli=parseInt(lists.style.left)-1180;
        lists.style.left=juli+"px";

        if(juli<-2360){
            lists.style.left=0+"px";
        }
        if(juli>0){
            lists.style.left=-2360+"px";
        }
        console.log(juli);
    }
    var timer;
    function play(){
        timer=setInterval(function(){animate();},3000)
    }
    play();
    function stop(){
        clearInterval(timer);
    }
    lunbo.onmousemove=stop;
    lunbo.onmouseout=play;
};

//数据库中读取轮播图数据
(()=>{
    console.log(123);
    ajax("get","data/lunbo.php","")
    .then(data=>{
        var htmlImg="";
        for(var p of data){
            htmlImg +=`<li>
              <img src=${p[1]}>
          </li> `;
        }
        $('#lists').html(htmlImg)
    })
})();

//每个楼层的数据读取
(()=>{
    ajax("get","data/product/floor.php","")
     .then(output=>{
        var html="";
        var f1=output.f1;
        for(i=0;i<f1.length;i++){
            var p=f1[i];
            html +=`<a href=${p[5]}>
                        <div class="detail">
                        <img src=${p[3]} alt="">
                        <div class="title">${p[2]}</div>
                        <div class="price">￥${p[4]}</div>
                        </div>
                    </a>`;
        }
        $('#f1').html(html);

        var html="";
        var f2=output.f2;
        for(i=0;i<f2.length;i++){
            var p=f2[i];
            html +=`<a href=${p[5]}>
                        <div class="detail">
                        <img src=${p[3]} alt="">
                        <div class="title">${p[2]}</div>
                        <div class="price">￥${p[4]}</div>
                        </div>
                    </a>`;
        }
        $('#f2').html(html); 

        var html="";
        var f3=output.f3;
        for(i=0;i<f3.length;i++){
            var p=f3[i];
            html +=`<a href=${p[5]}>
                        <div class="detail">
                        <img src=${p[3]} alt="">
                        <div class="title">${p[2]}</div>
                        <div class="price">￥${p[4]}</div>
                        </div>
                    </a>`;
        }
        $('#f3').html(html); 
     })
 })();