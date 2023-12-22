<?php
require("../config/header.php");
require("../config/connection.php");

mysqli_connect_errno();
date_default_timezone_set("Asia/Jakarta");

$json = array(
    "status" => "OK",
    "message" => "Success to signin!",
    "data" => array()
);

$email = isset($_GET['user_email']) ? $_GET['user_email'] : "";
$password = isset($_GET['user_password']) ? $_GET['user_password'] : "";

$query = $conn->query("SELECT * FROM users WHERE user_email = '" . $email . "' AND user_password = '" . $password . "'");

$row = $query->num_rows;
if ($row > 0) {
    while ($result = $query->fetch_object()) {
        $data = array();
        $data["user_name"] = $result->user_name;
        $data["user_email"] = $result->user_email;
        $data["user_phone"] = $result->user_phone;
        $data["user_address"] = $result->user_address;
        $json["data"][] = $data;
    }
} else {
    $json["status"] = "ERROR";
    $json["message"] = "Something is going wrong!";
}

print json_encode($json, JSON_PRETTY_PRINT);
