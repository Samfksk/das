# Discord Waiting Room (ESX)

Det här är ett enkelt FiveM/ESX-resurs som skickar en notis till staff när någon går in i en specifik Discord-väntrumskanal.

## Installation

1. Lägg mappen `discord-waiting-room` i din `resources`-katalog.
2. Lägg till i `server.cfg`:
   ```
   ensure discord-waiting-room
   ```
3. Uppdatera `config.lua` med dina ESX-grupper och önskad text.

## Så fungerar det

Själva FiveM-servern kan inte läsa Discords röstkanaler direkt. Du behöver därför en Discord-bot (eller annan webhook-lösning) som triggar eventet på servern när någon sätter sig i väntkanalen.

### Rekommenderad koppling

Låt din Discord-bot köra ett RCON-kommando när någon joinar väntrummet:

```
waitingroom Förnamn Efternamn
```

Det triggar eventet `discord-waiting-room:waitingRoomJoin` på servern (registrerat i `server.lua`) och skickar en notis till alla staff med rätt grupp.

## ESX-grupper

Endast spelare med en grupp i `Config.AllowedGroups` får notisen. Standard:

- mod
- admin
- owner
- ägare

Ändra listan i `config.lua` för att matcha dina permissions.
