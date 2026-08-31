<?php
/*****************************************************************
 * Approvals API to fetch playlist information
 * Endpoints:
 *   GET /approvals?all=1
 *   GET /approvals?c=1&v=1
 * Allowed Methods: GET, POST, PUT, DELETE
 ****************************************************************/
require_once("../sys/ttprod.app.php"); //$db->debug=true;
header("Content-Type: application/json");

if (isset($_SESSION['auth'])) {
  try {
    switch ($_SERVER['REQUEST_METHOD']) {
      case "GET":
        if (isset($_GET['c']) && isset($_GET['v'])) {
          $d = $db->getAll("SELECT * FROM hrcomms_content_approvals WHERE {$_GET['c']}=?", array($_GET['v']));
        } else if (isset($_GET['all']) && $_GET['all'] == 1) {
          $d = $db->GetArray("SELECT * FROM hrcomms_content_approvals");
        } else {
          http_response_code(400);
          $response = [
            "success" => false,
            "code" => 400,
            "message" => "Bad Request"
          ];
          break;
        }
        $response = $d;
        http_response_code(200);
        break;

      case "POST":
        $data = json_decode(file_get_contents("php://input"), true);
        http_response_code(201);
        $response = $data;
        break;

      case "PUT":
        $data = json_decode(file_get_contents("php://input"), true);
        http_response_code(201);
        $response = $data;
        break;

      case "DELETE":
        http_response_code(200);
        $response = [
          "success" => true,
          "code" => 200,
          "method" => "DELETE"
        ];
        break;

      default:
        http_response_code(405);
        $response = array(
          "success" => false,
          "code" => 405,
          "message" => "Method Not Allowed"
        );
        break;
    }
  } catch (Exception $e) {
    http_response_code(500);
    $response = array(
      "success" => false,
      "code" => 500,
      "message" => "Internal Server Error"
    );
  }
} else {
  http_response_code(401);
  $response = array(
    "success" => false,
    "code" => 401,
    "message" => "Unauthorized"
  );
}

die(json_encode($response, JSON_PRETTY_PRINT));
exit;