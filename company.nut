class Company
{
    id = null;
    name = null;

    constructor()
    {
        this.id = id;
        this.name = name
    }

    function AssignExclusiveRights(townid);
}

function Company::AssignExclusiveRights(townid)
{
    if(this.IsActionAvailable(townid, TOWN_ACTION_BUY_RIGHTS)) {
        this.PerformTownAction(townid, TOWN_ACTION_BUY_RIGHTS);
        return true;
    } else {
        return false;
    }
}