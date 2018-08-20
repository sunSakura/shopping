<?php
header("Content-Type:application/json");
require_once("../init.php");
$output=[
  /*
  "laptop"=>[lid,fid,title,details,spec,...,pics=>[],
  "family"=>[fid,fname,laptop_list:[...]]
  */
];

@$pid=$_REQUEST["pid"];
if($pid){
  $sql="select * from product where pid=$pid";
  $result1=mysqli_query($conn,$sql);
  $row1=mysqli_fetch_all($result1,MYSQLI_ASSOC);
  $output["product"]=$row1[0];
  $sql="select * from product_pic where pid=$pid";
  $result=mysqli_query($conn,$sql);
  $row=mysqli_fetch_all($result,MYSQLI_ASSOC);
  $output["laptop"]["pics"]=$row;
  echo json_encode($output);
}else{
  echo "[]";
}
