local f = io.open("aoc8.txt")
local text = f:read("*a")
f:close() f = nil

local opers = {
    acc = {},
    jmp = {},
    nop = {}
}

local function parse(asm)
    local ip = 0
    local rom1 = {}
    local rom2 = {}
    for oper,arg in asm:gmatch("(.-) ([+-]%d+)\n") do
        rom1[ip] = opers[oper] or oper
        rom2[ip] = tonumber(arg)
        ip = ip + 1
    end
    return rom1, rom2
end

local visited = {}

local rom1, rom2 = parse(text)

local function exec(ip, acc)
    local op = rom1[ip]
    local arg = rom2[ip]

    if visited[ip] then
        return -(ip + arg), acc
    end
    visited[ip] = true

    if op == opers.nop then
        return ip + 1, acc
    elseif op == opers.jmp then
        return ip + arg, acc
    elseif op == opers.acc then
        return ip + 1, acc + arg
    else
        print(("????? invalid oper %s @ %d"):format(op, ip))
    end
end

local function copy(tbl)
    local new = {}
    for k,v in pairs(tbl) do
        new[k] = v
    end
    return new
end

local ip, acc = 0,0
while true do
    ip, acc = exec(ip, acc)
    if ip < 0 then
        print(-ip, acc)
        break
    end
end
