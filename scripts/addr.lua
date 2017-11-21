-- example script that demonstrates use of setup() to pass
-- a random server address to each thread

local addrs = nil

function setup(thread)
   if not addrs then
      addrs = yrk.lookup(yrk.host, yrk.port or "http")
      for i = #addrs, 1, -1 do
         if not yrk.connect(addrs[i]) then
            table.remove(addrs, i)
         end
      end
   end

   thread.addr = addrs[math.random(#addrs)]
end

function init(args)
   local msg = "thread addr: %s"
   print(msg:format(yrk.thread.addr))
end
