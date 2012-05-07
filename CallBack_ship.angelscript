//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback os the ships statics


void ETHCallback_ship(ETHEntity @ ship)
{
	ship.SetColor(vector3(1,0,0));
	
	if(ship.GetInt("hp") <= 0)
	{
		AddEntity("explosion.ent",ship.GetPosition(),0);
		DeleteEntity(ship);
		PlaySample("soundfx/explosion_huge.mp3");
	}
}


//callback of the main ship, the Destroyer


void ETHCallback_Destroyer(ETHEntity @ ship)
{
	ETHInput @input = GetInputHandle();
	
	
	
	float speed = g_timeManager.unitsPerSecond(120.0f);
	
	//keyboard handle
	if(input.KeyDown(K_SHIFT))
	{
		speed *=2.0f;
	}
	
	
	
	if(input.KeyDown(K_UP))
	{
		ship.AddToPositionXY(vector2(0,-1)* speed);
	}
	
	if(input.KeyDown(K_DOWN))
	{
		ship.AddToPositionXY(vector2(0,1)* speed);
	}
	if(input.KeyDown(K_LEFT))
	{
		ship.AddToPositionXY(vector2(-1,0)* speed);
	}
	if(input.KeyDown(K_RIGHT))
	{
		ship.AddToPositionXY(vector2(1,0)* speed);
	}
	
	
	
	
	//creating a shot from the Destroyer
	
	if(input.GetKeyState(K_SPACE) == KS_HIT)
	{
		addShot(1,vector2(0,-5),ship.GetPosition());
		PlaySample("soundfx/tiro.mp3");
		
	}
	
	if(ship.GetInt("hp") <= 0)
	{
		AddEntity("explosion.ent",ship.GetPosition(),0);
		DeleteEntity(ship);
		PlaySample("soundfx/explosion_huge.mp3");
		return;
	}
	
	//control of colision from the Destroyer with the other "things" in the scene
	
	ETHEntityArray shipArray;
	
	vector2 BucketDaNave(GetBucket(ship.GetPositionXY()));
	
	GetEntitiesFromBucket(BucketDaNave,shipArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(0,-1),shipArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(0,1),shipArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(-1,0),shipArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(1,0),shipArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(-1,-1),shipArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(1,1),shipArray);

	for(uint i=0; i<shipArray.size(); i++)
	{
		if(shipArray[i].GetUInt("destrutivel") == 1)
		{
				if(shipArray[i].GetUInt("time") != ship.GetUInt("time"))
				{
					if(distance(ship.GetPositionXY(),shipArray[i].GetPositionXY()) < 64 )
					{
					print(shipArray[i].GetEntityName());
					shipArray[i].AddToInt("hp",-1);
					ship.AddToInt("hp",-1);
				
								
							
				
					}
			   }
		}
		
	}
	
	
	//handle the screen so the Destroyer don't go out of the screen
	if(ship.GetPositionXY().y > GetScreenSize().y)
		ship.SetPositionXY(vector2(ship.GetPositionXY().x,GetScreenSize().y));
	else if(ship.GetPositionXY().y < 0)
		ship.SetPositionXY(vector2(ship.GetPositionXY().x,0));
	else if(ship.GetPositionXY().x > GetScreenSize().x)
		ship.SetPositionXY(vector2(GetScreenSize().x,ship.GetPositionXY().y));
	else if(ship.GetPositionXY().x < 0)
		ship.SetPositionXY(vector2(0,ship.GetPositionXY().y));
	
}
