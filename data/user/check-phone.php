<?php
    header('Content-Type: application/json;charset=UTF-8');//接收数据的文本格式
    header('Access-Control-Allow-Origin:*');

    @$phone=$_REQUEST['phone'];
    
    require_once('../init.php');
    $sql="select uid from users where phone='$phone'";
    $result=mysqli_query($conn,$sql);
    $row=mysqli_fetch_assoc($result);

    if($row){
        echo '{"code":1,"msg":"电话号码已占用"}';
    }else{
        echo '{"code":0,"msg":"电话号码可用"}';
    }