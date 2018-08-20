<?php
    header('Content-Type: application/json;charset=UTF-8');//接收数据的文本格式
    header('Access-Control-Allow-Origin:*');

    require_once('../init.php');
    session_start();
    session_destroy();

    echo '{"code":1,"msg":"退出成功"}';