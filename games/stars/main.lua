--[[

    This is stars.lua it was orginally made before scapes were addded.
    but it was made to show off the distances property something that simulates
    the z - axis.

    expect it isnt based on actual  distance its based on a decimal. a factor on
    how much the camera should move. for example if the distance is zero then then
    sprite will never move away from the camera or if the distance is 0.5 then
    the camera will move have as much , 3 3x times as much etc.

    stars.lua also uses creategroup90

]]
function load()
  -- depdancy correct distan ce
  lspr.shapes[7] =   function(sprite,camera)
      love.graphics.push()
      love.graphics.setColor(sprite.color.r,sprite.color.g,sprite.color.b,sprite.color.alpha)
      love.graphics.scale(lsworld.lock * camera.zoom, lsworld.lock * camera.zoom)



      love.graphics.translate(((-1) * (camera.x - sprite.orgin.x) + camera.orgin.x + ((sprite.x - camera.x)*sprite.distance)) ,((-1) * (camera.y - sprite.orgin.y) + camera.orgin.y + ((sprite.y - camera.y)*sprite.distance)) )

      love.graphics.circle(sprite.mode, math.floor(sprite.x / lsworld.lock), math.floor(sprite.y / lsworld.lock), sprite.radius )
      love.graphics.pop()
    end,
  initall()
  camera = getcamera()
  stars = creategroup()
  camera.orgin.x = love.graphics.getWidth() * 0.5
  camera.orgin.y = love.graphics.getHeight() * 0.5
  for i=1,10000 do
    stars:add(createsprite(math.random(-4,4),math.random(-4,4)))
    star = stars:get(i)
    star.distance = math.random(1,50)/10
    star.radius = star.distance/1.7
  end
  cm = createsprite(0,0)
  cm.radius = 0
end

function update(dt)
  camera.x , camera.y = cm.x ,cm.y
  if love.keyboard.isDown("d") then
    cm.velocity.x = cm.velocity.x + 2
  end
  if love.keyboard.isDown("a") then
    cm.velocity.x = cm.velocity.x - 2
  end
  if love.keyboard.isDown("w") then
    cm.velocity.y = cm.velocity.y - 2
  end
  if love.keyboard.isDown("s") then
    cm.velocity.y = cm.velocity.y + 2
  end
  if cm.velocity.x > 0 then cm.velocity.x = cm.velocity.x - 1 end
  if cm.velocity.x < 0 then cm.velocity.x = cm.velocity.x + 1 end
  if cm.velocity.y > 0 then cm.velocity.y = cm.velocity.y - 1 end
  if cm.velocity.y < 0 then cm.velocity.y = cm.velocity.y + 1 end
end

function draw()
end
return {load = load,update = update,draw = draw,}
