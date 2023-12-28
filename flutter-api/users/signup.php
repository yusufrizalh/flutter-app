<?php
require("../config/header.php");
require("../config/connection.php");

mysqli_connect_errno();
date_default_timezone_set("Asia/Jakarta");

$json = array(
    "status" => "",
    "message" => "",
    "data" => array()
);

$user_name = isset($_POST['user_name']) ? $_POST['user_name'] : "";
$user_email = isset($_POST['user_email']) ? $_POST['user_email'] : "";
$user_phone = isset($_POST['user_phone']) ? $_POST['user_phone'] : "";
$user_address = isset($_POST['user_address']) ? $_POST['user_address'] : "";
$user_password = isset($_POST['user_password']) ? $_POST['user_password'] : "";
// $user_image  = isset($_FILES['image']) ? $_FILES['image'] : "";

define('SITE_ROOT', realpath(dirname(dirname(__FILE__))));
define('SITE_REAL', 'http://192.168.1.12/flutter-api/users/images');
$image = time() . "-" . $_FILES["image"]['name'];
$image_tmp = $_FILES["image"]["tmp_name"];
$destination = SITE_ROOT . "/users/images/" . $image;
$image_path = SITE_REAL . "/" . $image;

$query = $conn->query("INSERT INTO users 
    SET user_name = '" . $user_name . "', 
        user_email = '" . $user_email . "', 
        user_phone = '" . $user_phone . "', 
        user_address = '" . $user_address . "',
        user_password = '" . $user_password . "',
        image = '" . $image . "',
        image_path = '" . $image_path . "'");

if ($query) {
    move_uploaded_file($image_tmp, $destination);
    $json["data"] = $query;
    $json["status"] = "OK";
    $json["message"] = "Success register user!";
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Failed register user!";
}

print json_encode($json, JSON_PRETTY_PRINT);
