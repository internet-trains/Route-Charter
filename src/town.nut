class Town
{
    id = null;
    name = null;
    company = null;
    adjacentTowns = null;
    tile = null;

    constructor(id, name, tile)
    {
        this.id = id;               //int?
        this.name = name;           //string
        this.company = null;        //A Company object
        this.adjacentTowns = [];    //A list of Town objects
        this.tile = tile;           //TileIndex
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

