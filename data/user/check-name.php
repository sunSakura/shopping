<?php
    header('Content-Type: application/json;charset=UTF-8');//接收数据的文本格式
    header('Access-Control-Allow-Origin:*');

    @$uname=$_REQUEST['uname'];
    
    require_once('../init.php');
    $sql="select uid from users where uname='$uname'";
    $result=mysqli_query($conn,$sql);
    $row=mysqli_fetch_assoc($result);

    if($row){
        echo '{"code":1,"msg":"用户名已存在"}';
    }else{
        echo '{"code":0,"msg":"用户名可用"}';
    }