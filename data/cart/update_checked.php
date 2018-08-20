<?php
    header("Content-Type:application/json");
    require_once("../init.php");

    @$iid=$_REQUEST['iid'];
    @$checked=$_REQUEST['checked'];

    $sql="UPDATE shoppingcart_item SET is_checked=$checked WHERE iid=$iid";
    $result=mysqli_query($conn,$sql);
    if(!$result){
        echo '{"code":1,"msg":"失败"}';
    }else{
        echo '{"code":0,"msg":"成功"}';
    }