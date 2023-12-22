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

$query = $conn->query("DELETE FROM products WHERE id = '" . $id . "'");

if ($query) {
    $json["data"] = $query;
    $json["status"] = "OK";
    $json["message"] = "Success delete product!";
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Failed delete product!";
}

print json_encode($json, JSON_PRETTY_PRINT);
