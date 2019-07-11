class Town
{
    id = null;
    name = null;
    company = null;
    adjacentTowns = null;
    tile = null;
    stations = null;

    function GetStationsInTown(radius);
    function IsTownAdjacent(town);
    function GetTilesInTown(radius);
    function FilterPassengerStations(stationList);
    function UpdateStations();

    constructor(id, name, tile)
    {
        this.id = id;               //int?
        this.name = name;           //string
        this.company = null;        //A Company object
        this.adjacentTowns = [];    //A list of Town objects
        this.tile = tile;           //TileIndex
        this.stations = this.FilterPassengerStations();
    } 
}

function Town::IsTownAdjacent(town)
{
    if(GSMap.DistanceManhattan(this.tile, town.tile)<=GSController.GetSetting("adjacency_radius")){
        return true;    
    } else {
        return false;
    }
}

function Town::GetStationsInTown(radius)
{
    local tiles = GetTilesInTown(radius);
    local stations = {};
    local stationID = 0;
    foreach(tile in tiles){
        stationID=GSStation.GetStationID(tile)
        if(GSStation.IsValidStation(stationID)){
            stations[stationID] <- 0;
        }
        stationID=0;
    }
    return stations;
}

/* 
 * returns a list of tiles in a radius*radius square around the centre of
 * the given town
 */
function Town::GetTilesInTown(radius)
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

function Town::FilterPassengerStations()
{
    local stations = GetStationsInTown(25)
    local newStations = {}
    foreach(key, station in stations){
        local AcceptedCargos = GSCargoList_StationAccepting(key);
        if(AcceptedCargos.HasItem(0)){
            newStations[key] <- GSBaseStation.GetName(key);
        }
    }
    return newStations;
}

function Town::UpdateStations()
{
    this.stations = FilterPassengerStations();
}

