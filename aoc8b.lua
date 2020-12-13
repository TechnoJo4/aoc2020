local f = io.open("aoc8.txt")
local text = f:read("*a")
f:close() f = nil

local opers = {
    acc = {},
    jmp = {},
    nop = {}
}

local HALT = {}
local LOOP = {}

local function parse(asm)
    local ip = 0
    local rom1 = {}
    local rom2 = {}
    for oper,arg in asm:gmatch("(.-) ([+-]%d+)\n") do
        rom1[ip] = opers[oper] or oper
        rom2[ip] = tonumber(arg)
        ip = ip + 1
    end
    return rom1, rom2, ip
end


local function exec(ip, acc, rom1, rom2, halt_ip, visited)
    local op = rom1[ip]
    local arg = rom2[ip]

    if ip == halt_ip then
        return HALT, acc, ip
    elseif not op then
        print("????? ip out of bounds", ip, acc)
        return HALT, acc, ip
    elseif visited[ip] then
        return LOOP, acc, ip + arg
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

local rom1, rom2, halt_ip = parse(text)
for _ip,_oper in pairs(rom1) do
    if _oper == opers.acc then
        -- No acc instructions were harmed in the corruption of this boot code.
    else
        local r1 = copy(rom1)
        if _oper == opers.jmp then
            r1[_ip] = opers.nop
        else
            r1[_ip] = opers.jmp
        end

        local ip, acc = 0, 0
        local visited = {}
        while true do
            ip, acc, _ = exec(ip, acc, r1, rom2, halt_ip, visited)
            if ip == HALT then
                print(("swapped inst %d halted with acc %d"):format(_ip, acc))
                return
            elseif ip == LOOP then
                break
            end
        end
    end
end
