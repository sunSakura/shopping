<?php
header("Content-Type:application/json");
require_once("../init.php");
$output=[
  "count"=>0,
  "pageSize"=>10,
  "pageCount"=>0,
  "pageNo"=>0,
  "data"=>[]
];
@$kw=$_REQUEST["kw"];
@$pno=$_REQUEST["pno"];
if(!$pno) $pno=0;
$sql="SELECT pid, title, price, sold_count,(select md from product_pic where product.pid=product_pic.pid limit 1) as md FROM product";
if($kw){
  $kws=explode(" ",$kw);//js:split
  for($i=0;$i<count($kws);$i++){
    $kws[$i]=" title like '%".$kws[$i]."%'";
    
  }
  $where=" where ".implode(" or ",$kws);//js:join
  $sql=$sql.$where;
}
$result1=mysqli_query($conn,$sql);
$output["count"]=mysqli_num_rows($result1);
$sql=$sql." limit ".$pno*$output["pageSize"].",".$output["pageSize"];//limit 0,9
$str = mysqli_query($conn,$sql);

$result=mysqli_fetch_all($str,MYSQL_ASSOC);
$output["pageCount"]=ceil($output["count"]/$output["pageSize"]);
$output["pageNo"]=$pno;
$output["data"]=$result;
echo json_encode($output);