local T_STR  = 'string'
local T_BOOL = 'boolean'
local T_NUM  = 'number'
local T_TBL  = 'table'

local flags   = {
	config = {},
	values = {}
}

function flags:string(key, default)
	assert(type(key) == T_STR)
	assert(default == nil or type(default) == T_STR)
	self.config[key] = { key = key, type = T_STR, default = default }
end

function flags:boolean(key)
	assert(type(key) == T_STR)
	self.config[key] = { key = key, type = T_BOOL, default = false }
end

function flags:number(key, default)
	assert(type(key) == T_STR)
	assert(default == nil or type(default) == T_NUM)
	self.config[key] = { key = key, type = T_NUM, default = default }
end

function flags:table(key, default)
	assert(type(key) == T_STR)
	assert(default == nil or type(default) == T_TBL)
	self.config[key] = { key = key, type = T_TBL, default = default }
end

function flags:parse(args)
	assert(type(args) == T_TBL)
	local c, v
	for i = 1, #args do
		if string.sub(args[i], 1, 1) == '-' then
			c = self.config[string.sub(args[i], -1)]
			if c ~= nil then
				i = i + 1
				v = args[i]
				if c.type == T_STR then
					self.values[c.key] = v
				elseif c.type == T_NUM then
					self.values[c.key] = tonumber(v, 10)
				elseif c.type == T_TBL then
					local tbl = self.values[c.key]
					if tbl == nil then
						tbl = { v }
					else
						tbl[#tbl + 1] = v
					end
					self.values[c.key] = tbl
				elseif c.type == T_BOOL then
					self.values[c.key] = true
				end
			end
		end
		i = i + 1
	end
	for _, v in pairs(self.config) do
		if self.values[v.key] == nil then
			self.values[v.key] = v.default
		end
	end
end

return flags