//Projeto 1
//Jogo: Space Explosions
//Designer: Phelipe Fabres
//Modelo de cada objeto
//função que me dá a posição relativa do meu logo na tela 
bool isPointInRect(const vector2 &in p, const vector2 &in pos, const vector2 &in size, const vector2 &in origin)
{	
	vector2 posRelative = vector2(pos.x - size.x * origin.x, pos.y - size.y * origin.y);
	
	
	if (p.x < posRelative.x || p.x > posRelative.x + size.x || p.y < posRelative.y || p.y > posRelative.y + size.y)
		return false;
	else
		return true;
}