//对用户名进行验证
$('#uname').blur(function(){
    console.log(123);
    if(!this.value){
        $('#name_reg').text("用户名不能为空");
        $('#name_reg').css("background","red");
    }else{
        var uname=this.value;
        $.ajax({
            url:'data/user/check-name.php',
            data:{uname:uname},
            success:function(result){
                if(result.code===1){
                    $('#name_reg').text("用户名已存在");
                    $('#name_reg').css("background","red");
                }else{
                    $('#name_reg').text("用户名可用");
                    $('#name_reg').css("background","#90EE90");
                }
            }
        })
    }
});

//密码提示
$('#upwd').focus(function(){
    $('#upwd-reg').text("密码长度为6-18个字符");
    $('#upwd-reg').css("background","#C0C0C0");
});
$('#upwd').blur(function(){
    if(!this.value){
        $('#upwd-reg').text("密码不能为空");
        $('#upwd-reg').css("background","red");
    }else{
        var upwd=this.value;
        console.log(upwd.length);
        if(upwd.length<6){
            $('#upwd-reg').text("密码不能小于6位");
            $('#upwd-reg').css("background","red");
        }else if(upwd.length>18){
            $('#upwd-reg').text("密码不能大于18位");
            $('#upwd-reg').css("background","red");
        }else{
            $('#upwd-reg').text("密码格式正确");
            $('#upwd-reg').css("background","#90EE90");
        }
    }
});

//确认密码
$('#upwd-req').blur(function(){
    var upwd=$('#upwd').val();
    if(this.value===upwd){
        $('#upwd-re').text("两次输入的密码一致");
        $('#upwd-re').css("background","#90EE90");
    }else{
        $('#upwd-re').text("两次输入的密码不一致");
        $('#upwd-re').css("background","red");
    }
    if(!this.value){
        $('#upwd-re').text("确认密码不能为空");
        $('#upwd-re').css("background","red");
    }
});
//当密码改变时
$('#upwd').change(function(){
    var upwd_re=$('#upwd-re').val();
    if(this.value!==upwd_re){
        $('#upwd-re').text("两次输入的密码不一致");
        $('#upwd-re').css("background","red");
    }
});

//验证邮箱格式
$('#email').blur(function(){
    if(!this.value){
        $('#email-reg').text('邮箱不能为空');
        $('#email-reg').css('background','red');
    }else{
        var re=/^\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$/;
        if(re.test(this.value)){
            $('#email-reg').text('邮箱格式正确');
            $('#email-reg').css('background','#90EE90');
        }else{
            $('#email-reg').text('邮箱格式不正确');
            $('#email-reg').css('background','red');
        }
    }
});

//验证电话号码
$('#phone').blur(function(){
    if(!this.value){
        $('#phone-reg').text('电话号码不能为空');
        $('#phone-reg').css('background','red');
    }else{
        //验证手机号是否被注册过
        var phone=this.value;
        $.ajax({
            url:'data/user/check-phone.php',
            data:{phone:phone},
            success:function(result){
                if(result.code===1){
                    $('#phone-reg').text("电话号码已占用");
                    $('#phone-reg').css("background","red");
                }else{
                    var reg=/^[1][3,4,5,7,8][0-9]{9}$/;
                    if(reg.test(phone)){
                        $('#phone-reg').text('电话号码可用');
                        $('#phone-reg').css('background','#90EE90');
                    }else{
                        $('#phone-reg').text('电话号码格式不正确');
                        $('#phone-reg').css('background','red');
                    }
                }
            }
        })    
    }
});


//提交注册信息
$('#submit').click(function(){
    var uname=$('#uname').val();
    var upwd=$('#upwd').val();
    var upwd_req=$('#upwd-req').val();
    var email=$('#email').val();
    var phone=$('#phone').val();
    var gender=$('input:radio[name="gender"]:checked').val();
    $.ajax({
        method:'POST',
        data:{uname:uname,upwd:upwd,upwd_req:upwd_req,email:email,phone:phone,gender:gender},
        url:'data/user/register.php',
        success:function(result){
            if(result.code===1){
                alertMsg('<b>注册成功！</b><p>点击确定返回到登录页面。</p>');
                console.log(124);
                $('#alertMsg_btn1 cite').click(function (e) {
                    e.preventDefault();
                    location.href='login.html';
                })
            }else{
                alertMsg(result.msg);
            }
        },
        error:function(){
            console.log("请求失败");
        }
    })
});