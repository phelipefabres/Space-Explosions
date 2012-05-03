//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto

class Level : GameState
{

	uint deadTime;
	uint level;
	uint tempo;
	uint cont;
	uint tempo_chefe;
		uint cont2;
		
	Level(uint _level)
	{
		deadTime = 0;
		level = _level;
		tempo = 0;
		cont = 0;
		tempo_chefe = 0;
		cont2 = 0;
		GameStateProperties props;
		super(_level, "scenes/start.esc", @props);
	}
	
	
	
	void preLoop()
	{
		GameState::preLoop();
		
		SetAmbientLight(vector3(1,1,1));
		
		
		//loader de som, nesse caso o SoundEffect carrega o som na memória direto pois ele não será usado constantemente apenas em certos momentos.
		LoadSoundEffect("soundfx/tiro.mp3");
		LoadSoundEffect("soundfx/asteroide_explosao.mp3");
		LoadSoundEffect("soundfx/explosion_huge.mp3");
		
		
		//com o LoadMusic eu faço um Streaming da trilha em vez de carregar tudo na memória, assim eu não sobrecarrego o jogo
		LoadMusic("soundfx/trilha.mp3");
		LoopSample("soundfx/trilha.mp3",true);
		PlaySample("soundfx/trilha.mp3");
	
	}
	
	
	void loop()
	{
		GameState::loop();
		
		
		ETHInput @ input =  GetInputHandle();
	
		if(input.GetKeyState(K_ESC) == KS_HIT)
		{
			g_stateManager.setState(Menu());
			StopSample("soundfx/trilha.mp3");
		}
		
		//se a nave principal colidir, a cena acaba
		if(SeekEntity("asteroid.ent") is null && SeekEntity("nave.ent") is null && SeekEntity("nave_chefe.ent") is null)
		{
			deadTime += g_timeManager.getLastFrameElapsedTime();
			StopSample("soundfx/trilha.mp3");
		
			if(deadTime >= 3000)
				g_stateManager.setState(Menu());
		}
		else if(SeekEntity("Destroyer") is null )
		{
			if(m_layerManager.getCurrentLayer().getName() != "GameOverLayer")
			{
				addLayer(GameOverLayer());
				m_layerManager.setCurrentLayer("GameOverLayer");
			}
		}
		
		if (cont < 10)
			tempo += g_timeManager.getLastFrameElapsedTime();
			
		//criação do asteroide na cena
		ETHEntity @ ambulante;
		ETHEntity @ auxiliar;
		ETHEntity @ chefe;
		
		//a cada dois segundos ele "desce" na tela
		if(tempo >= 2000)
		{
			AddEntity("asteroid.ent",vector3(randF(GetScreenSize().x),-30,0), ambulante);
			AddEntity("nave_aux.ent",vector3(randF(GetScreenSize().x),-30,0),auxiliar);
			ambulante.SetString("tipo", "ambulante");//seta o tipo dele como ambulante para se diferenciar do outro tipo
			tempo =0;
			cont++;
		}
		
		if(cont2<5)
			tempo_chefe += g_timeManager.getLastFrameElapsedTime();
		
		
		
		if(tempo_chefe >= 1000)
		{
			AddEntity("nave_chefe.ent",vector3(randF(GetScreenSize().x),-30,0),chefe);
			chefe.SetUInt("tiro",0);
			tempo_chefe=0;
			cont2++;
		}
		
		
		
		DrawText(vector2(0,200), "Entidades = "+ GetNumEntities(),"Verdana14_shadow.fnt", ARGB(250,255,255,255));
		
		
		
	}

}