<?php
require("../config/header.php");
require("../config/connection.php");

mysqli_connect_errno();
date_default_timezone_set("Asia/Jakarta");

$json = array(
    "status" => "OK",
    "message" => "Success get product by id!",
    "data" => array()
);

$id = isset($_GET['id']) ? $_GET['id'] : "";
$query = $conn->query("SELECT * FROM products WHERE id = '" . $id . "'");

$row = $query->num_rows;
if ($row > 0) {
    while ($result = $query->fetch_object()) {
        $data = array();
        $data["id"] = $result->id;
        $data["name"] = $result->name;
        $data["price"] = $result->price;
        $data["description"] = $result->description;
        $data["createdAt"] = $result->createdAt;
        $data["updatedAt"] = $result->updatedAt;
        $json["data"][] = $data;
    }
} else {
    $json["status"] = "WARNING";
    $json["message"] = "No product found!";
}

print json_encode($json, JSON_PRETTY_PRINT);
