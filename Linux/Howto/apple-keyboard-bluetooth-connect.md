# How to pair Magic Keyboard (bluetoothctl)

1. Turn off the keyboard.

2. Open terminal. Run the following commands:
    ```
    sudo bluetoothctl
    [bluetooth]# power on
    [bluetooth]# agent KeyboardOnly
    [bluetooth]# default-agent
    [bluetooth]# pairable on
    ```
3. Power on your Magic Keyboard. Hold the power button and do not release until step 5.

4. In bluetoothctl type:
    ```
    [bluetooth]# scan on
    ```
    It will start scanning for available Bluetooth devices. What we are looking for would be indicated like this:
    ```
    [NEW] Device 78:CA:39:XX:XX:XX Apple Wireless Keyboard
    ```
    > NOTE: it can appears only as 'Magic Keyboard'

5. Copy MAC address of the keyboard from the previous step. Add keyboard as trusted device:
    ```
    [bluetooth]# trust 78:CA:39:XX:XX:XX
    ```
    Once it's' trusted, start pairing:
    ```
    [bluetooth]# pair 78:CA:39:XX:XX:XX
    Attempting to pair with 78:CA:39:XX:XX:XX
    [CHG] Device 78:CA:39:4F:CA:AF Connected: yes
    [agent] PIN code: 299251
    ```
    > NEXT STEP was executed automatically, I didn't have to insert the PIN number 

6. Release the 'Power on' button on the keyboard and type PIN code on the keyboard. It won’t indicate anything in the terminal, but that's fine. Commit PIN by hitting ‘Enter’. If pairing is successful output will be similar to that:
    ```
    [CHG] Device 78:CA:39:XX:XX:XX ServicesResolved: yes
    [CHG] Device 78:CA:39:XX:XX:XX Paired: yes
    Pairing successful
    ```
    
    > I DIDN'T NEED NEXT STEP as well, but here it is just in case...

7. Now your keyboard is paired, but most likely it will be acting as a Numpad. To resolve this issue run following in terminal:
    ```
    sudo apt update
    sudo apt install numlockx
    numlockx off
    ```
    > NOTE: Probably it also makes sense to add 'numlock off' as startup command in 'gnome-session-properties'
