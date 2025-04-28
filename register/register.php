<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../header/header.css" media="screen">
    <link rel="stylesheet" href="register.css" media="screen">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <title>Register</title>
</head>
<body>
    <header>
        <div class="header">
            <h1>
                <a href="http://localhost/todolist/homepage/homepage.html">
                    🌴 vacation list
                </a>
            </h1>    
        </div>
    </header>
    <div class="formulario">
        <h1>
            start the experience
        </h1>
        <form class="" action="processa_usuario.php" method="post"> 
            <h2>
                <input type="text" placeholder="username*" id="username" class="form-control" name="username">
            </h2>
            <h2>
                <input type="password" placeholder="password*" id="password" class="form-control" name="password">
            </h2>
            <h2>
                <input type="email" placeholder="email*" id="email" class="form-control" name="email">
            </h2>
            <p> 
                already had a account? <a href="http://localhost/todolist/login/login.html"> sign in</a>
            </p>
            
            <button type="submit" name="enviarDados" class="botao">sign up</button>
        </form>
    </div>
</body>
</html>