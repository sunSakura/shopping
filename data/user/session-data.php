<?php
    header('Content-Type: application/json;charset=UTF-8');//接收数据的文本格式
    header('Access-Control-Allow-Origin:*');
    require_once('../init.php');

    session_start();
    @$output['uid']=$_SESSION['loginUid'];
    @$output['uname']=$_SESSION['loginUname'];

    echo json_encode($output);