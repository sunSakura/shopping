<?php
    header('Content-Type: application/json;charset=UTF-8');//接收数据的文本格式
    header('Access-Control-Allow-Origin:*');
    @$uname = $_REQUEST['uname'] or die('{"code":401,"msg":"用户名不能为空"}');
    @$upwd = $_REQUEST['upwd'] or die('{"code":402,"msg":"密码不能为空"}');

    require_once('../init.php');   //引入数据库连接文件
    $sql="select uid from users where uname='$uname' and upwd='$upwd' ";
    $result=mysqli_query($conn,$sql);
    $row=mysqli_fetch_assoc($result);
    
    if(!$row){
        echo '{"code":1,"msg":"用户名或密码错误"}';
    }else{
        echo '{"code":0,"msg":"登录成功"}';
        session_start();
        $_SESSION['loginUname']=$uname;
        $_SESSION['loginUid']=$row['uid'];
    }
