//Asantee Games
//Game: Space Explosions


//callback of the asteroids

void ETHCallback_asteroid(ETHEntity@ asteroid)
{
	asteroid.SetColor(vector3(0,1,1));
	asteroid.SetFloat("speed",g_scale.scale(60.0f));
	
	//2 types of asteroids, the one place in the scene when we build it. And the other that we created in a randon way
	if(asteroid.GetString("type") ==  "static")
		asteroid.AddToAngle(g_timeManager.scaledUnitsPerSecond(150.0f));
	else if(asteroid.GetString("type") == "randon")
	{
		asteroid.AddToPositionXY(g_timeManager.scaledUnitsPerSecond(vector2(0,5))*asteroid.GetFloat("speed"));
		
		if(asteroid.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(asteroid);
	}
	//if the "hp" of the entity is over, less/equal than 0, the entity is deleted
	if(asteroid.GetInt("hp") <= 0)
	{
		//AddEntity("explosion.ent",asteroid.GetPosition(),0);
		AddScaledEntity("explosion.ent",asteroid.GetPosition(),g_scale.getScale());
		DeleteEntity(asteroid);
		PlaySample("soundfx/asteroide_explosao.mp3");
	}
}

//callback of the shot

void ETHCallback_shot(ETHEntity@ shot)
{

	
		//when a shot is created by the Destroyer or the enemies the direction and speed are seted here
		shot.AddToPositionXY(g_timeManager.scaledUnitsPerSecond(shot.GetVector2("direction"))*shot.GetFloat("speed"));
	
		
		
		//handle the colision of the shot
		ETHEntityArray shotArray;
		
		GetEntitiesFromBucket(GetBucket(shot.GetPositionXY()),shotArray);

		for(uint i=0; i<shotArray.size(); i++)
		{
			
			if(shotArray[i].GetUInt("destroyable") == 1)
			{
				
					if(shotArray[i].GetUInt("team") != shot.GetUInt("team"))
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
		
	
	
	


 