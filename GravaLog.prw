#include "protheus.ch"

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

  Local cArqLog  := FWLogDir() + "fontes\" + Upper( cRotina ) + ".log"
  Local cLinha   := ""
  Local nHdl     := 0

  MakeDir( FWLogDir() + "fontes\" )

  cLinha := "[" + DTOS( Date() ) + " " + Time()    + "] " + ;
            "[" + PadR( cTipo, 5 )              + "] " + ;
            "[" + Upper( cRotina )              + "] " + ;
            "[" + cUserName                     + "] " + ;
            cDescricao                                         + ;
            Chr(13) + Chr(10)

  nHdl := FT_FUSE( cArqLog )
  FT_FWRITE( nHdl, cLinha )
  FT_FCLOSE( nHdl )

Return
