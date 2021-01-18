require 'ruby2d'
load 'structures.rb'

set title: "Lightning", width: 1000, height: 1000, background: '#38285c'

clouds = []

for i in 0..((get :width) / 200 + 1)
    clouds << Sprite.new('clouds.png', clip_width: 350, time: 30, loop: true, x: (i - 1) * 200, y: -75)
    clouds[i].play
end

def make_tree(iterations, step_size)
    start = Point.new(rand(get :width), (get :width) / 20 + rand((get :width) / 20))
    points = [start]
    segments = []

    for k in 0...iterations
        rand_pnt = Point.new(rand(get :width), rand(get :height))
        
        min_dist = Math.sqrt((get :width)**2 + (get :height)**2)

        for n in 0...points.length
            new_dist = Math.sqrt(((points[n].x - rand_pnt.x)**2) + ((points[n].y - rand_pnt.y)**2))
            
            if new_dist < min_dist
                min_dist = new_dist
                min_index = n
            end
        end

        near_pnt = points[min_index]
        vec_pnt = rand_pnt.subtract(near_pnt)
        vec_pnt.y += (get :height) / 5 # introduce bias towards the ground
        mag = vec_pnt.dot(vec_pnt)

        new_pnt = near_pnt.add(vec_pnt.mult(step_size / mag))

        points << new_pnt

        segments << Segment.new(near_pnt, new_pnt)
    end

    return segments
end

segments = make_tree((get :height), 6)
idx = 0
speed = 20

colors = ['#e26cff', 'silver', 'aqua']
color = colors.sample

update do
    for i in 1..speed
        Line.new(
            x1: segments[idx].p1.x, y1: segments[idx].p1.y,
            x2: segments[idx].p2.x, y2: segments[idx].p2.y,
            width: 2,
            color: color, 
            z: -1
        )

        idx += 1

        break if segments.length <= idx
    end

    if segments.length <= idx
        segments = make_tree((get :height), 6)
        idx = 0
        clear
        
        clouds = []
        for i in 0..((get :width) / 200 + 1)
            clouds << Sprite.new('clouds.png', clip_width: 350, time: 30, loop: true, x: (i - 1) * 200, y: -75)
            clouds[i].play
        end

        color = colors.sample
    end
end


show