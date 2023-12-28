<?php
require("../config/header.php");
require("../config/connection.php");

mysqli_connect_errno();
date_default_timezone_set("Asia/Jakarta");

$json = array(
    "status" => "OK",
    "message" => "Success get users!",
    "data" => array()
);

$query = $conn->query("SELECT * FROM users ORDER BY user_name ASC");

$row = $query->num_rows;
if ($row > 0) {
    while ($result = $query->fetch_object()) {
        $data = array();
        $data["user_name"] = $result->user_name;
        $data["user_email"] = $result->user_email;
        $data["user_phone"] = $result->user_phone;
        $data["user_address"] = $result->user_address;
        $data["image"] = $result->image;
        $json["data"][] = $data;
    }
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Failed get users!";
}

print json_encode($json, JSON_PRETTY_PRINT);
