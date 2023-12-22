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

$query = $conn->query("INSERT INTO products SET name = '" . $name . "', price='" . $price . "', description='" . $description . "'");

if ($query) {
    $json["data"] = $query;
    $json["status"] = "OK";
    $json["message"] = "Success create product!";
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Failed create product!";
}

print json_encode($json, JSON_PRETTY_PRINT);
