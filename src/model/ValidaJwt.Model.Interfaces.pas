unit ValidaJwt.Model.Interfaces;

interface

type
  IValidaJwtModelUsuario = interface
    ['{D34FABE8-C65D-4C62-A265-FEF97E427DC9}']
  end;

  IValidaJwtModelFactory = interface
    ['{5E9C1684-EBC5-4172-8423-F24E8DFC2106}']
    function Usuario: IValidaJwtModelUsuario;
  end;

implementation

end.
