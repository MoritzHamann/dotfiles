#!/usr/bin/env lua

HOME = os.getenv("HOME")
PWD = os.getenv("PWD")


function ln(source, target)
	os.execute("ln -fs " .. source .. " " .. target)
end

function log(message)
	print("> " .. tostring(message))
end

function prepareDirectories()
	os.execute("mkdir -p " .. HOME .. "/.local/bin")
end



function setupNvim(arch)
	-- install neovim from released on github
	-- will need access to github.com
	nvimInstallDir = HOME .. "/nvim_install"
	targetLink = ""
	
	-- get the download link based on the architecure
	if arch == "mac" then
		targetLink = "https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
	elseif arch == "linux" then
		targetLink = "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
	end

	-- download and extract
	if not os.execute("mkdir -p " .. nvimInstallDir) then
		log("Failed to create nvim_install directory")
		return
	end

	if not os.execute("curl -L -o " .. nvimInstallDir .. "/nvim.tar.gz "  .. targetLink) then
		log("Failed to download nvim")
		return
	end

	if not os.execute("tar -xzf " .. nvimInstallDir .. "/nvim.tar.gz -C " .. nvimInstallDir) then
		log("Failed to extract nvim")
		return
	end

	-- symlink into ~/.local/bin
	if arch == "mac" then
		ln(HOME .. "/nvim_install/nvim-macos/bin/nvim", HOME .. "/.local/bin/nvim")
	elseif arch == "linux" then
		ln(HOME .. "/nvim_install/nvim-linux64/bin/nvim", HOME .. "/.local/bin/nvim")
	end

	-- symlink the config
	ln(PWD .. "/nvim", HOME .. "/.config/nvim")
end



-- list of all binaries in bin
-- hardcoded for now, since we want to be able to remove old symlinks in case of running
-- install multiple times

binaries = {
	"gits",
}


function install(opts)
	if opts["arch"] == nil or opts["arch"] == "" then
		log("No architecture specified")
		os.exit(2)
	end
	if opts["arch"] ~= "mac" and opts["arch"] ~= "linux" then
		log("Invalid architecture specified")
		os.exit(3)
	end

	prepareDirectories()
	setupNvim(opts["arch"])
	linkBinaries(binaries)
end

function parseArgs()
	parsed = {}
	if #arg < 2 then
		print("Usage: install.lua -a [mac/linux]")
		os.exit(1)
	end

	if #arg == 2 and arg[1] == "-a"then
		parsed["arch"] = arg[2]
	end

	return parsed
end

install(parseArgs())
