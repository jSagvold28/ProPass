local function generatePassword(length)
    local charset = "1234567890"
    local password = ""
    for i = 1, length do
        local index = math.random(1, string.len(charset))
        password = password .. string.sub(charset, index, index)
    end
    return password
end

local function gradePassword(password)
    local score = 0
    

    if #password >= 8 then
      score = score + 1
    end
    if #password >= 12 then
      score = score + 1
    end
    if #password >= 16 then
      score = score + 1
    end
    

    local hasLower = string.match(password, "[a-z]")
    local hasUpper = string.match(password, "[A-Z]")
    local hasDigit = string.match(password, "[0-9]")
    local hasSymbol = string.match(password, "[!@#$%^&*();]")
    
    if hasLower then
      score = score + 1
    end
    if hasUpper then
      score = score + 1
    end
    if hasDigit then
      score = score + 1
    end
    if hasSymbol then
      score = score + 1
    end
    

    if score == 5 then
      score = score + 1
    end
    

    if score == 0 then
      return "F"
    elseif score == 1 then
      return "D"
    elseif score == 2 then
      return "C"
    elseif score == 3 then
      return "B"
    elseif score >= 4 then
      return "A"
    end
  end

print("")
print("Enter your desired password length (8-60 characters):")
local length = tonumber(io.read())
while length < 8 or length > 60 do
    print("Invalid length. Please input a length between 8 and 60:")
    length = tonumber(io.read())
end

local password = generatePassword(length)
print("")

print("Password for:")
local passwordFor = io.read()

print("Login email for this website:")
local providedLogin = io.read()

print("Is this password shared:")
local isPasswordShared = io.read()

print("Your generated password is: " .. password)

local function writeDataToFile()
    local file = io.open("NumberPassword.txt", "w")

    file:write("Password: " .. password .. "\n")
    file:write("Password for: " .. passwordFor .. "\n")
    file:write("Is password shared: " .. isPasswordShared .. "\n")
    file:write("Audit date: " .. os.date("$M_%d_%yyyy_%H_%m"))

    file:close()
end
writeDataToFile()

local score = gradePassword(password)
print("Password grade is: " .. score)

function copyToClipboard(str)
  -- Determine the platform
  local isWindows = package.config:sub(1,1) == '\\'

  -- Create a temporary file
  local tmpfile = os.tmpname()

  -- Write the string to the file
  local file = io.open(tmpfile, "w")
  file:write(str)
  file:close()

  -- Execute the copy command
  if isWindows then
      os.execute("cmd.exe /c echo.|set /p=\"" .. tmpfile .. "\" | clip")
  else
      os.execute("cat " .. tmpfile .. " | pbcopy")
  end

  -- Delete the temporary file
  os.remove(tmpfile)
end
copyToClipboard(password)
print("Password copied to clipboard!")
