<?php 

$server = "localhost";
$user = "root";
$pass = "";
$database = "project_general";

$connect = new mysqli($server, $user, $pass, $database);

if($connect->connect_errno){
  echo "Failed to connect to mysql:".$connect->connect_errno;
}else{
  echo "Ok, connect";
}

?>