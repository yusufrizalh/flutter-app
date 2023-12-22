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

// $id = isset($_GET['id']) ? $_GET['id'] : "";
$id = isset($_POST['id']) ? $_POST['id'] : "";
$name = isset($_POST['name']) ? $_POST['name'] : "";
$price = isset($_POST['price']) ? $_POST['price'] : "";
$description = isset($_POST['description']) ? $_POST['description'] : "";

$query = $conn->query("UPDATE products SET name = '" . $name . "', price='" . $price . "', description='" . $description . "' WHERE id = '" . $id . "'");

if ($query) {
    $json["data"] = $query;
    $json["status"] = "OK";
    $json["message"] = "Success update product!";
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Failed update product!";
}

print json_encode($json, JSON_PRETTY_PRINT);
