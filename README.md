# CannonSurvive

This is my final project for [CS50: Introduction to Computer Science](https://pll.harvard.edu/course/cs50-introduction-computer-science?delta=0), by [Na Prática](https://www.napratica.org.br/) platform.

CannonSurvive is a simple 2D survival game in which you control a cannon and must kill the enemies that keep appearing to survive as much time as you can.


## The Gameplay

The cannon's movement consists of acceleration. So when you hold a key to go to a certain direction you're increasing the acceleration on that direction, and must hold the key of the opposite direction to keep slowing down (or reach the screen limits, where acceleration goes to zero and the cannon can no longer move). The cannon shoots are automatic and have a fixed rate. The shot goes directly in the direction of the mouse at the moment, until it goes out of the screen and the bullet gets removed from the game.

There are two enemies: the Follower and the Bomber (none spawn in the area the player can move). Both were made using Finite-State Machine.
  - Follower: as the name says, it follows the player. It's pattern cicle is to stay still for a random time and then go where the player is (at the specific moment) at a random velocity.
  - Bomber: well... It places bombs. It's cicle pattern is to select a random place to plant a bomb, go there at a random velocity and plant the bomb.
    - The bomb: it will wait a time before it starts the countdown (it'll blink faster as time keeps passing) and then explodes, increasing the area in which causes damage for a short period of time. After that, it'll be deleted from the game.
    
Through all the time there'll be a stopwatch displayed at the top left corner. The End/Game Over screen will show the time the player managed to survive.
