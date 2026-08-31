<?php
/*****************************************************************
 * Employees API to fetch employee information
 * Endpoints:
 *   GET /employee?all=1
 *   GET /employee?id=1
 *   GET /employee?number=1
 *   GET /employee?name=John Doe
 *   GET /employee?first=John&last=Doe
 *   GET /employee?email=4K0m8@example.com
 * Allowed Methods: GET
 ****************************************************************/
require_once("../sys/ttprod.app.php"); //$db->debug=true;
header("Content-Type: application/json");

// auth check
if (isset($_GET['auth']) && isset($_SESSION['auth'])) {
  die(json_encode($_SESSION['auth'], JSON_PRETTY_PRINT));
}

if (isset($_SESSION['auth'])) {
  try {
    switch ($_SERVER['REQUEST_METHOD']) {
      case "GET":
        $e = null;
        // Special case: get all employees
        if (isset($_GET['all']) && $_GET['all'] == 1) {
          $e = $db->GetArray(
            "SELECT * FROM employee WHERE deleted=-1 AND priv_login=1"
          );
        }
        // Multi-column search
        elseif (isset($_GET['first'], $_GET['last'])) {
          $e = $db->GetRow(
            "SELECT * FROM employee WHERE first=? AND last=?",
            [$_GET['first'], $_GET['last']]
          );
        }
        // Single-column searches
        else {
          $searches = array(
            'id'     => 'id',
            'number' => 'number',
            'name'   => 'name',
            'email'  => 'email'
          );

          foreach ($searches as $param => $column) {
            if (isset($_GET[$param])) {
              $e = $db->GetRow(
                "SELECT * FROM employee WHERE {$column}=?",
                [$_GET[$param]]
              );
              break;
            }
          }
        }

        if ($e === null) {
          http_response_code(400);
          $response = [
            "success" => false,
            "code" => 400,
            "message" => "Bad Request"
          ];
          break;
        }
        http_response_code(200);
        $response = $e;
        break;
      default:
        http_response_code(405);
        $response = [
          "success" => false,
          "code" => 405,
          "message" => "Method not allowed"
        ];
        break;
    }
  } catch (Exception $e) {
    http_response_code(500);
    $response = [
      "success" => false,
      "code" => 500,
      "message" => "Internal Server Error"
    ];
  }
} else {
  http_response_code(401);
  $response = [
    "success" => false,
    "code" => 401,
    "message" => "Unauthorized"
  ];
}


die(json_encode($response, JSON_PRETTY_PRINT));
