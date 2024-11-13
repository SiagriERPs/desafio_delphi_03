unit uEnumerado;

interface

type
  TAction = (
    tacIndefinite,
    tacInclude,
    tacChange,
    tacDelete);

  TControlButtons = (
    statusInitial,
    statusInclude,
    statusChange,
    statusSearch
    );

  TStatus = (
    Pendente,
    Aprovada,
    Concluida,
    Cancelada
  );

implementation

end.
