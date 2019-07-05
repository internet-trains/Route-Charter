
/** Import other source files **/
require("town.nut")
require("company.nut")

class RouteCharter
{
    TownList = {};
    CompanyList = {};
    
    function GetTownList();
	function GetCompanyList();
	function UpdateCompanyList(companyList);
	function PopulateTownAdjacencies(Town, TownList);
	function OfferCharter(company);
    function MonthlyUpdate();

    constructor()
    {
        this.TownList = GetTownList();
        foreach(key, town in this.TownList){
            PopulateTownAdjacencies(town, this.TownList);

        this.CompanyList = GetCompanyList();
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

function RouteCharter::OfferCharter(company)
{
	//placeholder
}

function RouteCharter::MonthlyUpdate()
{
    foreach(key, company in this.CompanyList){
        company.UpdateHQLocation();
        GSLog.Info(company.hqTile);
    }
}