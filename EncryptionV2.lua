local bit32 = bit32

local keys = {123, 45, 67}
local shift_val = 5

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local function base64encode(data)
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data % 3 + 1])
end

local function base64decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='', (b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local function shuffle(str)
    return str:reverse()
end

local function unshuffle(str)
    return str:reverse()
end

local function multiXOR(str, keys)
    local result = {}
    for i = 1, #str do
        local b = string.byte(str, i)
        for _, k in ipairs(keys) do
            b = bit32.bxor(b, k)
        end
        result[i] = string.char(b)
    end
    return table.concat(result)
end

local function caesarShift(str, shift)
    local result = {}
    for i = 1, #str do
        local c = string.byte(str, i)
        result[i] = string.char((c + shift) % 256)
    end
    return table.concat(result)
end

local function caesarUnshift(str, shift)
    local result = {}
    for i = 1, #str do
        local c = string.byte(str, i)
        result[i] = string.char((c - shift) % 256)
    end
    return table.concat(result)
end

local function Encrypt(str)
    local step1 = multiXOR(str, keys)
    local step2 = caesarShift(step1, shift_val)
    local step3 = shuffle(step2)
    local step4 = base64encode(step3)
    return step4
end

local function Decrypt(str)
    local step1 = base64decode(str)
    local step2 = unshuffle(step1)
    local step3 = caesarUnshift(step2, shift_val)
    local step4 = multiXOR(step3, keys)
    return step4
end

return {
    Encrypt = Encrypt,
    Decrypt = Decrypt
}
