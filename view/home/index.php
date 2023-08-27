<?php
include('../../config/config.php');

session_start();
$routeResult = "Location: ../../view/login/index.php";
if (isset($_SESSION["newsession"])) {
  $idUser = $_SESSION["newsession"];
  $sql = "CALL sp_select_module_user_id(" . $idUser . "); ";

  if (!$result = $connect->query($sql)) {
    echo "Falló la multiconsulta: (" . $connect->errno . ") " . $connect->error;
  } else {
    $resultQuery = $result->fetch_all(MYSQLI_NUM);
  }


} else {
  header($routeResult);
}


?>

<!doctype html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

  <title>Hello, world!</title>
</head>

<body>


  <!--Nav start-->
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="../../assets/img/logo/logo.png" alt="Avatar Logo" style="width:40px;" class="rounded-pill"> 
    </a>
      <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">

          <?php
          for ($i = 0; $i < count($resultQuery); $i++) {

            echo '<li class="nav-item"><a class="nav-link active" aria-current="page" href="../' . $resultQuery[$i][1] . '">' . $resultQuery[$i][0] . '</a></li>';
          }
          ?>
          <li class="nav-item dropdown ">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
              data-bs-toggle="dropdown" aria-expanded="false">
              User
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <li><a class="dropdown-item" href="../../controller/login/login.php?userClose=1">Sign off</a></li>
        
            </ul>
          </li>

        </ul>
      </div>
    </div>
  </nav>

  <!--Nav End-->
  <!--Container start-->
  <div class="container">
    <div class="row">
      <div class="col-12 mx-auto">

      </div>

    </div>
  </div>
  <!--Container end-->

  <!-- Optional JavaScript; choose one of the two! -->

  <!-- Option 1: Bootstrap Bundle with Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

  <!-- Option 2: Separate Popper and Bootstrap JS -->
  <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    -->
</body>

</html>