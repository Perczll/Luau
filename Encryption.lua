local key = 123

getgenv().Path = game.Players.LocalPlayer.Info[Decrypt('8[6')]

local function Encrypt(str)
    local result = {}
    for i = 1, #str do
        local b = string.byte(str, i)
        result[i] = string.char(bit32.bxor(b, key))
    end
    return table.concat(result)
end

local function Decrypt(str)
    local result = {}
    for i = 1, #str do
        local b = string.byte(str, i)
        result[i] = string.char(bit32.bxor(b, key))
    end
    return table.concat(result)
end

local function Seption()
	getgenv().Path.Value = math.huge
end

return {
    Encrypt = Encrypt,
    Decrypt = Decrypt
}
