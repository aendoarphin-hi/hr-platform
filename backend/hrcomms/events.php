<?php

/*****************************************************************
 * Events API to fetch event information
 * Endpoints:
 *   GET /events?all=1
 *   GET /events?c=1&v=1
 * Allowed Methods: GET, POST, PUT, DELETE
 ****************************************************************/
require_once("../sys/ttprod.app.php"); //$db->debug=true;
header("Content-Type: application/json");

if (isset($_SESSION['auth'])) {
  try {
    switch ($_SERVER['REQUEST_METHOD']) {
      /*********************************************************
       * Get event(s)
       *********************************************************/
      case "GET":
        if (isset($_GET['c']) && isset($_GET['v'])) {
          $e = $db->getAll("SELECT * FROM hrcomms_events WHERE {$_GET['c']}=?", array($_GET['v']));
        } else if (isset($_GET['all']) && $_GET['all'] == 1) {
          // location specific events
          $e = $db->GetArray("SELECT e.*, l.name as location FROM hrcomms_events e
          JOIN hrcomms_locations l
          ON e.location_id=l.id");
          // company wide events
          $n = $db->GetArray("SELECT * FROM hrcomms_events WHERE location_id is null");
        } else {
          http_response_code(400);
          $response = [
            "success" => false,
            "code" => 400,
            "message" => "Bad Request"
          ];
          break;
        }
        http_response_code(200);
        $response = array_merge($e, $n);
        break;
      /*********************************************************
       * Create new event
       *********************************************************/
      case "POST":
        $data = json_decode(file_get_contents("php://input"), true);
        http_response_code(201);
        $stmt = "INSERT INTO hrcomms_events (title, type, subtype, start, end, description, location_id, employee_num, content_id) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $db->Execute($stmt, array(
            $data['title'], 
            $data['type'], 
            $data['subtype'], 
            $data['start'],
            $data['end'],
            $data['description'],
            $data['location_id'],
            $data['employee_num'],
            $data['content_id']
          )); // continue here; test the post
        if ($db->ErrorMsg()) $response = array("success" => false, "code" => 500, "message" => $db->ErrorMsg());
        else $response = array("success" => true, "code" => 201, "method" => "POST");
        break;
      /*********************************************************
       * Modify existing event
       *********************************************************/
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
