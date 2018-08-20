<?php
    header('Content-Type: application/json;charset=UTF-8');
    header('Access-Control-Allow-Origin:*');
    require_once('../init.php');

    $output=[];
    $sql="select * from index_product where lid=1";
    $output["f1"]=mysqli_fetch_all(mysqli_query($conn,$sql));

    $sql="select * from index_product where lid=3";
    $output["f2"]=mysqli_fetch_all(mysqli_query($conn,$sql));

    $sql="select * from index_product where lid=4";
    $output["f3"]=mysqli_fetch_all(mysqli_query($conn,$sql));

    echo json_encode($output);