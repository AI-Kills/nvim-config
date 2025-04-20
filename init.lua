-- Load diagnostic fix first to handle LSP errors properly
require("config.fix-diagnostics")
-- Then load the rest of the configuration
require("config.lazy")
