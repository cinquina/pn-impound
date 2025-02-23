function DebugPrint(str)
    if Config.Debug then
        local debugInfo = debug.getinfo(2, "Sl")
        local prefix = ("%s:%s"):format(debugInfo.short_src, debugInfo.currentline)
        print(("^5[%s]^7 %s"):format(prefix, str))
    end
end