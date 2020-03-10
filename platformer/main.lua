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
    require "lspr-api"
    t = createsprite(love.graphics.getWidth() * 2.5 ,0-10,"rectangle")
    t.height = 35
    t.width = 35
    t.color.b = 0
    t2 = createsprite((love.graphics.getWidth() * 7.5) + 25 ,0-10,"rectangle")
    t2.height = 35
    t2.width = 35
    t2.color.b = 0

    t.vel = {x=0,y=0}
    t2.vel = {x=0,y=0}

    plat = creategroup()
    ylat = creategroup()
    math.randomseed(4)

    for i=1,200 do
      add(plat,createsprite(pxllockvalue(math.random(0,love.graphics.getWidth() * 9.7)),600-math.random(0,100000),"rectangle"))
      add(ylat,createsprite(0,0,"rectangle"))
    end
    middleline = createsprite(love.graphics.getWidth()/2,0,"rectangle")
    middleline.height = love.graphics.getHeight()
    middleline.color = rgb(0,1,1)
    normalcam = createcamera()
    nocam = createcamera()
    nocam.x = 10000000
    c = createcamera()
    c.zoom = 0.0290
    hidefromcamera(c,middleline)
    hidefromcamera(c,plat)
    c1 = createcamera()
    hidefromcamera(c1,middleline)
    hidefromcamera(c1,ylat)
    c2 = createcamera()
    hidefromcamera(c2,middleline)
    hidefromcamera(c2,ylat)
    c3 = createcamera()
    c3.zoom = 1
    setcamera(nocam)
    v1 = createview(love.graphics.getWidth()/2,love.graphics.getHeight(),c1)
    v2 = createview(love.graphics.getWidth()/2,love.graphics.getHeight(),c2)
    v2.x = love.graphics.getWidth()/2
    v4 = createview(1000000,10000000,c)
    v3 = createview(love.graphics.getWidth()*2,love.graphics.getHeight(),c3,middleline)
    v3.load = "type"

    v5 = createview(1000000,10000000,normalcam,middleline)
    v5.load = "type"
end

function update(dt)
  c1.x = t.x - love.graphics.getWidth()/4
  c2.x = t2.x - (love.graphics.getWidth()/4) * 3
  c1.y = t.y - love.graphics.getHeight()/2
  c2.y = t2.y - love.graphics.getHeight()/2
  -- always be on bottom
  if love.keyboard.isDown("w") then
    t.vel.y  = - 5
  end
  if love.keyboard.isDown("d") then
    t.x = t.x + 5
  end
  if love.keyboard.isDown("a") then
    t.x = t.x - 5
  end

  if love.keyboard.isDown("up") then
    t2.vel.y  = - 1
  end
  if love.keyboard.isDown("right") then
    t2.x = t2.x +  5
  end
  if love.keyboard.isDown("left") then
    t2.x = t2.x - 5
  end






  t.x  = t.x + t.vel.x
  t.y  = t.y + t.vel.y

  t2.x  = t2.x + t2.vel.x
  t2.y  = t2.y + t2.vel.y



  if t.overlap then t.vel.y = 0 end
  if t2.overlap then t2.vel.y = 0 end
  if not t.overlap then t.vel.y = t.vel.y + 0.1 end
  if not t2.overlap then t2.vel.y = t2.vel.y + 0.1 end

  platforms()

  updatesprites(dt)
  updateanimations(dt)


end

function draw()
  loadviews()
end

function platforms()
  for i=1,plat.length do
    plati = get(plat,i)
    ylati = get(ylat,i)
    plati.velocity.y = 0
    plati.width = 200
    plati.height = 40
    ylati.x = plati.x
    ylati.y = plati.y
    ylati.velocity.y = plati.velocity.y
    ylati.width = plati.width
    ylati.height = plati.height
    ylati.color.r = 1
    ylati.color.b = 0
    ylati.color.g = 0
    if plati.y < love.graphics.getHeight() then
      plati.y = plati.y + math.random(0, love.graphics.getHeight()*10)
    end
    col1 = slide(t,plati)
    col2 = slide(t2,plati)

    if col1.donetouch then
      t.vel.y = 0
    end
    if col2.donetouch then
      t2.vel.y = 0
    end
    if col1.donetouch then
      print("touching")
    end
  end
end

return {load = load,update = update,draw = draw,}
