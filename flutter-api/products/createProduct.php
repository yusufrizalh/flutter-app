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

$name = isset($_POST['name']) ? $_POST['name'] : "";
$price = isset($_POST['price']) ? $_POST['price'] : "";
$description = isset($_POST['description']) ? $_POST['description'] : "";

define('SITE_ROOT', realpath(dirname(dirname(__FILE__))));
define('SITE_REAL', 'http://192.168.1.12/flutter-api/products/images');
// $image = time() . "-" . $_FILES["image"]['name'];
$image = $_FILES["image"]['name'];
$image_tmp = $_FILES["image"]["tmp_name"];
$destination = SITE_ROOT . "/products/images/" . $image;
$image_path = SITE_REAL . "/" . $image;

$query = $conn->query("INSERT INTO products 
    SET name = '" . $name . "', 
    price='" . $price . "', 
    description='" . $description . "',
    image='" . $image . "',
    image_path='" . $image_path . "'");

if ($query) {
    move_uploaded_file($image_tmp, $destination);
    $json["data"] = $query;
    $json["status"] = "OK";
    $json["message"] = "Success create product!";
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Failed create product!";
}

print json_encode($json, JSON_PRETTY_PRINT);
