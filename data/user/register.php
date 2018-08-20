<?php
    header('Content-Type: application/json;charset=UTF-8');//接收数据的文本格式
    header('Access-Control-Allow-Origin:*');

    @$uname=$_REQUEST['uname'] or die('{"code":401,"msg":"用户名不能为空"}');
    @$upwd=$_REQUEST['upwd'] or die('{"code":401,"msg":"密码不能为空"}');
    @$upwd_req=$_REQUEST['upwd_req'] or die('{"code":401,"msg":"确认密码不能为空"}');
    @$phone=$_REQUEST['phone'] or die('{"code":401,"msg":"电话号码不能为空"}');
    @$email=$_REQUEST['email'] or die('{"code":401,"msg":"电子邮件不能为空"}');
    @$gender=$_REQUEST['gender'];
    require_once('../init.php');
    $sql1="select uid from users where uname='$uname'";
    $result1=mysqli_query($conn,$sql1);
    $row1=mysqli_fetch_assoc($result1);
    if(!$row1){
        if($upwd===$upwd_req){
            $sql="insert into users(uname,upwd,phone,email,gender) values('$uname','$upwd','$phone','$email','$gender')";
            $result=mysqli_query($conn,$sql);
            
            if($result){
                echo '{"code":1,"msg":"注册成功"}';
            }else{
                echo '{"code":0,"msg":"注册失败"}';
            }
        }else{
            echo '{"code":0,"msg":"两次输入的密码不一致"}';
        }
    }else{
        echo '{"code":0,"msg":"用户名已存在"}';
    }