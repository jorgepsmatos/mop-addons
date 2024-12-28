--[[///////////////////////////////////////////////////////////////////////////////////////
    GENIE 5.2.0

    Author: adjo
    Website: http://wow.curseforge.com/projects/genie
    Feedback: http://wow.curseforge.com/projects/genie/tickets/
    Localization: http://wow.curseforge.com/addons/genie/localization/
    
	adjo 2013-04-22T11:49:39Z   

	This document may be redistributed as a whole, 
    provided it is unaltered and this copyright notice is not removed.    
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
    LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
    
--///////////////////////////////////////////////////////////////////////////////////////]]

local L = LibStub("AceLocale-3.0"):NewLocale("Genie", "ptBR")
if not L then return end
--[[///////////////////////////////////////////////////////////////////////////////////////
    Automatic translation injection

	NOTE: Do NOT translate strings here!
	If you want to translate, do so at
	http://wow.curseforge.com/addons/genie/localization/
--///////////////////////////////////////////////////////////////////////////////////////]]
L["Add"] = "Adicionar"
L["Add a class/family to the ranking"] = "Adicionar uma classe/família à classificação"
L["Add an element to this X"] = "Adicionar um elemento a esse X"
L["AddonNotes"] = "O Genie ajuda a organizar suas bolsas, banco e/ou banco da guilda"
L["All items are beeing ignored"] = "Todos os itens estão sendo ignorados"
L["Alt"] = "Alt"
L["Always"] = "Sempre"
L["And"] = "E"
L["As you wish master"] = "Como quiser, mestre"
L["AttachTo"] = "VincularA"
L["Automatic"] = "Automático"
L["Automatic events"] = "Eventos automáticos"
L["Automatic mode"] = "Modo automático"
L["Bag"] = "Bolsa"
L["bag/ bank or guildbank"] = "bolsa/banco ou banco da guilda"
L["Bags"] = "Bolsas"
L["BagWork"] = "Trabalhar com as bolsas"
L["Bank"] = "Banco"
L["BANKFRAME_CLOSED"] = "Checou seu Banco"
L["BANKFRAME_OPENED"] = "Abrir seu Banco"
L["BankWork"] = "Trabalhar com o banco"
L["Bool"] = "Booleano"
L["Classranking"] = "Classificação por classe"
L["Colors"] = "Cores"
L["Combine"] = "Combinar"
L["Combined"] = "Combinado"
L["Combine one or more ranks"] = "Combinar uma ou mais classificações"
L["Configmode"] = "Mododeconfiguração"
L["Contains"] = "Contém"
L["Count"] = "Contagem"
L["Create"] = "Criar"
L["Created"] = "Criado"
L["Criteria"] = "Critério"
L["Current content of X"] = "Conteúdo atual de X"
L["Custom family"] = "Família personalizada"
L["Custom family:short"] = "FP"
L["Delete"] = "Apagar"
L["Delete a combined rank"] = "Apagar uma classificação combinada"
L["Deleted"] = "Apagado"
L["Disable"] = "Desabilitar"
L["Disable a class"] = "Desabilitar uma classe"
L["Disabled"] = "Desabilitado"
L["Disabled:short"] = "D"
L["Display detailed infos about a rank"] = "Mostrar informações detalhadas sobre uma classificação"
L["Enable"] = "Habilitar"
L["Enable a class"] = "Habilitar uma classe"
L["Enabled"] = "Habilitado"
L["EquipLoc"] = "Localização do equipamento"
L["Equipment sets"] = "Conjuntos de equipamentos"
L["EQUIPMENT_SWAP_FINISHED"] = "Mudou o conjunto de equipamentos"
L["Events"] = "Eventos"
L["Family"] = "Família"
L["Fast"] = "Rápido"
L["Filter"] = "Filtro"
L["Finished"] = "Finalizado"
L["Genie"] = "Genie"
L["GUI"] = "GUI"
L["Guildbank"] = "Bancodaguilda"
L["Guildbank delay"] = "Atraso"
L["Guildbank delay:desc"] = "O Genie vai atrasar cada troca de item por este valor (mais algum ajuste adicional de latência)"
L["GUILDBANKFRAME_CLOSED"] = "Checou seu Banco da Guilda"
L["Guildbank-Tab 'X' unlocked. You're welcome."] = "Aba 'X' do Banco da Guilda destravada. Não há de quê."
L["GuildbankWork"] = "Trabalhar com o banco da guilda"
L["Highlight"] = "Destacar"
L["Ignore"] = "Ignorar"
L["Ignore all elements of this X"] = "Ignorar todos os elementos desse X"
L["Ignore all elements of X"] = "Ignorar todos os elementos de X"
L["iLvl"] = "Níveldoitem"
L["I'm locking Guildbank-Tab 'X'. Step back!"] = "Estou travando a aba 'X' do Banco da Guilda. Para trás!"
L["I need to know on which tabs i'm allowed to work"] = "Eu preciso saber em que abas tenho permissão para trabalhar"
L["Inspect"] = "Inspecionar"
L["Inventory"] = "Inventário"
L["Invert"] = "Inverter"
L["Invert a class"] = "Inverter uma classe"
L["Inverted:short"] = "I"
L["Invert the sorting order"] = "Inverter a ordem de classificação"
L["ItemID"] = "IDdoItem"
L["I've done what you requested in X seconds"] = "Eu fiz o que você pediu em X segundos"
L["I will try to read your mind master"] = "Eu vou tentar ler sua mente, Mestre"
L["Keyring"] = "Chaveiro"
L["LeftClick"] = "Clique esquerdo"
L["Lock the Guildbank"] = "Travar o Banco da Guilda"
L["Lock the Guildbank:desc"] = "Travar a aba do Banco da Guilda onde o Genie está trabalhando no momento"
L["LOOT_CLOSED"] = "Saqueado"
L["MAIL_CLOSED"] = "Checou a caixa de correio"
L["Master i apologize, there where some errors. I had to stop"] = "Mestre, eu peço desculpas, houve alguns erros. Eu tive que parar"
L["Master, i can't work with an empty container"] = "Mestre, não posso trabalhar com um recipiente vazio."
L["Master, that's one thing i'm not allowed to do"] = "Mestre, essa é uma coisa que não tenho permissão para fazer"
L["Master, there's nothing (more) to do"] = "Mestre, não há nada (mais) a fazer"
L["MERCHANT_CLOSED"] = "Visitou um Vendedor"
L["Minimap"] = "Minimapa"
L["MinLevel"] = "Nível Mínimo"
L["Mode"] = "Modo"
L["Move all items"] = "Mover todos os itens"
L["Moving"] = "Movendo"
L["Name"] = "Nome"
L["New"] = "Novo"
L["No X defined"] = "Nenhum X definido"
L["Number"] = "Número"
L["Open the options menu"] = "Abrir o menu de opções"
L["Open the ranking editor"] = "Abrir o editor de classificação"
L["Or"] = "Ou"
L["Price"] = "Preço de venda"
L["Questitem"] = "Item de Missão"
L["Rarity"] = "Qualidade"
L["Remove"] = "Remover"
L["Remove an element from this X"] = "Remover um elemento desse X"
L["Rename"] = "Renomear"
L["Reset the classranking"] = "Reiniciar a classificação de classes"
L["Reverse"] = "Inverso"
L["Reverse the order in which your bags and/or bagslots will be accsessed"] = "Inverter a ordem na qual suas bolsas e/ou espaços de bolsa serão acessados."
L["RightClick"] = "Clique direito"
L["Shift"] = "Shift"
L["Show"] = "Mostrar"
L["Show current X"] = "Mostrar X atual"
L["Silent"] = "Silêncio"
L["SlotCooldown"] = "Tempo de recarga do espaço de bolsa"
L["SlotCooldown:desc"] = "Tempo em segundos que o Genie deve esperar antes de reutilizar um slot específico. Configure para 0 (Zero) se não quiser espera."
L["Slots"] = "Espaços"
L["Sort all items"] = "Classificar todos os itens"
L["sort_heap"] = "ClassificarEmLote"
L["Sorting"] = "Classificando"
L["Sorting algorithm"] = "Algoritmo de classificação"
L["sort_insert"] = "ClassificaInserindo"
L["sort_quick3"] = "ClassificaRapido3"
L["sort_select"] = "ClassificaSelecao"
L["Soulbound"] = "Vinculado"
L["Sound"] = "Som"
L["Stack all items"] = "Empilhar todos os itens"
L["StackCount"] = "Contagemdapilha"
L["Stacking"] = "Empilhamento"
L["Stack, move and sort your X"] = "Empilhar, mover e classificar seu X"
L["Stop"] = "Parar"
L["Strg"] = "Control"
L["String"] = "Cadeia de caracteres"
L["SubType"] = "Subtipo"
L["SwapsPerCycle"] = "Trocas por ciclo"
L["SwapsPerCycle:desc"] = "Cada ciclo o Genie troca uma quantidade específica de itens. Configure para 0 (Zero) se quiser que o Genie troque todos de uma vez."
L["Sync"] = "Sincronizar"
L["Text"] = "Texto"
L["Texture"] = "Textura"
L["Toggle config mode"] = "Ligar/desligar modo de configuração"
L["ToggleWithRankingEditor"] = "Ligar/desligar com o editor de classificação"
L["ToggleWithRankingEditorDesc"] = "Ligar/desligar modo de configuração quando abrindo/fechando o editor de classificação"
L["Tooltip"] = "Dica de tela"
L["TRADE_CLOSED"] = "Negociou com alguém"
L["Tradeskill"] = "Profissão"
L["TRADESKILL_CREATE"] = "Criou alguma coisa"
L["TradeskillLvl"] = "NivelDaProfissao"
L["TStID"] = "CICL"
L["Type"] = "Tipo"
L["Unique"] = "Único"
L["Unknown"] = "Desconhecido"
L["Update"] = "Atualizar"
L["Update a class"] = "Atualizar uma classe"
L["Updated"] = "Atualizado"
L["UseProfile"] = "UsarPerfil"
L["Verbosity"] = "Verbosidade"
L["Version"] = "Versão"
L["waitAfter"] = "Aguardar após combate"
L["When"] = "Quando"
L["Work"] = "Trabalhar"
L["X added to Y"] = "X adicionado a Y"
L["X has been updated"] = "X foi atualizado"
L["X is empty"] = "X está vazio"
L["X removed from Y"] = "X removido de Y"
L["X renamed to Y"] = "X renomeado para Y"


--[[///////////////////////////////////////////////////////////////////////////////////////
	translated auctionitemclasses

    Usage: L[L['Weapon']()] to get the translated type
    Note: Update if auctionitemclasses are added/removed
--///////////////////////////////////////////////////////////////////////////////////////]]
L["Weapon"] = function() return "aic01" end
L["Armor"] = function() return "aic02" end
L["Container"] = function() return "aic03" end
L["Consumable"] = function() return "aic04" end
L["Glyph"] = function() return "aic05" end
L["Trade Goods"] = function() return "aic06" end
L["Recipe"] = function() return "aic07" end
L["Gem"] = function() return "aic08" end
L["Miscellaneous"] = function() return "aic09" end
L["Quest"] = function() return "aic10" end
L["BattlePets"] = function() return "aic11" end

local itemClasses = { GetAuctionItemClasses() }
if #itemClasses > 0 then
	for i, itemClass in pairs(itemClasses) do
        local icString = "aic".. string.format('%.2d',i)
    
		L[icString] = itemClass
		local itemSubClasses = { GetAuctionItemSubClasses(i) }
		if #itemSubClasses > 0 then
			for j, itemSubClass in pairs(itemSubClasses) do
				L[icString..string.format('%.2d',j)] = itemClass .. '>' .. itemSubClass
			end
		else
			L[icString.. "00"] = itemClass
		end
	end
end
