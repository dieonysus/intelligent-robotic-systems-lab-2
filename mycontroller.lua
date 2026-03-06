function init()
   MAX_SPEED = 10
end

function step()
   local proximity = robot.proximity
   local avoid_left = 0
   local avoid_right = 0

   -- Read proximity sensors
   for i = 1, #proximity do
      local value = proximity[i].value
      local angle = proximity[i].angle

      -- If obstacle is on the left, turn right
      if angle > 0 then
         avoid_right = avoid_right + value
      else
         avoid_left = avoid_left + value
      end
   end

   -- Simple obstacle avoidance
   if (avoid_left + avoid_right) > 0.1 then
      robot.wheels.set_velocity(MAX_SPEED - avoid_left * 20,
                                MAX_SPEED - avoid_right * 20)
   else
      -- No obstacle: go straight
      robot.wheels.set_velocity(MAX_SPEED, MAX_SPEED)
   end
end

function reset()
end

function destroy()
end