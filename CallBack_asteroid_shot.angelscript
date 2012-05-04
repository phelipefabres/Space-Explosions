//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback dos asteroides

//movimento do asteroid, no caso o 'AddToAngle' faz com que ele gire no próprio eixo no sentido horário em uma velocidade
void ETHCallback_asteroid(ETHEntity@ asteroid)
{
	asteroid.SetColor(vector3(0,1,1));
	asteroid.SetFloat("speed",60.0f);
	
	if(asteroid.GetString("tipo") ==  "estatico")
		asteroid.AddToAngle(g_timeManager.unitsPerSecond(150.0f));
	else if(asteroid.GetString("tipo") == "crazyAsteroid")
	{
		//cria o asteroide dinamicamente e faz ele se movimentar na cena
		asteroid.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,5))*asteroid.GetFloat("speed"));
		
		//deletar o objeto asteroide quando ele não estiver mais na cena
		if(asteroid.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(asteroid);
	}
	
	if(asteroid.GetInt("hp") <= 0)
	{
		AddEntity("explosion.ent",asteroid.GetPosition(),0);
		DeleteEntity(asteroid);
		PlaySample("soundfx/asteroide_explosao.mp3");
	}
}

//callback do tiro

//movimentando minha entidade 'tiro'
void ETHCallback_shot(ETHEntity@ shot)
{

	
	//movimento do tiro, no caso a direçao e a velocidade
	
		shot.AddToPositionXY(g_timeManager.unitsPerSecond(shot.GetVector2("direcao"))*shot.GetFloat("speed"));
	
		
		
		//controle de colisão do tiro. Criamos um Array de entidades que captura todas as entidades dos buckets
		//se as entidades capturadas forem iguais a asteroid e nave, elas são deletadas pelo tiro
		ETHEntityArray shotArray;
		
		GetEntitiesFromBucket(GetBucket(shot.GetPositionXY()),shotArray);

		for(uint i=0; i<shotArray.size(); i++)
		{
			
			if(shotArray[i].GetUInt("destrutivel") == 1)
			{
				
					if(shotArray[i].GetUInt("time") != shot.GetUInt("time"))
					{
						if(distance(shot.GetPositionXY(),shotArray[i].GetPositionXY()) < 40 )
						{
							shotArray[i].AddToInt("hp",-1);
							DeleteEntity(shot);
						}
											
					}
			}
		}

	
	//se o tiro ultrapassar o limite da tela, ele é deletado
		if(shot.GetPositionXY().y < 0 || shot.GetPositionXY().y > GetScreenSize().y)
				DeleteEntity(shot);
}
		
	
	
	


 