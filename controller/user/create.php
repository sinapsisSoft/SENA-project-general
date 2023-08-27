<?php

include('../../config/config.php');

$routeResult = "Location: ../../view/user/index.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {

  $UserId = $_REQUEST['User_id'];
  $UserPassword = password_hash($_REQUEST['User_password'], PASSWORD_DEFAULT);
  $UserUser = $_REQUEST['User_user'];

  $RoleId = $_REQUEST['Role_id'];
  $UserStatusId = $_REQUEST['UserStatus_id'];

  $stmt = $connect->prepare("INSERT INTO user (User_password,User_user,Role_id,UserStatus_id) VALUES (?,?,?,?)");
  $stmt->bind_param("ssii", $UserPassword, $UserUser, $RoleId, $UserStatusId);
  $stmt->execute();

  echo ("New records created successfully");
  $stmt->close();
  $connect->close();

  header($routeResult);
  exit;

}
?>