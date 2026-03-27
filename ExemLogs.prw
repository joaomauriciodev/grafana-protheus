#include "protheus.ch"

User Function ExemLogs()
  Local cCFOP   := "5102"
  Local cErrMsg := "Permissão negada"

    // Preparar ambiente
  RpcSetType(3)
  RpcSetEnv("99", "01")

  U_GravaLog( "INFO",  "Iniciando emissao de NF",         "MATA410" )
  U_GravaLog( "DEBUG", "CFOP utilizado: " + cCFOP,          "MATA410" )
  U_GravaLog( "WARN",  "Estoque abaixo do minimo",         "MATA410" )
  U_GravaLog( "ERROR", "Falha ao gravar NF: " + cErrMsg,    "MATA410" )

  RpcClearEnv()


Return
