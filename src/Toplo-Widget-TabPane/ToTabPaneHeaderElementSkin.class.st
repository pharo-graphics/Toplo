"
I am the raw skin of `ToTabPaneHeaderElement`. I give it a rectangle geometry, and no other look.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the header.
"
Class {
	#name : #ToTabPaneHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'event handling' }
ToTabPaneHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: BlRectangleGeometry new]
]
