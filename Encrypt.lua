local key = 123

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

local success, encrypt = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Perczll/Luau/refs/heads/main/Encryption.lua"))()
end)

return {
    Encrypt = Encrypt,
    Decrypt = Decrypt
}
