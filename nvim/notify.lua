math.randomseed(os.time())
local intros = {'Welcome, Paul.', 'Lead them to Paradise', 'I Must not Fear. Fear is the Mind Killer'}
local function pickRandomString(list)
    local index = math.random(#list)
    return list[index]
end

require("notify")(pickRandomString(intros))
vim.notify = require("notify")
require("telescope").load_extension("notify")
