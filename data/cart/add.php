<?php
    session_start();
    header("Content-Type:application/json");
    require_once("../init.php");
    $uid=$_SESSION["loginUid"];

        @$pid=$_REQUEST["pid"];
        @$count=$_REQUEST["count"];
        @$size=$_REQUEST["size"];
        @$color=$_REQUEST["color"];
        $sql_has="select * from shoppingcart_item where pid=$pid and uid=$uid and size='$size' and color='$color'";
        $result=mysqli_query($conn,$sql_has);
        $row=mysqli_num_rows($result);
        if($row==1){
            $sql_update="update shoppingcart_item set count=count+$count where pid=$pid and uid=$uid and size='$size' and color='$color'";
            $result=mysqli_query($conn,$sql_update);
            if($result){
                echo '{"code":0,"msg":"添加成功"}';
            }else{
                echo '{"code":1,"msg":"添加失败"}';
            }
        }else{
            $sql_insert="insert into shoppingcart_item(iid,uid,pid,size,color,count,is_checked) values(null,$uid,$pid,'$size','$color',$count,0)";
            $result=mysqli_query($conn,$sql_insert);
            if($result){
                echo '{"code":0,"msg":"添加成功"}';
            }else{
                echo '{"code":-1,"msg":"添加失败"}';
            }
        }
