//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto
class Menu : State
{
	
	
	void start()
	{
		LoadScene("empty",DEFAULT_ONSCENELOADED,DEFAULT_ONSCENEUPDATED);
	}
	void onSceneLoaded()
	{
	
		//carrega os sprites na memória
		LoadSprite("sprites/logo_inicio.png");
		LoadSprite("sprites/start_game.png");
	
	}
	void onSceneUpdated()
	{
	
		ETHInput @ input =  GetInputHandle();
		
		vector2 cursorPos = input.GetCursorPos();
		vector2 buttonPos = GetScreenSize() * vector2(0.5f,0.75f);
		vector2 spriteSize = GetSpriteSize("sprites/logo_inicio.png");
		
		//se eu cliclar no meu logo_inicio, que é o sprite do "start game", o jogo deve ser inicialidzado
		//essa função acha a posição relativa do logo e se o mouse clicar lá, o jogo inicia
		if(isPointInRect(cursorPos,buttonPos,spriteSize,vector2(0.5f,0.5f)))
		{
			if(input.GetLeftClickState() == KS_HIT)
				g_stateManager.setState(Level(1));
		
		}	
		
		//vector2 vetor = GetSpriteSize("sprites/logo_inicio.png") * vector2(-0.5f,-0.5f);

		//DrawSprite("sprites/logo_inicio.png",vetor + GetScreenSize() * vector2(0.5f,0.25f),ARGB(255,255,255,255));
		SetSpriteOrigin("sprites/logo_inicio.png",vector2(0.5f,0.5f));
		DrawSprite("sprites/logo_inicio.png",GetScreenSize() * vector2(0.5f,0.25f),ARGB(255,255,255,255));
		SetSpriteOrigin("sprites/start_game.png",vector2(0.5f,0.5f));
		DrawSprite("sprites/start_game.png",buttonPos,ARGB(255,255,255,255));
	
	}
		

}