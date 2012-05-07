//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback of the asteroids

void ETHCallback_asteroid(ETHEntity@ asteroid)
{
	asteroid.SetColor(vector3(0,1,1));
	asteroid.SetFloat("speed",60.0f);
	
	if(asteroid.GetString("tipo") ==  "estatico")
		asteroid.AddToAngle(g_timeManager.unitsPerSecond(150.0f));
	else if(asteroid.GetString("tipo") == "crazyAsteroid")
	{
		asteroid.AddToPositionXY(g_timeManager.unitsPerSecond(vector2(0,5))*asteroid.GetFloat("speed"));
		
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

//callback of the shot

void ETHCallback_shot(ETHEntity@ shot)
{

	
	
		shot.AddToPositionXY(g_timeManager.unitsPerSecond(shot.GetVector2("direcao"))*shot.GetFloat("speed"));
	
		
		
		//handle the colision of the shot
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

	
	//delete the shot when it go out of the screen
		if(shot.GetPositionXY().y < 0 || shot.GetPositionXY().y > GetScreenSize().y)
				DeleteEntity(shot);
}
		
	
	
	


 