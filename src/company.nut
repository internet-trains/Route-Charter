class Company
{
    id = null;
    name = null;
    hqTile = null;
    charterRoutes = null;

    function GetHQLocation();
    function UpdateHQLocation();

    constructor(id, name)
    {
        this.id = id;
        this.name = name;
        this.hqTile = this.GetHQLocation();
        this.charterRoutes = []; // A list of Town Pairs
    }
}

function Company::GetHQLocation()
{
    return GSCompany.GetCompanyHQ(this.id); 
}

function Company::UpdateHQLocation()
{
    this.hqTile = GSCompany.GetCompanyHQ(this.id);
}