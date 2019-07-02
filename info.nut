/*
 * This file is part of Open TTD Route Charter, which is a GameScript for OpenTTD
 * Copyright (C) 2012-2013  Leif Linse
 *
 * Open TTD Route Charter is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * Open TTD Route Charter is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Open TTD Route Charter; If not, see <http://www.gnu.org/licenses/> or
 * write to the Free Software Foundation, Inc., 51 Franklin Street, 
 * Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */

require("version.nut");

class FMainClass extends GSInfo {
	function GetAuthor()		{ return "[Insert your name here]"; }
	function GetName()			{ return "Open TTD Route Charter"; }
	function GetDescription() 	{ return "Minimal GS is a Game Script boilerplate"; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return "2013-11-05"; }
	function CreateInstance()	{ return "MainClass"; }
	function GetShortName()		{ return "MINI"; } // Replace this with your own unique 4 letter string
	function GetAPIVersion()	{ return "1.2"; }
	function GetURL()			{ return ""; }

	function GetSettings() {
		AddSetting({name = "log_level", description = "Debug: Log level (higher = print more)", easy_value = 3, medium_value = 3, hard_value = 3, custom_value = 3, flags = CONFIG_INGAME, min_value = 1, max_value = 3});
		AddLabels("log_level", {_1 = "1: Info", _2 = "2: Verbose", _3 = "3: Debug" } );
	}
}

RegisterGS(FMainClass());
