function onCreate()
			makeAnimatedLuaSprite('walk', 'PlaneCrazyWalkcycleOnly', getProperty('dad.x')+30, getProperty('dad.y')+280)
			addAnimationByPrefix('walk', 'wask', 'MickeyWalkcycle', 24, true)
			objectPlayAnimation('walk', 'wask', true)
			addLuaSprite('walk', false)
	end
