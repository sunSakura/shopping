//加载购物车信息
$.ajax({
  url: 'data/cart/list.php',
  success: function (result) {
    if (result.code === -1) {
      alertMsg('您尚未登录！');
      $('#alertMsg_btn1').click(function () {
        location.href = 'login.html';
      });
    } else{
        var html = '';
        for(var l of result){
          console.log(234);
          html += `
            <div class="imfor">
              <div class="check">
                <div class="Each">
                              <span class="normal">
                                  <img src="img/cart/product_normal.png" alt=""/>
                              </span>
                  <input type="hidden" name="lid" value="${l.pid}">
                </div>
              </div>
              <div class="pudc">
                <div class="pudc_information" id="${l.iid}">
                  <a href="product-detail.html?pid=${l.pid}"><img src="${l.sm}" class="lf" style="vertical-align:middle"/></a>
                  <input type="hidden" name="" value="">
                          <span class="des lf">
                              <a href="product-detail.html?pid=${l.pid}">${l.title}</a>
                                <input type="hidden" name="" value="">
                          </span>
                  <p class="col lf"><span>颜色：</span><span class="color_des">${l.color}  
                  <span>尺码：</span><span class="color_des">${l.size}  
                  <input type="hidden" name="" value=""></span></p>
                </div>
              </div>
              <div class="pices">
                <p class="pices_information"><b>￥</b><span>${l.price}  <input type="hidden" name="" value=""></span></p>
              </div>
              <div class="num"><span class="reduc">&nbsp;-&nbsp;</span><input type="text" value="${l.count}"><span class="add">&nbsp;+&nbsp;</span>
              </div>
              <div class="totle">
                <span>￥</span>
                <span class="totle_information">${l.price * l.count}</span>
              </div>
              <div class="del">
                <a href="javascript:;" class="del_d">删除</a>
              </div>
            </div>
          `;
        }
      $('#content_box_body').html(html);
    }
  },
  error:function(){
    console.log("网络连接错误");
  }
})

