
local function generateSimplePassword(length)
    local charset = "abcdefghijklmnopqrstuvwxyz1234567890!@#$%^&*();'[{}]"
    local password = ""
    for i = 1, length do
        local index = math.random(1, string.len(charset))
        password = password .. string.sub(charset, index, index)
    end
    return password
  end
  
  print("")
  print("Enter your desired password length (8-60 characters):")
  local length = tonumber(io.read())
  while length < 8 or length > 60 do
    print("Invalid length. Please enter a length between 8 and 60:")
    length = tonumber(io.read())
  end
  
  local function generatePasswordStuff()
    
    local password = generateSimplePassword(length)
  
    print("Password for:")
    local passwordFor = io.read()
    print("")
    print("Your generated password is: " .. password)
  
    local file = io.open("CORP_SimplePassword.txt", "a")
    file:write("Generated password: " .. password .. "\n")
    file:write("Password for: " .. passwordFor .. "\n")
  
    file:close()
  end
  
  generatePasswordStuff()
