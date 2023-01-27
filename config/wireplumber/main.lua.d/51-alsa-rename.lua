-- Rename a device


--[[
rule = {
	matches = {
		{
			{ "node.name", "equals", "<sink name>" },
		},
	},
	apply_properties = {
		["node.description"] = "<new name>",
	},
}

table.insert(alsa_monitor.rules,rule)
]]--
