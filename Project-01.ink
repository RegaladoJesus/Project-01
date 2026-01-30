/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/



// Dog that robs houses
// 3 endings:
// Dies
// Gets away rich
// turns good with love of his life


VAR house = ""
VAR layout_iq = 0
VAR items_stolen = 0
VAR living_visited = false
VAR kitchen_visited = false
VAR lights_on = false
VAR rooms_visited = 0
VAR attempt = "Succeeded"
VAR key_found = false
VAR bedroom_visited = false
VAR shoelaces_found =false
VAR speed = 10

->start

== start ==
You wake up to your alarm blairing
9:00 AM 
*[Turn Off Alarm] ->wake_up

== wake_up ==
You drag yourself out of bed and get dressed for the day
*[Go To Kitchen]
Walking over to the fridge, you bump into the pile of mail on your kitchen table
You gather the envelopes from the floor and there's one that stands out
Eviction Notice
->lunch_hangout

== lunch_hangout ==
*[Continue]
Later in the day you meet up with some old friends at the park
You all catch up but then money gets brought up
"I've made a lot from pawning off my old things"
This sparks an idea in your mind
->house_choice

== house_choice ==
*[The Next Day]
You don't own very many things to pawn off, but there is another way of getting things to sell
On your daily morning walk you notice 3 houses, each will be alone for the night
The Pink House
    A nice family of 3 lives here. They plan to go on vacation for the weekend so the house is guranteed to be unoccupied for at least a couple days.
The Red House
    - A lonely elder lives here alone. He's always doing spontatneous things nowadays but atleast he goes to sleep early and is a deep sleeper.
The Blue House
    - A group of college students rent this house, and they go out every Friday and always come back at around 4 AM.

Which house do you choose?
+[Pink House]
    ~ house = "pink"
    -> approaching
+[Red House]
    ~ house = "red"
    ->approaching
+[Blue House]
    ~ house = "blue"
    -> approaching


== approaching == 
You chose the {house} house
*[Continue]
Once it turns dark outside you stake out the house and wait for {house == "pink": the family to head off to vacation} {house == "red": the elder to fall asleep}{house == "blue": the students to head out for the night}
->enter_house


== enter_house ==
*[Break In]
You walk around to the back of the house and are able to fit through a small hole in the back door.
->kitchen

== kitchen ==
{not kitchen_visited: 
The house feels empty with its silence
~ rooms_visited = rooms_visited +1
~ kitchen_visited = true
}
{kitchen_visited:
    {not shoelaces_found:
    ->shoelaces
    }
}
{house == "blue": You should most likely go to the living room first}
You walk into the kitchen
There must be something of value in the house
Search the rest of the house
+[Go to Living Room]->living_room
+[Go Upstairs] ->upstairs
+[Go to Office] ->office
+[Leave]->final_stats


== shoelaces ==
You see shoelaces that could benefit you
    Do you pick them up?
    *[Yes]
        ~speed = speed + 10
        Your speed just got a lot faster with the new laces
        ~shoelaces_found = true
        ->kitchen
    *[No]
        ~shoelaces_found = true
        ->kitchen
->kitchen

== living_room ==
{not living_visited: 
    This room feels new
    ~ living_visited = true
    ~ rooms_visited = rooms_visited +1
}
You're in the living room
{house == "blue": 
    -
    ->blue_livingroom
}
{items_stolen > 2: 
    You can't carry any more items 
    *[Leave the House]->final_stats
}
    { items_stolen <= 2:
    * [Steal the TV]
        ~ items_stolen += 1
        -> living_room

    * [Steal a lamp]
        ~ items_stolen += 1
        -> living_room
    
    * [Steal a Watch]
        ~ items_stolen += 1
        -> living_room
    
    * [Steal Expensive Shoes]
        ~ items_stolen += 1
        -> living_room
}

+[Go to Kitchen] ->kitchen
+[Go Upstairs] ->upstairs
+[Go to Office]->office



== upstairs == 
*[Go to Bedroom]->bedroom
*[Go Downstairs] ->living_room
->END

== bedroom ==
~bedroom_visited = true
You found a key!
~key_found = true
*[Look around] 
    You look around the bedroom, but dont find anything
    ->bedroom
*[Go Downstairs]->living_room


== office ==
{house == "red": ->red_office}
{not key_found: 
    The office is locked
    +[Go to Kitchen] ->kitchen
    +[Go Upstairs] ->upstairs
    +[Go to Living Room] ->living_room
}
{key_found:
    ~rooms_visited = rooms_visited +1
    The office was hiding gold!
    You grab all the gold you can and run far from the house
    ~items_stolen = items_stolen +5
    ->final_stats
}


== red_office == 
You enter the office and find a beautiful saint bernard with the same color fur as yours
They interrogate you, but you eventually get along
Hours pass but it only feels like its been a few minutes
Then the idea comes up that you both should run away together
And so you do,
You pawn off the rest of your belongings from your apartment and runaway to Ireland and live happily ever after
-> final_stats

== blue_livingroom ==
You hear a car roll into the driveway
The college students are back. It's finals week and they only left to get take out.
*[Continue]
They walk in through the front door and start to eat dinner in the living room.
All of a sudden you get happy tail and your tail hits the couch you're hiding behind
They find you and take you to the pound.
~ attempt = "failed"
-> final_stats

== final_stats ==
{attempt == "Succeeded": You made it out of the house without a scratch!}
House Targeted: {house}
Items Stolen: {items_stolen}
{house == "red":Hearts Stolen: 1}
Rooms Visited: {rooms_visited}
Attempt: {attempt}
->END





