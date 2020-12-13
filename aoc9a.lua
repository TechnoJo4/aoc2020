local f = io.open("aoc9.txt")
local text = f:read("*a")
f:close() f = nil

local nums = {}
do
    local i = 1
    for num in text:gmatch("(%d+)\n") do
        nums[i] = tonumber(num)
        i = i + 1
    end
end

local last = {}
local i, j = 1, 1
while true do
    if i > 25 then
        local num = nums[i]
        local good = false
        for _, v1 in pairs(last) do
            for _, v2 in pairs(last) do
                if v1 ~= v2 and num == v1 + v2 then
                    good = true
                    break
                end
            end
            if good then break end
        end
        if not good then
            print(i, num)
            break
        end
    end

    last[j] = nums[i]
    i = i + 1
    j = ((i - 1) % 25) + 1
end
