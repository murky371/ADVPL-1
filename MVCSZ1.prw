#include 'Protheus.ch'
#include 'FWMVCDEF.ch'

User Function MVCSZ1()
	Local aArea := GetNextAlias()
	Local oBrowseSZ1  //Variavel objeto que recebera o instanciamento da classe FWMBrowse

	oBrowseSZ1 := FWMBrowse():New()

	//Passo como parametro a tabela que eu quero mostrar no Browse
	oBrowseSZ1:SetAlias("SZ1")

	oBrowseSZ1:SetDescription("Meu Primeiro Browse - Tela de Protheus SZ1")
	//EXPRESSAO            //COR
	// oBrowseSZ1:AddLegend("SZ1->Z1_STATUS == '1'", "BLUE","Protheuzeiro ativo")
	// oBrowseSZ1:AddLegend("SZ1->Z1_STATUS == '2'", "RED", "Protheuzeiro inativo")
	// oBrowseSZ1:AddLegend("SZ1->Z1_STATUS == ' '", "GREEN", "Protheuzeiro ativado")

	oBrowseSZ1:AddLegend("SZ1->Z1_SEXO == '1'", "BLUE", "Protheuzeiro ativado")
	oBrowseSZ1:AddLegend("SZ1->Z1_SEXO == '2'", "BR_VIOLETA", "Protheuzeiro Inativo")

	//fAZ COM QUE SOMENTE ESSES CAMPOS APARECAM NO GRID
	//oBrowseSZ1:SetOnlyFields({"Z1_CODIGO","Z1_SEXO","Z1_NOME","Z1_STATUS"})


	oBrowseSZ1:SetDisableDetails()

	oBrowseSZ1:Activate()

Return


	//=================================================

	//FUNCAO DE MENU

	//=====================================================


Static Function MenuDef()
	Local aRotina := {}
    Local n

	aRotina :=  {}
	aRotinaAux :=  FwMvcMenu("MVCSZ1") //Recebe os menus automaticamente

        //Populo a Variavel aRotina
	ADD OPTION aRotina TITLE 'Legenda'      ACTION 'u_SZ1LEG'         OPERATION 6 ACCESS 0
	ADD OPTION aRotina TITLE 'Sobre'        ACTION 'u_SZ1SOBRE'       OPERATION 6 ACCESS 0

	For n := 1 To Len(aRotinaAux)
		aAdd(aRotina,aRotinaAux[n])

            Next n

		Return aRotina

		//=============================================

		//FUNÇAO MODEL

		//====================================================
		//   ||
		//   V
Static Function ModelDef()
	Local oModel := Nil

	//Traz a estrutura da SZ1(CARACTERISTICAS DOS CAMPOS), PARA O MODELO, POR ISSO O PARAMETRO 1 NO INICIO
	Local oStructSZ1 := FWFormStruct(1,"SZ1")

	oModel := MPFormModel():New("MVCSZ1M")

	//Atribuindo o formulario para o modelo de dados!!
	oModel:AddFields("FORMSZ1",/*Owner*/,oStructSZ1)

	//Definindo Chave Primaria para a aplicaçao
	oModel:SetPrimaryKey({"Z1_FILIAL", "Z1_CODIGO"})

	oModel:SetDescription("Modelo de dados do cadastro do protheus")

	oModel:GetModel("FORMSZ1"):SetDescription("Formulario de cadastro Protheus")
Return oModel


//===========================================


//       FUNCAO VIEW


//===============================================


Static Function ViewDef()
	Local oView := Nil

	//funçao que retorna o objeto de model de determinado fonte
	Local oModel := FwLoadModel("MVCSZ1")

	//Chama a estrutura
	Local oStructSZ1 := FWFormStruct(2,"SZ1") //Traz a estrutura da SZ1 - (1 para model | 2 para view_)

	//Construindo a parte de visao dos dados
	oView := FWFormView():New()

	//Passando o modelo do view informado
	oView:SetModel(oModel)

    //Removendo o campo para o usuario
	oStructSZ1:RemoveField("Z1_ESCIVIL")

	//Atribuiçao a estrutura da dados a camada de visão
	oView:AddField("VIEWSZ1",oStructSZ1,"FORMSZ1")

	//Criando um container com o identificador de tela
	oView:CreateHorizontalBox("TELASZ1",100)

	//Adicionando titulo ao formulario
	oView:EnableTitleView("VIEWSZ1","Visualizaçao do protheus")

	//Força o fechamento da janela passando o valor True
	oView:SetCloseOnOk({|| .T.})

	oView:SetOwnerView("VIEWSZ1","TELASZ1")
Return oView


//=============================================

	// Funçao Legenda

//===========================================================


User Function SZ1LEG()
	Local aLegenda := {}


	aADD(aLegenda,{"BR_VERDE","Ativo"})
	aADD(aLegenda,{"BR_Vermelho","Inativo"})

	BrwLegenda("Protheuzeiros","Ativos/Inativos",aLegenda)
Return aLegenda


//======================================================

	//Funçao Sobre

//==================================================


User Function SZ1SOBRE()
	Local cSobre

	cSobre := "- <b>Minha Primeira tela em mvc modelo 1 <br> Este fonte foi desenvolvido Por um estudante de Protheus da sistematizei"
	MsgInfo(cSobre)
Return
