"
I am the raw skin of `ToEdgePaneOverlay`. I fill it with a translucent light gray.

## Examples

```
ToEdgePaneOverlay instanceDefault
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the overlay.
"
Class {
	#name : #ToEdgePaneOverlaySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'event handling' }
ToEdgePaneOverlaySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (Color veryLightGray alpha: 0.6) ]
]
