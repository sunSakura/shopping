//用户名和密码的非空验证
$('#uname').blur(function(){
    if(this.value==""){
        $('#nameres').text("用户名不能为空");
        $('#nameres').css("color","red");
        return false;
    }else{
        $('#nameres').text("");
    } 
});

$('#upwd').blur(function(){
    if(this.value==""){
        $('#pwdres').text("密码不能为空");
        $('#pwdres').css("color","red");
        return false;
    }else{
        $('#pwdres').text("");
    }
});

//用户登录
$('#sumbit').click(function(){
    var uname=$('#uname').val();
    var upwd=$('#upwd').val();
    $.ajax({
        type:'POST',
        url:'data/user/login.php',
        dataType:"json",
        data:{uname:uname,upwd:upwd},
        success:function(result){
            console.log("------------------"+result)
            if(result.code===1){
                alertMsg('<b>登录失败！</b><p>用户名或密码输入有误。</p>');
            }else if(result.code===0){
                location.href='index.html';
            }
        },
        error:function(){
            console.log("请求失败")
        }
    });
});