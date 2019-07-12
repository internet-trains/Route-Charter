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

class Company
{
    id = null;
    name = null;
    hqTown = null;
    ServedTowns = null;
    Charters = null;

    function GetHQLocation();
    function GetServedTowns();

    constructor(id, name)
    {
        this.id = id;
        this.name = name;
        this.hqTown = null;
        this.Charters = {};
        this.ServedTowns = {}; // A table of towns
    }
}

function Company::GetHQLocation()
{
    return GSTile.GetClosestTown(GSCompany.GetCompanyHQ(this.id));
}

function Company::GetServedTowns()
{   
    local UpdateServedTowns = {};

    if(this.hqTown!=null){
        UpdateServedTowns[this.hqTown.id] <- this.hqTown;
    }

    foreach(key, charter in this.Charters){
        UpdateServedTowns[charter.towns[0].id] <- charter.towns[0];
        UpdateServedTowns[charter.towns[1].id] <- charter.towns[1];
    }

    foreach(key, town in UpdateServedTowns){
        GSLog.Info(key+":"+town.name);
    }

    this.ServedTowns = UpdateServedTowns;
}