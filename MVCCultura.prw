#INCLUDE 'Totvs.ch'
#INCLUDE 'Fwmvcdef.ch'          
#INCLUDE 'FwEditPanel.ch
#INCLUDE "TopConn.ch"
#INCLUDE 'Protheus.ch'

/*/{Protheus.doc} RCOMA006
Rotina para gera Pre nota CT-e importados
@author Leandro Rodrigues
@since 21/01/2020
@version P12
@param nulo7
@return nulo
/*/
User Function MVCCULTURA()      
Local aArea     := GetArea()

Local oBrw      

oBrw := fwmBrowse():New()   

oBrw:SetAlias("ZB1")
oBrw:SetDescription("Cadastro de Cultura")                  
      

oBrw:Activate()

RestArea(aArea)
Return  

//-----------------------------------------------------------------------
// Montagem do Menu
//-----------------------------------------------------------------------
Static Function MenuDef()

//Local aRotina := FwMvcMenu("MVCCULTURA")
	
Local aRotina := {}
	

ADD OPTION aRotina TITLE 'Visualizar'            ACTION 'VIEWDEF.MVCCULTURA'  OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'               ACTION 'VIEWDEF.MVCCULTURA'  OPERATION 3 ACCESS 0 
ADD OPTION aRotina TITLE 'Alterar'               ACTION 'VIEWDEF.MVCCULTURA'  OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'               ACTION 'VIEWDEF.MVCCULTURA'  OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Função que cria o objeto model			
@author Leandro Rodrigues
@since 24/01/2020
@version P12
@param Nao recebe parametros            
@return nulo
/*/
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZB1  := FWFormStruct( 1, 'ZB1', /*bAvalCampo*/,/*lViewUsado*/ ) // Cabecalho
Local oModel
	
// Cria o objeto do Modelo de Dados
oModel := MPFormModel():New('PMVCCULTURA',/*bPreValidacao*/,/*bPosValidacao*/,/*bCommit*/,/*bCancel*/ )
	
// Adiciona ao modelo uma estrutura de formulário de edicao por campo
oModel:AddFields('ZB1MASTER', /*cOwner*/, oStruZB1, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )

// Adiciona a chave primaria da tabela principal
oModel:SetPrimaryKey({ "ZB1_FILIAL", "ZB1_CODCUL"})		
// Adiciona a descricao do Modelo de Dados
oModel:SetDescription( 'Cadastro de Cultura')
	
// Adiciona a descrição dos Componentes do Modelo de Dados
oModel:GetModel( 'ZB1MASTER' ):SetDescription( 'Cadastro de cultura' )
	                                                          	
Return oModel

/*/{Protheus.doc} ModelDef
Função que cria o objeto View			
@author Leandro Rodrigues
@since 12/12/2019
@version P12
@param Nao recebe parametros            
@return nulo
/*/

Static Function ViewDef() 

// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
Local oModel   := FWLoadModel( 'MVCCULTURA' )   
	
// Cria a estrutura a ser usada na View
Local oStruZB1  := FWFormStruct( 2, 'ZB1' ) 
Local oView

// Cria o objeto de View
oView := FWFormView():New()
	
// Define qual o Modelo de dados ser· utilizado
oView:SetModel( oModel )
	
//Adiciona no nosso View um controle do tipo FormFields(antiga enchoice)
oView:AddField( 'VIEW_ZB1', oStruZB1, 'ZB1MASTER')
	
//Cria Folder para organizar separacao de tela
oView:CreateVerticalBox("PANEL_GERAL", 100)

// Relaciona o identificador (ID) da View com o "box" para exibição
 oView:SetOwnerView('VIEW_ZB1'	,'PANEL_GERAL')
   
// titulo dos componentes                      	 
oView:EnableTitleView('VIEW_ZB1' ,'Cadastro de Cultura')                           	 
	
// Habilita a quebra dos campos na Vertical
oView:SetViewProperty( 'ZB1MASTER', 'SETLAYOUT', { FF_LAYOUT_VERT_DESCR_TOP , 3 } )

oView:SetCloseOnOk({ || .T. })  //Fecha a Tela ao confirmar	 
	
Return oView
