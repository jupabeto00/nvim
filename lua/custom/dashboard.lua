return {
  enable = true,
  preset = {
    header = [[

 ▄▄▄██▀▀▀ █    ██  ▄▄▄       ███▄    █ 
   ▒██    ██  ▓██▒▒████▄     ██ ▀█   █ 
   ░██   ▓██  ▒██░▒██  ▀█▄  ▓██  ▀█ ██▒
▓██▄██▓  ▓▓█  ░██░░██▄▄▄▄██ ▓██▒  ▐▌██▒
 ▓███▒   ▒▒█████▓  ▓█   ▓██▒▒██░   ▓██░
 ▒▓▒▒░   ░▒▓▒ ▒ ▒  ▒▒   ▓▒█░░ ▒░   ▒ ▒ 
 ▒ ░▒░   ░░▒░ ░ ░   ▒   ▒▒ ░░ ░░   ░ ▒░
 ░ ░ ░    ░░░ ░ ░   ░   ▒      ░   ░ ░ 
 ░   ░      ░           ░  ░         ░ 
 ]],
  },
  sections = {
    { section = "header" },
    {
      text = {
        [[


                                                                   /L'-,
                               ,'-.           /MM . .             /  L '-,
     .                    _,--dMMMM\         /MMM  `..           /       '-, 
     :             _,--,  )MMMMMMMMM),.      `QMM   ,<>         /_      '-,'
     ;     ___,--. \MM(    `-'   )M//MM\       `  ,',.;      .-'* ;     .'
     |     \MMMMMM) \MM\       ,dM//MMM/     ___ < ,; `.      )`--'    /
     |      \MM()M   MMM)__   /MM(/MP'  ___, \  \ `  `. `.   /__,    ,'
     |       MMMM/   MMMMMM( /MMMMP'__, \     | /      `. `-,_\     /
     |       MM     /MMM---' `--'_ \     |-'  |/         `./ .\----.___
     |      /MM'   `--' __,-  \""   |-'  |_,               `.__) . .F. )-.
     |     `--'       \   \    |-'  |_,     _,-/            J . . . J-'-. `-.,
     |         __  \`. |   |   |         \    / _           |. . . . \   `-.  F
     |   ___  /  \  | `|   '      __  \   |  /-'            F . . . . \     '`    
     |   \  \ \  /  |        __  /  \  |  |,-'        __,- J . . . . . \            
     |    | /  |/     __,-  \  ) \  /  |_,-     __,--'     |. .__.----,'           
     |    |/    ___     \    |'.  |/      __,--'           `.-;;;;;;;;;\         
     |     ___  \  \     |   |  `   __,--'                  /;;;;;;;;;;;;.     
     |     \  \  |-'\    '    __,--'                       /;;;;;;;;;;;;;;\   
 \   |      | /  |      __,--'                             `--;;/     \;-'\  
  \  |      |/    __,--'                                   /  /         \  \  
   \ |      __,--'                                        /  /           \  \        
    \|__,--'                                          _,-;M-K,           ,;-;\        
                                                     <;;;;;;;;           '-;;;;

     ]],
        hl = "Function",
      },
      padding = { 0, 0 },
      pane = 2,
    },
    { section = "keys", gap = 1, padding = 1 },
    {
      pane = 1,
      icon = " ",
      desc = "Browse Repo",
      enabled = function()
        return Snacks.git.get_root() ~= nil
      end,
      padding = 1,
      key = "b",
      action = function()
        Snacks.gitbrowse()
      end,
    },
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local gh_installed = vim.fn.executable("gh") == 1
      local cmds = {
        {
          icon = " ",
          title = "Git Status",
          cmd = "git --no-pager diff --stat -B -M -C",
          height = 10,
        },
      }
      return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
          pane = 1,
          section = "terminal",
          enabled = in_git and gh_installed,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        }, cmd)
      end, cmds)
    end,
    {
      key = "t",
      enabled = function()
        return vim.system({ "git", "rev-parse", "--is-bare-repository" }):wait().stdout == "true\n"
      end,
      desc = "Worktree",
      icon = " ",
      action = "<leader>gt",
    },
    { section = "startup" },
  },
}
