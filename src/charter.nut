require("utils.nut");

class Charter
{
    towns = [];
    company = null;
    isFulfilled = false;
    offerID = null;
    goalID = null;
    active = false;
    length = null;

    constructor(towns, company, offerID)
    {
        this.towns = towns;
        this.company = company;
        this.isFulfilled = false;
        this.offerID = offerID;
        this.goalID = null;
        this.active = false;
        this.length = GSTile.GetDistanceManhattanToTile(towns[0].tile, towns[1].tile);
    }
    function CheckFulfilled();
    function CreateGoal();
    function IsFulfilledDirect();
    function IsFulfilledIndirect();
}

function Charter::CheckFulfilled()
{
    if(this.length < GSController.GetSetting("charter_length_to_require_direct_routes")){
        this.isFulfilled = this.IsFulfilledDirect();
    } else {
        this.isFulfilled = this.IsFulfilledIndirect();
    }
    GSLog.Info(this.isFulfilled);
}

function Charter::CreateGoal()
{
    local charterGoalText = GSText(GSText.STR_CHARTER_GOAL, this.towns[0].id, this.towns[1].id);
    this.goalID = GSGoal.New(this.company.id, charterGoalText, GSGoal.GT_STORY_PAGE, GSStoryPage.New(this.company.id, charterGoalText));
    this.active = true;
    GSLog.Info("Goal ID " + this.goalID + " created");
}

function Charter::IsFulfilledDirect()
{
    local isFulfilled = false;
    foreach(key, value in this.towns[0].stations){
        local destinationList = GSStationList_CargoPlannedByVia(key, 0);
        foreach(key, value in destinationList){
            if(key in this.towns[1].stations){
                isFulfilled = true;
            }
        }
    }
    return isFulfilled;
}

function Charter::IsFulfilledIndirect()
{
    local.isFulfilled = false;
    foreach(key, value in this.towns[0].stations){
        local destinationList = GSStationList_CargoPlannedByFrom(key, 0);
        foreach(key, value in destinationList){
            if(key, in this.towns[1].stations){
                isFulfilled = true;
            }
        }
    }
    return isFulfilled;
}