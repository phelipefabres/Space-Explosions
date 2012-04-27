//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Código principal



#include "eth_util.angelscript"
#include "State.angelscript"
#include "Menu.angelscript"
#include "StateMachine.angelscript"
#include "CallBack_asteroid_tiro.angelscript"
#include "CallBack_nave.angelscript"
#include "functions.angelscript"
#include "Level.angelscript"




//inicia o cena inicial no jogo
void main()
{
	g_stateManager.setState(Menu());
}

void onSceneLoaded()
{
	g_stateManager.runCurrentPreLoopFunction();
}

void onSceneUpdated()
{
	g_stateManager.runCurrentLoopFunction();
}



