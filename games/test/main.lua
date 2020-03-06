-- love.load = load() , love.update = update() etc...
--[[

    All images, sounds or other love2d objects, should be made in scopes
    are global. duplicate sprites will be overwritten so unique names are needed
    for other scapes

    unless, you localize the variables by following this format.

    but if you wish not to use a localized format you can use the format in
    game2.lua

]]
local game = {}
function game.load()



  group  = creategroup()

  for i=1,1000 do
    group:add(createsprite(math.random(0,500),math.random(0,500)))

    sprite = group:get(i)

    sprite.color = rgb(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
  end
end
function game.update()

    group:read(function(sprite)
        sprite.x = sprite.x +  math.random(-1,1)
        sprite.radius = sprite.radius +  math.random(-1,1)
        sprite.y = sprite.y +  math.random(-1,1)
        sprite.color = rgb(math.random(0,255)/255,math.random(0,255)/255,math.random(0,255)/255)
    end)
end
function game.draw()

end


-- Make sure this is accurate
-- if not it will not work correctly you must return load,draw,update
-- functions even if there empty.
return {load = game.load,update = game.update,draw = game.draw,}
