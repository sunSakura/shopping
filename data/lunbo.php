<?php
    header('Content-Type: application/json;charset=UTF-8');
    header('Access-Control-Allow-Origin:*');
    require_once('init.php');

    $sql="select * from index_carousel";
    $result=mysqli_query($conn,$sql);
    $row=mysqli_fetch_all($result);
    
    echo json_encode($row);