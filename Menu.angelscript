//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto

class Menu : MainMenu
{
	
	
	/*void start()
	{
		LoadScene("empty",DEFAULT_ONSCENELOADED,DEFAULT_ONSCENEUPDATED);
	}*/
	Menu()
	{
		MainMenuProperties props;
		props.showMusicSwitch = true;
		props.showSoundSwitch = true;
		props.titleSprite = "sprites/logo_inicio.png";
		props.playButton = "sprites/start_game.png";
		props.buttonNormPos = vector2(0.5f,0.75f);
		props.titlePos = vector2(0.5f, 0.25f);
		super("empty",@props);
	}
	void preLoop()
	{
		MainMenu::preLoop();
		//carrega os sprites na memória
		//LoadSprite("sprites/logo_inicio.png");
		//LoadSprite("sprites/start_game.png");
	
	}
	void loop()
	{
	
		MainMenu::loop();
		/*ETHInput @ input =  GetInputHandle();
		
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
		DrawSprite("sprites/start_game.png",buttonPos,ARGB(255,255,255,255));*/
	
	}
		

}