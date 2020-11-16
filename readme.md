__The original class was made by the [BLT](https://github.com/JamesWilko/Payday-2-BLT-Lua) developers__


Hook to: `lib/managers/menumanager`


# Changes
	- Added looping argument to the Add() function, this can be a bool or a number to define how many times the delayed call wlll be called (true for infinite)
	- Functions are now safely called with `pcall`, this reducing the chances of crashing when executing the delayed function.
	- Removed dual hooking, Now it is hooked only to the `MenuManager.Update` function
