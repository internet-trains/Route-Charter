/*
 * This file is part of Open TTD Route Chartering, which is a GameScript for OpenTTD
 * Copyright (C) 2012-2013  Leif Linse
 *
 * Open TTD Route Chartering is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * Open TTD Route Chartering is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Open TTD Route Chartering; If not, see <http://www.gnu.org/licenses/> or
 * write to the Free Software Foundation, Inc., 51 Franklin Street, 
 * Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */

require("version.nut");

class FMainClass extends GSInfo {
	function GetAuthor()		{ return "rexrex600"; }
	function GetName()			{ return "Open TTD Route Chartering"; }
	function GetDescription() 	{ return "<Insert Description>"; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return "2019-07-03"; }
	function CreateInstance()	{ return "MainClass"; }
	function GetShortName()		{ return "RTCH"; } // Replace this with your own unique 4 letter string
	function GetAPIVersion()	{ return "1.9"; }
	function GetURL()			{ return ""; }

	function GetSettings() {
		AddSetting({name = "adjacency_radius", description = "How far away should the script look when allocating city pairs for charters? (uses manhattan aka taxi cab distance)", easy_value = 250, medium_value = 250, hard_value = 250, custom_value = 250, flags = CONFIG_INGAME, min_value = 50, max_value = 1000});
	}
}

RegisterGS(FMainClass());
