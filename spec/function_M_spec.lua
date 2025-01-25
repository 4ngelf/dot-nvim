-- Emulating this structure:
-- lua/
--   foo/
--     bar/
--       baz.lua
--       init.lua
--     another.lua
--     init.lua
--   outside.lua
insulate("Imaginary structure:", function()
  -- Load function M with custom require() that only returns calculated
  -- relative path
  M = require("function_M").get_M(function(m) return m end)

  -- Tests
  describe("module foo:", function()
    local M = M "foo"

    it("get self", function()
      local expect = "foo"
      assert.is.equal(expect, M.require(""))
      assert.is.equal(expect, M.require("."))
      assert.is.equal(expect, M.require("..foo"))
    end)
    it("get child", function()
      local expect = "foo.bar"
      assert.is.equal(expect, M.require("bar"))
      assert.is.equal(expect, M.require(".bar"))

      expect = "foo.another"
      assert.is.equal(expect, M.require("another"))
      assert.is.equal(expect, M.require(".another"))
    end)
    it("get grandchild", function()
      local expect = "foo.bar.baz"
      assert.is.equal(expect, M.require("bar.baz"))
      assert.is.equal(expect, M.require(".bar.baz"))
    end)
  end)

  describe("module foo.bar:", function()
    local M = M "foo.bar"

    it("get self", function()
      local expect = "foo.bar"
      assert.is.equal(expect, M.require(""))
      assert.is.equal(expect, M.require("."))
      assert.is.equal(expect, M.require("..bar"))
    end)
    it("get child", function()
      local expect = "foo.bar.baz"
      assert.is.equal(expect, M.require("baz"))
      assert.is.equal(expect, M.require(".baz"))
    end)
    it("get parent", function()
      local expect = "foo"
      assert.is.equal(expect, M.require(".."))
    end)
    it("get sibling", function()
      local expect = "foo.another"
      assert.is.equal(expect, M.require("..another"))
    end)
    it("get empty", function()
      local expect = ""
      assert.is.equal(expect, M.require("..."))
    end)
    it("get grandfather sibling", function()
      local expect = "outside"
      assert.is.equal(expect, M.require("...outside"))
    end)
  end)
end)
