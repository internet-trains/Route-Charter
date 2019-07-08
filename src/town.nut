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
    function getStationsInTown(radius);
    function getTilesInTown(radius);
}

function Town::IsTownAdjacent(town)
{
    if(GSMap.DistanceManhattan(this.tile, town.tile)<=GSController.GetSetting("adjacency_radius")){
        return true;    
    } else {
        return false;
    }
}

function Town::getStationsInTown(radius)
{
    local tiles = getStationsInTown(radius);
    local stations = [];
    local stationID = 0;
    foreach(tile in tiles){
        stationID=GSStation.GetStationID(tile)
        if((stationID!=0)&&!(stationID in stations)){
            stations.append(stationID);
        }
        stationID=0;
    }
    return stations;
}

/* 
 * returns a list of tiles in a radius*radius square around the centre of
 * the given town
 */
function Town::getTilesInTown(radius)
{
    local tiles = [];
    local i = 0;
    local j = 0;
    for(i=-radius;i<=radius;i+=1){
        for(j=-radius;j<=radius; j+=1){
            tiles.append(GSMap.GetTileIndex(GSMap.GetTileX(this.tile)+i,GSMap.GetTileY(this.tile)+j));
        }
    }
    return tiles;
}