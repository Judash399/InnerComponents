# Accessibility

Products shouldn't be restricted to people with disabilities. Thats why *Inner Design* strives on making sure all users are able to use the system.

It is **highly recomended** to implement all princibles to maximize accessibility.

## Animation :lucide-film:
Some users are sensitive to motion/animation, whether for accessibility reasons, or personal prefrence. 

* There should always be an option to turn of animations.
* Your App should remain fully functional with disabled animations. 


## Contrast :lucide-contrast:
Text and interactive elements must maintain sufficient contrast against their background. 

* Text should be clearly readable in both light and dark modes.
* Disabled elements should still be legible.

<div class="admonition-row" markdown>

!!! do "Do"
    ![Good Contrast](../../assets/images/examples/accessibility/ContrastDo.png)
    The text is easy to read, and contrasts the background well.

!!! dont "Don't"
    ![Bad Contrast](../../assets/images/examples/accessibility/ContrastDont.png)
    The text is hard to read, and doesnt contrast the background well.

</div>

## Color blindness :lucide-eye:
Design with color blindness in mind. When choosing colors:

* Differences should rely on value, not just hue.
* Important information should **never** be communicated using only color.

## Input :lucide-gamepad-2:
Users shouldn't be required to perform precise or fast inputs.

* Timed-based actions should have a wide response window. Idealy around 5-10 seconds.
* Avoid actions like double-clicks.

!!! do "Do"
    ![Large Click Target](../../assets/images/examples/accessibility/TargetDo.png)
    
    Click/Tap targets should be larger then they appear visually.