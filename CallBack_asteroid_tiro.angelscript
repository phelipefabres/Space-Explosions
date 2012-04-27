//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto


//callback dos asteroides

//movimento do asteroid, no caso o 'AddToAngle' faz com que ele gire no próprio eixo no sentido horário em uma velocidade
void ETHCallback_asteroid(ETHEntity@ asteroid)
{
	asteroid.SetColor(vector3(0,1,1));
	
	if(asteroid.GetString("tipo") ==  "estatico")
		asteroid.AddToAngle(2.5f);
	else if(asteroid.GetString("tipo") == "ambulante")
	{
		//cria o asteroide dinamicamente e faz ele se movimentar na cena
		asteroid.AddToPositionXY(vector2(0,5));
		
		//deletar o objeto asteroide quando ele não estiver mais na cena
		if(asteroid.GetPositionXY().y > GetScreenSize().y)
			DeleteEntity(asteroid);
	}
}

//callback do tiro

//movimentando minha entidade 'tiro'
void ETHCallback_shot(ETHEntity@ shot)
{
	//movimento do tiro, no caso a direçao e a velocidade
	shot.AddToPositionXY(vector2(0,-5));
	
	
	
	//controle de colisão do tiro. Criamos um Array de entidades que captura todas as entidades dos buckets
	//se as entidades capturadas forem iguais a asteroid e nave, elas são deletadas pelo tiro
	ETHEntityArray shotArray;
	
	GetEntitiesFromBucket(GetBucket(shot.GetPositionXY()),shotArray);

	for(uint i=0; i<shotArray.size(); i++)
	{
		if(shotArray[i].GetEntityName() == "asteroid.ent" || shotArray[i].GetEntityName() == "nave.ent")
		{
			if(distance(shot.GetPositionXY(),shotArray[i].GetPositionXY()) < 40 )
			{
				//coloca a explosão na cena antes de deletar as entidades
				AddEntity("explosion.ent",shotArray[i].GetPosition(),0);
				DeleteEntity(shotArray[i]);
				
				if(shotArray[i].GetEntityName() == "asteroid.ent" )
					PlaySample("soundfx/asteroide_explosao.mp3");
				else
					PlaySample("soundfx/explosion_huge.mp3");
				
				DeleteEntity(shot);
			}
		}
	}
	
	//se o tiro ultrapassar o limite da tela, ele é deletado
	if(shot.GetPositionXY().y < 0)
			DeleteEntity(shot);
	
	
}

 