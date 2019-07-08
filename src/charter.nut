require("utils.nut");

class Charter
{
    towns = [];
    company = null;
    isFulfilled = false;
    offerID = null;
    goalID = null;
    active = false;

    constructor(towns, company, offerID)
    {
        this.towns = towns;
        this.company = company;
        this.isFulfilled = false;
        this.offerID = offerID;
        this.goalID = null;
        this.active = false;
    }
    function CheckFulfilled();
    function CreateGoal();
}

function Charter::CheckFulfilled()
{    
}

function Charter::CreateGoal()
{
    local charterGoalText = GSText(GSText.STR_CHARTER_GOAL, this.towns[0].id, this.towns[1].id);
    this.goalID = GSGoal.New(this.company.id, charterGoalText, GSGoal.GT_STORY_PAGE, GSStoryPage.New(this.company.id, charterGoalText));
    this.active = true;
    GSLog.Info("Goal ID " + this.goalID + " created");
}