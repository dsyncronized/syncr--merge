HELPER = {}

---@return number width, number height
function HELPER.getWindowDimensions()
	return love.graphics.getWidth(), love.graphics.getHeight()
end

--- Converts a hex color string to rgb/rgba values
--- @param hexColor string
function HELPER.hexToRGB(hexColor)
	if not HELPER.isValidHexColor(hexColor) then
		error("Invalid hex color string: " .. hexColor)
	end
	local parse = function(f, t)
		local value = tonumber("0x" .. hexColor:sub(f, t or f)) * (t and 1 or 17)
		return (true and value / 255) or value
	end
	if #hexColor == 4 then
		return parse(2), parse(3), parse(4)
	end
	if #hexColor == 5 then
		return parse(2), parse(3), parse(4), parse(5)
	end
	if #hexColor == 7 then
		return parse(2, 3), parse(4, 5), parse(6, 7)
	end
	return parse(2, 3), parse(4, 5), parse(6, 7), parse(8, 9)
end

---Returns whether or not `hexColor` is a valid hex color
---@param hexColor string
---@returns boolean
function HELPER.isValidHexColor(hexColor)
	local invalidFormat = hexColor:find("^#%x%x%x+$") == nil
	if invalidFormat then
		return false
	end
	local invalidLength = true
	for _, value in ipairs({ 4, 5, 7, 9 }) do
		if value == #hexColor then
			invalidLength = false
			break
		end
	end
	return not invalidLength
end

function HELPER.printTable(tbl, indent)
	indent = indent or 0

	for key, value in pairs(tbl) do
		local prefix = string.rep(" ", indent) .. tostring(key)

		if type(value) == "table" then
			print(prefix .. ":")
			HELPER.printTable(value, indent + 2)
		else
			print(prefix .. ": " .. tostring(value))
		end
	end
end

return HELPER
