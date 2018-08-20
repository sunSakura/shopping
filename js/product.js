$('#pagination').on('click', 'li a', function(e){
    e.preventDefault();
    loadpage($(this).attr('href'));
  })
function loadpage(pno=0){
    var kw=location.search.split("=")[1]||"";
    console.log(kw);
    ajax("get","data/product/product.php?kw="+kw+"&pno="+pno,"")
    .then(output=>{
            var data=output.data;
            var html="";
            console.log(data);
            for(var p of data){
                html +=`<div class="product-wai">
                <div class="product">
                    <a href="product-detail.html?lid=${p.pid}">
                        <img src="${p.md}" alt="">
                    </a>
                    <p class="price">¥${p.price}</p>
                    <a href="product-detail.html?lid=${p.pid}">
                        <p class="title">${p.title}</p>
                    </a>
                    <div class="hr"></div>
                    <p class="count">成交量&emsp;<span>${p.sold_count}笔</span></p>
                </div>
            </div>`;
            }
            $('.products').html(html);
              html = '';
              html += `<li class="${output.pageNo<=1?'disabled':''}"><a href="${output.pageNo1?output.pageNo-1:'#'}">上一页</a></li>`;
            //   if(output.pageNo-2>0){
            //     html += `<li><a href="${output.pageNo-2}">${output.pageNo-2}</a></li>`;
            //   }
            //   if(output.pageNo-1>0){
            //     html += `<li><a href="${output.pageNo-1}">${output.pageNo-1}</a></li>`;
            //   }
              html += `<li class="active"><a href="${output.pageNo}">${parseInt(output.pageNo)+1}</a></li>`;
            //   if(output.pageNo+1<=output.pageCount){
            //     html += `<li><a href="${output.pageNo+1}">${output.pageNo+1}</a></li>`;
            //   }
            //   if(output.pageNo+2<=output.pageCount){
            //     html += `<li><a href="${output.pageNo+2}">${output.pageNo+2}</a></li>`;
            //   }
              html += `<li class="${output.pageNo>=output.pageCount?'disabled':''}"><a href="${output.pageNo<output.pageCount-1?output.pageNo+1:'#'}">下一页</a></li>`;
              $('#pagination').html(html);
        }
    )
}
loadpage();