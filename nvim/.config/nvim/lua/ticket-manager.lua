local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")



-- jira json file format
--	{
--		tasks: {
--			"id" : {
--				"title": "xxx",
--				"owner": "xxx",
--				"reporter: "xxx",
--				"description": "xxx",
--				"status": "xxx",
--				"comments": [
--					{"date": "xxx", author: "xxx", text: ""}
--				]
--			},
--			id2: {...}
--	   },
--	   branchMapping: {
--	   		branchName: [jira task ids],
--	   	}
-- }
Cache = nil

function Load_cache()
	local path = "somepath"
	-- Cache = vim.json.decode(path)
end

function Get_tickets_for_branch(branch)
	local tickets = nil
	if Cache == nil then
		Load_cache()
	end
	tickets = Cache[branch]
	return tickets

end

function Get_main_ticket_for_branch(branch)
	local tickets = Get_tickets_for_branch(branch)
	-- TODO: check for no tickets and how to get the main one?
	return tickets
end


function LinkTicketToBranch(branch, ticket)
	-- TODO
end


function AddCommentToTicket(ticket, comment)
	-- TODO
end


function OpenTicketOnline(ticket)

end


-------------------
-- Ticket picker --
-------------------

Runner = {}


function Runner:invoke()
	print(self)
end

function invoke_co(co, params)
	local status, payload = coroutine.resume(co, params)

	-- check for any errors during last run
	if status == false then
		print("error in coroutine", payload)
		return
	end

	if coroutine.status(co) == "dead" then
		print("finished running")
		return
	end

	-- check if we need to invoke a picker
	if payload.picker ~= nil then
		print("invoking picker")
		payload.picker(co)
	else
		print("nothing to do")
	end
end


Testpicker = {}

function Testpicker.new(self, choices)
	local ob = {choices = choices}
	setmetatable(ob, Testpicker)
	Testpicker.__index = Testpicker
	return ob
end

function Testpicker.pick(self)
	local picker_wrap = function(co)
		local opts =  require("telescope.themes").get_dropdown({})
		local picker = pickers.new(opts, {
			prompt_title = "Select Ticket",
			finder = finders.new_table({results = self.choices}),
			sorter = config.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = actions_state.get_selected_entry()
					if selection ~= nil then
						invoke_co(co, selection)
					else
						print("no selection")
					end
				end)
				return true
			end
		}):find()
	end
	local selection = coroutine.yield({picker = picker_wrap})
	return selection
end




function main(fn)
	local co = coroutine.create(fn)
	invoke_co(co, nil)
end


-- main(function()
-- 	local choices = {"ENGEQBIS-23455", "DRQS 4855", "DRQS 493485"}
-- 	local picker = Testpicker:new(choices)
-- 	local selection = picker:pick()
-- 	print("one", vim.inspect(selection))
-- 
-- 	local picker_two = Testpicker:new({"A", "B", "C"})
-- 	print(vim.inspect(picker_two))
-- 	local selection_two = picker_two:pick()
-- 	print("two", vim.inspect(selection_two))
-- end)

return {getTickets = Get_tickets_for_branch}
