require 'dude'

MOAISim.openWindow("foo", 1280, 720)
viewport = MOAIViewport.new()
viewport:setSize(1280, 720)
viewport:setScale(1280, -720)

layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAISim.pushRenderPass(layer)

world = MOAIBox2DWorld.new()
world:setGravity(0, 20)
world:setUnitsToMeters(.1)
world:start()
layer:setBox2DWorld(world)

worldBody = world:addBody(MOAIBox2DBody.STATIC)
fixture = worldBody:addRect(-500, 15, 500, 20)
fixture:setFilter(0x02)

stickman = Dude(world, -100, -200)


function keyboardEvent(key, down)
	if key == 119 then -- w
		stickman:jump()

	elseif key == 114 then -- r

	elseif key == 97 then -- a
		if down then
			stickman:move('left')
		else
			stickman:unMove('left')
		end
	elseif key == 115 then -- s
		if down then
			stickman:move('right')
		else
			stickman:unMove('right')
		end
	end
end


function main()
	MOAIInputMgr.device.keyboard:setCallback(keyboardEvent)

	mainThread = MOAIThread.new()

	mainThread:run(
	function()
	while(true) do
		coroutine.yield()
		stickman:update()
	end
end
)
end

main()
