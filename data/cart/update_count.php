<?php
    header("Content-Type:application/json");
    require_once("../init.php");

    @$iid=$_REQUEST['iid'];
    @$num=$_REQUEST['count'];

    $sql="UPDATE shoppingcart_item SET count=$num WHERE iid=$iid";
    echo $sql;
    $result=mysqli_query($conn,$sql);
    if(!$result){
        echo '{"code":1,"msg":"失败"}';
    }else{
        echo '{"code":0,"msg":"成功"}';
    }