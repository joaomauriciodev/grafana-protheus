#include "protheus.ch"
#include "totvs.ch"

/*/{Protheus.doc} GravaLog
Função para gravar logs de execução em arquivos separados por rotina. O log inclui data, hora, tipo, rotina, usuário e descrição.
@type function
@version 12.1.2510
@author João Mauricio
@since 3/27/2026
@param cTipo, character, tipo do log (e.g., INFO, ERROR, DEBUG)
@param cDescricao, character, descrição detalhada do evento a ser registrado no log
@param cRotina, character, nome da rotina ou módulo que está gerando o log, usado para nomear o arquivo de log correspondente
/*/
User Function GravaLog( cTipo, cDescricao, cRotina )
 
  Local cDirLog   := "./logs/fontes/"
  Local cArqLog   := cDirLog + Upper( cRotina ) + ".log"
  Local cLinha    := ""
  Local nHdl      := -1


  If !ExistDir( cDirLog )
    MakeDir( cDirLog )
  EndIf

  // monta a linha de log
  cLinha := "[" + DTOS( Date() ) + " " + Time()  + "] " + ;
            "[" + PadR( cTipo, 5 )            + "] " + ;
            "[" + Upper( cRotina )            + "] " + ;
            "[" + cUserName                   + "] " + ;
            cDescricao                                       + ;
            Chr(10)

  // abre o arquivo em modo append (FC_APPEND = 8)
  // se não existir, cria com fCreate primeiro
  If !File( cArqLog )
    nHdl := fCreate( cArqLog, 0 )
  Else
    nHdl := fOpen( cArqLog, 2 )  // 2 = leitura e escrita
    fSeek( nHdl, 0, 2 )          // move cursor para o final (append)
  EndIf

  If nHdl < 0
    Return  // falha ao abrir — evita erro em cascata
  EndIf

  fWrite( nHdl, cLinha )
  fClose( nHdl )

Return
