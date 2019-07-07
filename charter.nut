require("utils.nut");

class Charter
{
    towns = [];
    company = null;
    isFulfilled = false;
    offerID = null;

    constructor(towns, company, offerID)
    {
        this.towns = towns;
        this.company = company;
        this.isFulfilled = false;
        this.offerID = offerID;
    }
    function CheckFulfilled();
}

function Charter::CheckFulfilled()
{    
}