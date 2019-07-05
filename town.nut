class Town
{
    id = null;
    name = null;
    company = null;
    adjacentTowns = null;
    tile = null;

    constructor(id, name, tile)
    {
        this.id = id;
        this.name = name;
        this.company = null;
        this.adjacentTowns = [];
        this.tile = tile;
    } 

    function IsTownAdjacent(town);
}

function Town::IsTownAdjacent(town)
{
    if(GSMap.DistanceManhattan(this.tile, town.tile)<=GSController.GetSetting("adjacency_radius")){
        return true;    
    } else {
        return false;
    }
}

