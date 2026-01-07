<?php
$wallet = $_GET['wallet'] ?? '';
if($wallet === '') { echo "No wallet provided"; exit; }
$output = shell_exec("bash airdrop.sh $wallet 2>&1");
echo htmlspecialchars($output);
?>