$(function () {
  
    if (!$(".imfor")) {
      $('#section').hide();
      $('.none').show();
    }
  
    adddel();
    $('.imfor').each(function () {
      var price = parseFloat($(this).children('.pices').children('.pices_information').children('span').html());
      var amount = parseFloat($(this).children('.num').children('input').val());
      var amountPrice = price * amount;
      $(this).children('.totle').children('.totle_information').html(amountPrice.toFixed(2));
    });
    //全选
    $(".all").click(function () {
      amountadd();
      if ($('.all>span').hasClass('normal')) {
        $('.all>span').addClass('true').removeClass('normal');
        $('.all>span>img').attr('src', 'img/cart/product_true.png');
        $(".Each>span").each(function () {
          $(this).addClass('true').removeClass('normal');
          $(this).children('img').attr('src', 'img/cart/product_true.png');
        })
  
        totl();
      } else {
        $('.all>span').addClass('normal').removeClass('true');
        $('.all>span>img').attr('src', 'img/cart/product_normal.png');
        $('.Each>span').addClass('normal').removeClass('true');
        $('.Each>span>img').attr('src', 'img/cart/product_normal.png');
        $(".susum").text(0.00);
        $(".susumOne").text(0.00);
        $('.total').text(0);
        $('.totalOne').text(0);
      }
    })
    //单选
    $('#content_box_body').on('click', '.Each>span', function () {
      amountadd();
    $('.all>span').addClass('normal').removeClass('true');
    $('.all>span>img').attr('src', 'img/cart/product_normal.png');
      if ($(this).hasClass('normal')) {
        $(this).addClass('true').removeClass('normal');
        $(this).children('img').attr('src', 'img/cart/product_true.png');
        var amou = parseInt($('.total').text());
        amou++;
        $('.total').text(amou);
        $('.totalOne').text(amou);
        amountadd();
        var iid = $(this).parent().parent().siblings('.pudc').children('.pudc_information').attr('id');
        $.ajax({
          type: 'POST',
          url: 'data/cart/update_checked.php',
          data: {iid:iid, checked: 1},
          success: function(result){
            if(result.code===0){
              console.log(result);
            } 
          }
        })
      } else {
        $(this).addClass('normal').removeClass('true');
        $(this).children('img').attr('src', 'img/cart/product_normal.png');
        var amou = parseInt($('.total').text());
        amou--;
        $('.total').text(amou);
        $('.totalOne').text(amou);
        var newamo = parseInt($('.susum').text()) - parseInt($(this).parent().parent().siblings('.totle').children('.totle_information').text());
        $('.susum').text(newamo.toFixed(2));
        $('.susumOne').text(newamo.toFixed(2));
        var iid = $(this).parent().parent().siblings('.pudc').children('.pudc_information').attr('id');
        $.ajax({
          type: 'POST',
          url: 'data/cart/update_checked.php',
          data: {iid:iid, checked: 0},
          success: function(result){
            if(result.code===0){
              console.log(result);
            } 
          }
        })
      }
    })
  
  
    //删除当前行
    $('#content_box_body').on('click', '.del_d', (function () {
      var me = this;
      var id = $(this).parent().siblings('.pudc').children('.pudc_information').attr('id');
      $('.modal').fadeIn();
      $('.no').click(function () {
        $('.modal').fadeOut();
      });
      $('.yes').click(function () {
        $.ajax({
          type: "POST",
          url: "data/cart/del.php",
          data: {iid: id},
          success: function (result) {
            $('.modal').fadeOut();
            if(result.code==0){
              $(me).parent().parent().remove();
            }else {
              alertMsg('<b>删除失败！</b><p>错误原因为：'+result.msg+'</p>')
            }
          }
        });
      })
    }));
  
    //批量删除
   
  //合计
  function totl() {
    var sum = 0.00;
    var amount = 0;
    $(".totle_information").each(function () {
      sum += parseInt($(this).text());
      $(".susum").text(sum.toFixed(2));
      $(".susumOne").text(sum.toFixed(2));
      amount++;
      $('.total').text(amount);
      $('.totalOne').text(amount);
    })
  }
  // 单独
  function amountadd() {
    var amo = 0;
    $('.Each>span').each(function () {
      if ($(this).hasClass('true')) {
        amo += parseInt($(this).parent().parent().siblings('.totle').children('.totle_information').text());
      }
    })
    $('.susum').text(amo.toFixed(2));
    $('.susumOne').text(amo.toFixed(2));
  }
  
  function adddel() {
    //小计和加减
    //加
    $("#content_box_body").on('click', '.add', (function () {
      var $multi = 0;
      var vall = $(this).prev().val();
      vall++;
      $(this).prev().val(vall);
      $multi = (parseInt(vall).toFixed(2) * parseInt($(this).parent().prev().children().eq(1).children().eq(1).text()));
      $(this).parent().next().children().eq(1).text(Math.round($multi).toFixed(2));
      amountadd();
      var id = $(this).parent().siblings('.pudc').children('.pudc_information').attr('id');
      var num = $(this).prev().val();
      console.log(num);
      $.ajax({
        type: "POST",
        url: "data/cart/update_count.php",
        data: {iid: id, count: num},
        success: function (data) {
          console.log(data);
        }
      });
    }));
    //减
    $("#content_box_body").on('click', '.reduc', (function () {
      var $multi1 = 0;
      var vall1 = $(this).next().val();
      vall1--;
      if (vall1 <= 0) {
        vall1 = 1;
      }
      $(this).next().val(vall1);
      $multi1 = parseInt(vall1) * parseInt($(this).parent().prev().children().eq(1).children().eq(1).text());
      $(this).parent().next().children().eq(1).text(Math.round($multi1).toFixed(2));
      amountadd();
      var id = $(this).parent().siblings('.pudc').children('.pudc_information').attr('id');
      var num = $(this).next().val();
      $.ajax({
        type: "POST",
        url: "data/cart/update_count.php",
        data: {iid: id, count: num},
        success: function (data) {
          console.log(data);
        }
      });
    }));
  }
  
  //去结算
  var str = [];
  var totalPrice = 0;
  $('#go-buy').click(function () {
    var totalPrice = parseFloat($('.susumOne').html());
    if(totalPrice<=0){
      alertMsg('请勾选您确定购买的商品！');
    }else {
      location.href = 'order_confirm.html';
    }
  })
})