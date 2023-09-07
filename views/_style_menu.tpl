<style>
  /* Estilos generales */

  body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 20px;
    }
  
  a {
    color: #333;
    text-decoration: none;
  }

  .menu{
    border-radius: 11px;
  }

  button:hover,
  input[type="button"]:hover {
    background-color: #333;
    color: #fff;
  }

  ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
    text-align: center;
  }

  li {
    display: inline-block;
    position: relative;
  }

  /* Estilos del enlace principal */
  li a {
    display: block;
    padding: 8px 16px;
    text-decoration: none;
    color: #333;
  }

  li a:hover {
    background-color: #333;
    color: #fff;
  }

  /* Estilos del menú desplegable */
  .dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
  }

  .dropdown-content a {
    color: #333;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
  }

  /* Mostrar el menú desplegable al pasar el cursor sobre el enlace principal */
  li:hover .dropdown-content {
    display: block;
  }
</style>