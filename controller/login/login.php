<?php
  include('../../config/config.php');

  $routeResult="";

  if($_SERVER['REQUEST_METHOD']=="POST"){

    $UserUser=$_REQUEST['User_user'];
    $UserPassword=$_REQUEST['User_password'];

    $sql="CALL sp_select_user_email('".$UserUser."');";

    if($result=$connect->query($sql)){
      $resultQuery=$result->fetch_all(MYSQLI_NUM);
      

      if(count($resultQuery)>0){

    

        if(password_verify($UserPassword,$resultQuery[0][1])){

          session_start();
          $_SESSION["newsession"]=$resultQuery[0][0];
          echo ("</br>Ok: Login succeeds");
          $routeResult="Location: ../../view/home/index.php";

        }else{
          echo ("</br>Error: Password and User");
          $routeResult="Location: ../../view/login/index.php";
        }


      }else{
        echo("</br>Error: User name does not exist");
        $routeResult="Location: ../../view/login/index.php";
      }

    }
    
  header($routeResult);
  $connect->close();


  }else{
    $routeResult="Location: ../../view/login/index.php";
    session_start();
    session_destroy();
    header($routeResult);

  }

?>