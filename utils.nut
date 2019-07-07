/* 
 * Does it make more sense for these to be Town methods than in a separate utils class?
 */

class utils
{
    function getStationsInTown(town, radius);
    function getTilesInTown(town, radius);
}

function utils::getStationsInTown(town, radius)
{
    local tiles = getStationsInTown(town, radius);
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
function utils::getTilesInTown(town, radius)
{
    local townCentre = town.tile;
    local tiles = [];
    local i = 0;
    local j = 0;
    for(i=-radius;i<=radius;i+=1){
        for(j=-radius;j<=radius; j+=1){
            tiles.append(GSMap.GetTileIndex(GSMap.GetTileX(town.tile)+i,GSMap.GetTileY(town.tile)+j));
        }
    }
    return tiles;
}