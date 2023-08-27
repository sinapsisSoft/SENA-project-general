<?php
include("../../config/config.php");

$sql = "SELECT * FROM role ;";
$sql .= "SELECT * FROM userstatus;";

$resultArray = array();

if (!$connect->multi_query($sql)) {
  echo "Falló la multiconsulta: (" . $connect->errno . ") " . $connect->error;
} else {
  do {
    if ($result = $connect->store_result()) {
      $resultQuery = $result->fetch_all(MYSQLI_NUM);
      array_push($resultArray, $resultQuery);
      $result->free();
    }
  } while ($connect->more_results() && $connect->next_result());
  $userRole = $resultArray[0];
  $userStatus = $resultArray[1];

  $connect->close();


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
  <!--Container start-->
  <div class="container">
    <div class="row">
      <div class="col-6 mx-auto">
        <form action="../../controller/user/create.php" method="POST">
          <!--Form start-->
          <input type="hidden" class="form-control" id="User_id" name="User_id" value="null" placeholder="" Required>
          <div class="card mx-auto" style="width: 90%;">

            <div class="card-body">
              <h5 class="card-title">CREATE USER</h5>
              <div class="mb-3 ">
                <label for="User_user" class="form-label">User Email address</label>
                <input type="email" class="form-control" id="User_user" name="User_user" placeholder="name@example.com"
                  Required>
              </div>
              <div class="mb-3">
                <label for="User_password" class="form-label">User Password </label>
                <input type="password" class="form-control" id="User_password" name="User_password" placeholder=""
                  Required>
              </div>
              <div class="mb-3">
                <label for="User_password_repeat" class="form-label">User Password </label>
                <input type="password" class="form-control" id="User_password_repeat" name="User_password_repeat"
                  placeholder="" Required>
              </div>

              <div class="mb-3">
                <label for="User_password_repeat" class="form-label">Role </label>
                <select class="form-select form-select-sm" id="Role_id" name="Role_id"
                  aria-label=".form-select-sm example">
                  <option selected>Open this select menu</option>
                  <?php

                  for ($i = 0; $i < count($userRole); $i++) {
                    echo '<option value="' . $userRole[$i][0] . '">' . $userRole[$i][1] . '</option>';
                  }
                  ?>

                </select>
              </div>

              <div class="mb-3">
                <label for="User_password_repeat" class="form-label">Status </label>
                <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="UserStatus_id"
                  name="UserStatus_id">
                  <option selected>Open this select menu</option>

                  <?php

                  for ($i = 0; $i < count($userStatus); $i++) {
                    echo '<option value="' . $userStatus[$i][0] . '">' . $userStatus[$i][1] . '</option>';
                  }
                  ?>
                </select>
              </div>




              <div class="mb-3">

                <button type="submit" class="btn btn-success">Success</button>
              </div>
            </div>
          </div>
        </form>



        <!--Form end-->
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