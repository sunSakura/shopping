<?php
session_start();
header("Content-Type:application/json");
require_once("../init.php");
@$uid=$_SESSION["loginUid"];
    $sql="select s.pid,iid,title,price,count,sm,s.color,s.size from shoppingcart_item s left join product p on s.pid=p.pid";
    $sql .=" left join product_pic pic on s.pid=pic.pid where uid=$uid group by s.color,s.size";
    $result = mysqli_query($conn,$sql);
    if(!$result){
        echo mysqli_error($conn);
        echo '{"code":1,"msg":"失败"}';
    }else{
        $row = mysqli_fetch_all($result, MYSQLI_ASSOC);
        echo json_encode($row);
    }