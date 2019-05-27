-- norns basics
-- a playground for experiments
--
-- uses norns basics engine
-- a playground for SuperCollider
--
--
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
--  load the sound engine
engine.name = "nornsBasicEngine"




-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
--  global variables
local screen_refresh_metro
local _hz = 220
local _amp = 0.5




-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-- the init function is the first function to be called, i use it to configure the initial state
function init()
	-- pass a frequency to the engine to get it to play
	engine.hz(220)

	-- set screen antialiasing level
	screen.aa(1)

	-- set up the screen refresh metro to redraw the screen 15 times per second
	screen_refresh_metro = metro.init()
  	screen_refresh_metro.event = function()
		redraw()
  	end
	screen_refresh_metro:start(1/15)



end




-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
--  getting input from the encoders
function enc(n, d)
	if n == 2 then
		-- encoder two will adjust hertz
		_hz = util.clamp(_hz + d, 10, 440)
		engine.hz(_hz)
	end

	if n == 3 then
		-- encoder 3 will adjust amplitude
		_amp = util.clamp(_amp + (d / 20) , 0.5, 10)
		engine.amp(_amp)
	end
end




-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
--  the interface redraw function

function redraw()
	-- first clear the screen
	screen.clear()

	-- then set the level we'll draw at
	screen.level(1)

	-- then move to where we want to start drawing
	screen.move(32, 16)

	-- then we'll add some text
	screen.text("hz: ".._hz)

	-- then move again
	screen.move(32, 64)

	-- then add the other text
	screen.text("amp: ".._amp)

	-- then draw the screen
	screen.update()
end