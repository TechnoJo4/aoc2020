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
local num
while true do
    if i > 25 then
        num = nums[i]
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

local i, j = 1, 1
while i < #nums - 1 do
    j = i

    local sum = 0
    while sum < num do
        sum = sum + nums[j]
        j = j + 1
    end
    if sum == num and j-i >= 2 then
        break
    end

    i = i + 1
end

local min, max = nums[i], nums[i]
for k=i+1,j-1 do
    local n = nums[k]
    if n < min then
        min = n
    end
    if n > max then
        max = n
    end
end

print(min, max, min+max)
