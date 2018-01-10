var ride = new Object();
ride.make='yamaha';
ride.model='2000';
ride.year= 2014;


var owner = new Object();
owner.name = '张三';
owner.occupation = 'bounty';
ride.owner = owner;

var ownerName = ride.owner.name;

//对象文本
var ride1 = {
    make : 'yamaha',
    model : 'XT660R',
    year : 2014,
    purchased : new Date(2015,7,21),
    owner : {
        name : '张杰',
        occupation : 'bounty hunter'
    }
}

var time = new Date();
document.write(time.getDate());

