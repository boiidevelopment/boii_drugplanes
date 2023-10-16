----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

# BOII | Development - Drugs: Drug Planes

Here we have a nice random trigger event for your citizens to enjoy.
The script adds a random event to crash some transport mule planes around specified city zones.
The planes will drop a selection of packages which players can collect for rewards both planes and packages are synced between clients.
Script is highly customisable through the config files, no coding knowledge is necessary.
Full installation instructions provided within the readme.
Enjoy! 

### Dependencies

- Framework; boii_base, qb-core, esx, ox_core currently support or your own custom framework can be added using the bridge functions.

### Optional Resources

boii_ui - https://github.com/boiidevelopment/boii_ui

### Install

1. Script Customisation: 

- Customise `server/config_sv.lua` to your server requirements. This is where you can setup the main script logic.
- Customise `shared/config.lua` to your server requirements. This is where you can setup framework/general options.
- Customise `shared/language/en.lua` to your server requirements. For other translations you can create a new file and follow further instructions in `fxmanifest.lua`.

2. Custom Frameworks: **If you are using one of the included frameworks you can skip this step!**

- Customise the `framework.lua` files in both client and server to fit your own frameworks requirements. You must use the same events/functions shown within the current framework examples due to escrow.

3. Script Installation: 

- Drag and drop `boii_boxing` into your server resource ensuring your load order is correct. View the attached image below for a load order reference.

![image](https://cdn.discordapp.com/attachments/900123174669279284/969505774575435786/LOADORDER.jpg?ex=651335dd&is=6511e45d&hm=d7e7dc56675feadea2ad07d447df2429e9e052d8bc0049c16bbb3665650a6a51&)

- If you are not using categorised folders within your server then you add `ensure boii_boxing` to your `server.cfg` 

4. Restart Server:

- Once you have completed all of the above steps you are now ready to restart your server and the resource should be working.

### PREVIEW
https://www.youtube.com/watch?v=CH6l1dMKGmw

### SUPPORT
https://discord.gg/boiidevelopment
