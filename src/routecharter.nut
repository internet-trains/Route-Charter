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

/** Import other source files **/
require("town.nut")
require("company.nut")
require("charter.nut")
require("random.nut")

class RouteCharter
{
    TownList = {};
    CompanyList = {};
    CharterList = {};
    OfferedCharters = {};
    offerID=null;
    
    function GetTownList();
    function PopulateTownAdjacencies(Town, TownList);

	function GetCompanyList();
	function UpdateCompanyList(companyList);
    function GetCompanyHQTown(company);

	function GenerateCharter();
    function OfferCharter(company, towns);
    function StartCharter(charterID);

    function MonthlyUpdate();
    function AnnualUpdate();

    constructor()
    {
        this.TownList = GetTownList();
        foreach(key, town in this.TownList){
            PopulateTownAdjacencies(town, this.TownList);

        this.CompanyList = GetCompanyList();
        this.CharterList = {};
        this.OfferedCharters = {};
        this.offerID = 0;
        }
    }
}

/* 
 * Function returns a GSTownList object of all towns on the map, however requires post processing 
 * to get a list of town objects as defined in town.nut
 */
function RouteCharter::GetTownList()
{
	local RawTownList = GSTownList();
    local TownList = {};
    foreach(key, value in RawTownList){
			TownList[key] <- Town(key, GSTown.GetName(key), GSTown.GetLocation(key));
		}
    return TownList;
}

/* 
 * Function returns a squirrel table of (up to 15) companies on the map
 */
function RouteCharter::GetCompanyList()
{
	local CompaniesList = {};
	local id = 0;
	for(id=0;id<16;id+=1){
		if(GSCompany.ResolveCompanyID(id)!=GSCompany.COMPANY_INVALID){
			CompaniesList[id] <- Company(id, GSCompany.GetName(id));
		}
	}
	return CompaniesList;
}

function RouteCharter::UpdateCompanyList()
{
    local id = 0;
    local idList = [];
    foreach(key, company in this.CompanyList){
        idList.append(company.id);
    }
    for(id=0; id<16; id+=1){
        if(!(id in idList) && (GSCompany.ResolveCompanyID(id)!=GSCompany.COMPANY_INVALID)){
			this.CompanyList[id] <- Company(id, GSCompany.GetName(id));
        }
    }
}

/*
 * Function takes a town object and the list of all town objects on the map and modifies town.adjacentTowns
 * to contain references to every town which is adjacent to the town passed to the function
 */
function RouteCharter::PopulateTownAdjacencies(Town, TownList)
{
	foreach(key, target in TownList){
		if(((Town in target.adjacentTowns) || Town.IsTownAdjacent(target))&&(Town!=target)){
			Town.adjacentTowns.append(target);
		} 
	}
}

function RouteCharter::OfferCharter(company, towns)
{
	this.OfferedCharters[offerID] <- Charter(towns, company, this.offerID);
    local CharterQuery = GSText(GSText.STR_CHARTER_QUERY, towns[0].id, towns[1].id);
    GSLog.Info("Offering Charter ID " + this.offerID);
    GSLog.Info(company.id + " : " + company.name);
    GSLog.Info(GSCompany.ResolveCompanyID(company.id))
    GSGoal.Question(this.offerID, company.id, CharterQuery, GSGoal.QT_QUESTION, GSGoal.BUTTON_ACCEPT+GSGoal.BUTTON_DECLINE);
    this.offerID += 1;
}

function RouteCharter::StartCharter(charterID)
{
    GSLog.Info("Starting Charter ID " + charterID);
    GSGoal.CloseQuestion(charterID);        // Close the question for all clients in the company once one client has responded
    this.CharterList[charterID] <- this.OfferedCharters[charterID];
    this.CharterList[charterID].CreateGoal();
    this.CharterList[charterID].company.Charters[charterID] <- this.OfferedCharters[charterID];
}

function RouteCharter::MonthlyUpdate()
{
    foreach(key, company in this.CompanyList){
        if(company.GetHQLocation()!=65535){ 
            company.hqTown = TownList[company.GetHQLocation()]
        } 
        company.GetServedTowns();
    }

    foreach(key, town in this.TownList){
        town.UpdateStations();
    }
    
    foreach(key, charter in this.CharterList){
        charter.CheckFulfilled();
    }
}

function RouteCharter::AnnualUpdate()
{
    this.GenerateCharters();
}

function RouteCharter::GenerateCharters()
{  
    foreach(key, company in CompanyList){
        if(company.ServedTowns.len()!=0){
            local TownA = company.ServedTowns[Random.RandomAccessGSList(company.ServedTowns)];
            local TownB = TownA.adjacentTowns[Random.RandomAccessGSList(TownA.adjacentTowns)];
            this.OfferCharter(company, [TownA, TownB])
        }
    }   
}