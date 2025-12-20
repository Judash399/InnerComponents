# Style Guide

All of these rules derive from the [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide/) so give that a read if you have too.

## File Headers
Files should **always** have a multi line comment at the top of the file describing what the file does in a general sense.
For the case of components It will be the components description.
If a file has its own copyright notice (Ex: its code from another open source project) then that should be included in the header with a link to the original source.

## Example
This is an example for an "foo" library by "AFooBarMan", which is under the MIT license.
```luau
--[[
    https://github.com/AFooBarMan/foo

    An implementation of the foo() function.

    ----

    [MIT License Goes here]
]]
```

## Globals
When Creating globals (Ex: Constants, Other Modules, Refrences) make sure they are done in the following order. Each section is separated through a comment stating the category. It goes in this order:
1. Services
2. Modules
3. Refrences
4. Types

The module section can refrence a folder or group of modules as long as its separated by the module list with 1 blank line.

If you do not use a category, you do not need to include it.

## Example
This is an example for a "bar" module.
```luau
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Modules
local Modules = ReplicatedStorage.Modules

local Foo = require(Modules.foo)
local Fusion = require(Modules.Fusion)

--References
local Children = Fusion.Children

--Types
type UsedAs<T> = Fusion.UsedAs<T> 
```