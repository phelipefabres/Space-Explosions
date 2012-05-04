//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback das outras naves

//laço contínuo do jogo para a entidade nave...aqui no caso para as naves alvos..seta apenas a cor das alvos
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


//callback da Destroyer, nave principal


//nave "principal", contrala comandos de movimentação e velocidade além de criar o tiro
void ETHCallback_Destroyer(ETHEntity @ ship)
{
	ETHInput @input = GetInputHandle();
	
	//variável da velocidade
	
	float speed = g_timeManager.unitsPerSecond(120.0f);
	
	//se o shift estiver precionado aumenta a velocidade em 2 vz
	if(input.KeyDown(K_SHIFT))
	{
		speed *=2.0f;
	}
	
	
	//manipulação de teclado
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
	
	
	
	
	//criando o tiro a partir da nave
	
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
	
	//aqui estamos adicionando no array de entidades todos os buckets ao redor da minha nave, assim quando a
	//distância for pequena e eles se colidirem minha nave principal explode.
	
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
	
	
	//delimitando o movimento da Destroyer
	if(ship.GetPositionXY().y > GetScreenSize().y)
		ship.SetPositionXY(vector2(ship.GetPositionXY().x,GetScreenSize().y));
	else if(ship.GetPositionXY().y < 0)
		ship.SetPositionXY(vector2(ship.GetPositionXY().x,0));
	else if(ship.GetPositionXY().x > GetScreenSize().x)
		ship.SetPositionXY(vector2(GetScreenSize().x,ship.GetPositionXY().y));
	else if(ship.GetPositionXY().x < 0)
		ship.SetPositionXY(vector2(0,ship.GetPositionXY().y));
	
}
