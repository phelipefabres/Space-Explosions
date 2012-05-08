//Asantee Games
//Game: Space Explosions


const string DEFAULT_ONSCENELOADED = "onSceneLoaded";
const string DEFAULT_ONSCENEUPDATED = "onSceneUpdated";


class StateMachine
{

	private State@ m_currentState;
	
	
	void setState(State@ state)
	{
		@m_currentState = @state;
		m_currentState.start();
	}

	void runCurrentPreLoopFunction()
	{
		m_currentState.onSceneLoaded();
	}

	void runCurrentLoopFunction()
	{
		m_currentState.onSceneUpdated();
	}

}

StateMachine g_stateManager;

