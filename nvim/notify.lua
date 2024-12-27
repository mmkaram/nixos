math.randomseed(os.time())
local intros = {'Welcome, Paul.', 'Lead them to Paradise', 'I Must not Fear. Fear is the Mind Killer', 'Silence', 'There is no escape—we pay for the violence of our ancestors'}
local function pickRandomString(list)
    local index = math.random(#list)
    return list[index]
end

require("notify")(pickRandomString(intros))
vim.notify = require("notify")
require("telescope").load_extension("notify")
