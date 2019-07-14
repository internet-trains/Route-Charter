class Random {

    constructor() {
    }

    function RandomAccessGSList(gslist) {
        local index = [];
        foreach(item, value in gslist) {
            index.push(item);
        }
        return index[GSBase.RandRange(index.len())];
    }
}
