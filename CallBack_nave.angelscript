﻿//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback das outras naves

//laço contínuo do jogo para a entidade nave...aqui no caso para as naves alvos..seta apenas a cor das alvos
void ETHCallback_nave(ETHEntity @ nave)
{
	nave.SetColor(vector3(1,0,0));
}


//callback da Destroyer, nave principal


//nave "principal", contrala comandos de movimentação e velocidade além de criar o tiro
void ETHCallback_Destroyer(ETHEntity @ nave)
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
		nave.AddToPositionXY(vector2(0,-1)* speed);
	}
	
	if(input.KeyDown(K_DOWN))
	{
		nave.AddToPositionXY(vector2(0,1)* speed);
	}
	if(input.KeyDown(K_LEFT))
	{
		nave.AddToPositionXY(vector2(-1,0)* speed);
	}
	if(input.KeyDown(K_RIGHT))
	{
		nave.AddToPositionXY(vector2(1,0)* speed);
	}
	
	
	//delimitando o movimento da Destroyer
	if(nave.GetPositionXY().y > GetScreenSize().y)
		nave.SetPositionXY(vector2(nave.GetPositionXY().x,GetScreenSize().y));
	else if(nave.GetPositionXY().y < 0)
		nave.SetPositionXY(vector2(nave.GetPositionXY().x,0));
	else if(nave.GetPositionXY().x > GetScreenSize().x)
		nave.SetPositionXY(vector2(GetScreenSize().x,nave.GetPositionXY().y));
	else if(nave.GetPositionXY().x < 0)
		nave.SetPositionXY(vector2(0,nave.GetPositionXY().y));
	
	
	
	
	//criando o tiro a partir da nave
	ETHEntity @ tiro;
	if(input.GetKeyState(K_SPACE) == KS_HIT)
	{
		AddEntity("shot.ent",nave.GetPosition(),tiro);
		PlaySample("soundfx/tiro.mp3");
		tiro.SetString("tipo","destroyer");
	}
	
	//aqui estamos adicionando no array de entidades todos os buckets ao redor da minha nave, assim quando a
	//distância for pequena e eles se colidirem minha nave principal explode.
	
	ETHEntityArray naveArray;
	
	vector2 BucketDaNave(GetBucket(nave.GetPositionXY()));
	
	GetEntitiesFromBucket(BucketDaNave,naveArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(0,-1),naveArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(0,1),naveArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(-1,0),naveArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(1,0),naveArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(-1,-1),naveArray);
	GetEntitiesFromBucket(BucketDaNave + vector2(1,1),naveArray);

	for(uint i=0; i<naveArray.size(); i++)
	{
		if(naveArray[i].GetEntityName() == "asteroid.ent" || naveArray[i].GetEntityName() == "nave.ent" 
			|| naveArray[i].GetEntityName() == "nave_chefe.ent" || naveArray[i].GetEntityName() == "nave_aux.ent")
			{
				if(distance(nave.GetPositionXY(),naveArray[i].GetPositionXY()) < 64 )
				{
					AddEntity("explosion.ent",naveArray[i].GetPosition(),0);
					AddEntity("explosion.ent",nave.GetPosition(),0);
					DeleteEntity(naveArray[i]);
					DeleteEntity(nave);
				
								
				if(naveArray[i].GetEntityName() == "asteroid.ent" )
					PlaySample("soundfx/asteroide_explosao.mp3");
				else
					PlaySample("soundfx/explosion_huge.mp3");
					
				
				
			}
		}
		
	}
	
}
