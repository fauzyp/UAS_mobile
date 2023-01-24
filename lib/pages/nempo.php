<?php
require_once('koneksiDb.php');

$query = " SELECT * FROM filmkekinian";
$sql = mysqli_query($db_connect, $query);

if ($sql){
    $result = array();
    while ($row = mysqli_fetch_array($sql)){
        array_push($result, array(
            'noFilm' => $row['noFilm'],
            'txt' => $row['txt'],
        ));
    }
    echo json_encode(array('txt' => $result));
}
?>