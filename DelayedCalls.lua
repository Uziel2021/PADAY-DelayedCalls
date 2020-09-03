rawset(_G, "DellayedCalls", {
	_calls = {}
})

function DellayedCalls:Update(t, dt)
	for k, v in pairs(self._calls) do
		if self._calls[k] ~=  nil then
			v.currentTime = v.currentTime + dt
			if v.currentTime >= v.timeToWait then
				if v.loop then
					if tonumber(v.loop) then
						if v.loop >= 1 then
							self._calls[k].loop = self._calls[k].loop - 1
						else
							return self:Remove(k)
						end
					end
					v.currentTime = 0
				else
					self:Remove(k)
				end

				if v.functionCall then
					pcall(v.functionCall)
				end
			end
		end
	end
end

function DellayedCalls:Add(id, time, func, loop)
	local queuedFunc = {
		functionCall = func,
		timeToWait = time,
		currentTime = 0,
		loop = (loop or false)
	}
	self._calls[id] = queuedFunc
end

function DellayedCalls:Remove(id)
	if self._calls[id] then
		self._calls[id] = nil
	end
end

if RequiredScript == "lib/managers/menumanager" then
	local __orig = MenuManager.update
	function MenuManager:update(t, dt)
		__orig(self, t, dt)
		DellayedCalls:Update(t, dt)
	end
end