% include('_header_edit_new.tpl')


<body>

  <h1>Crear Empresa Propia</h1>

  <form action="/empresa_propia/save" method="post">
    <input type="hidden" name="id" value="{{contenido[0]}}"><br>
    <table>
      <tr>
        <td>RUC:</td>
        <td><input type="text" id="id" name="RUC" value="{{contenido[1]}}"></td>
      </tr>
      <tr>
        <td>Razón Social:</td>
        <td><input type="text" id="id" name="razon_social" value="{{contenido[2]}}"></td>
      </tr>
      <tr>
        <td>Dirección de la Empresa:</td>
        <td><input type="text" id="id" name="direcc_empresa" value="{{contenido[3]}}"></td>
      </tr>
      <tr>
        <td></td>
        <td>
          <button class="btn">Guardar Cambios</button>
        </td>
      </tr>
    </table>
  </form>
  
  <a href="/empresa_propia" class="btn">Cancelar</a><br><br>
  % include('_footer.tpl')
</body>
</html>