from .groups import groups

from libqtile.config import ScratchPad, DropDown

# Define Scratchpads
groups.append(ScratchPad("scratchpad", [
    DropDown("term", "alacritty", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1),
    DropDown("volume", "pavucontrol", width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.8),
    DropDown("angular", "alacritty", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1),
    DropDown("notebook", "alacritty", width=0.8, height=0.8, x=0.1, y=0.1, opacity=1),
]))