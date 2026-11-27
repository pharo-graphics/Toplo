"
I am the raw skin of `ToEdgePane`. I give it a rectangle geometry and a red background, a placeholder look until the edge pane is finished.

## Examples

```
ToEdgePane instanceDefault
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the edge pane.
"
Class {
	#name : #ToEdgePaneSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'event handling' }
ToEdgePaneSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: BlRectangleGeometry new.
			e background: Color red ]
]
