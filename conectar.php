<?php 
$host = 'localhost';
$db = 'todolist';
$user = 'postgres';
$password = ' ';
$port = '5432';

$banco = new PDO("pgsql:host=$host;port=$port;dbname=$db", $user, $password);

if($banco){
    echo 'rodou :)';
}
?>