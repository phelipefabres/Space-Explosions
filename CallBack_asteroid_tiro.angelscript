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
	else if(asteroid.GetString("tipo") == "ambulante")
	{
		//cria o asteroide dinamicamente e faz ele se movimentar na cena
		asteroid.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,5))*asteroid.GetFloat("speed"));
		
		//deletar o objeto asteroide quando ele não estiver mais na cena
		if(asteroid.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(asteroid);
	}
}

//callback do tiro

//movimentando minha entidade 'tiro'
void ETHCallback_shot(ETHEntity@ shot)
{

	shot.SetFloat("speed",60.0f);
	//movimento do tiro, no caso a direçao e a velocidade
	
		shot.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,-5))*shot.GetFloat("speed"));
	
		
		
		//controle de colisão do tiro. Criamos um Array de entidades que captura todas as entidades dos buckets
		//se as entidades capturadas forem iguais a asteroid e nave, elas são deletadas pelo tiro
		ETHEntityArray shotArray;
		
		GetEntitiesFromBucket(GetBucket(shot.GetPositionXY()),shotArray);

		for(uint i=0; i<shotArray.size(); i++)
		{
			if(shotArray[i].GetEntityName() == "asteroid.ent" || shotArray[i].GetEntityName() == "nave.ent" 
				|| shotArray[i].GetEntityName() == "nave_chefe.ent" || shotArray[i].GetEntityName() == "nave_aux.ent")
			{
				if(distance(shot.GetPositionXY(),shotArray[i].GetPositionXY()) < 40 )
				{
						if(shotArray[i].GetEntityName() == "nave_chefe.ent" || shotArray[i].GetEntityName() == "nave_aux.ent")
						{
							shotArray[i].AddToInt("hp",-1);
							//print(shotArray[i].GetInt("hp"));
						}
						else
						{
							//coloca a explosão na cena antes de deletar as entidades
							AddEntity("explosion.ent",shotArray[i].GetPosition(),0);
							DeleteEntity(shotArray[i]);
							
							if(shotArray[i].GetEntityName() == "asteroid.ent" )
								PlaySample("soundfx/asteroide_explosao.mp3");
							else
								PlaySample("soundfx/explosion_huge.mp3");
						}
						DeleteEntity(shot);
					}
			}
			else
			{
				shot.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,10))*shot.GetFloat("speed"));
						
				if(shotArray[i].GetEntityName() == "Destroyer")
				{
					if(distance(shot.GetPositionXY(),shotArray[i].GetPositionXY()) < 40 )
					{
					//coloca a explosão na cena antes de deletar as entidades
						AddEntity("explosion.ent",shotArray[i].GetPosition(),0);
						DeleteEntity(shotArray[i]);
						PlaySample("soundfx/explosion_huge.mp3");
					}
						
					DeleteEntity(shot);
				}
			}
					
					
					
					
					
	}
	
	//se o tiro ultrapassar o limite da tela, ele é deletado
		if(shot.GetPositionXY().y < 0)
				DeleteEntity(shot);
}
		
	
	
	


 