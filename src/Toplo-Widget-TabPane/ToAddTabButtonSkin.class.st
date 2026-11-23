"
I am the raw skin of `ToAddTabButton`. I show a border when the pointer is over the button.

## Examples

```
ToTabPaneElement exampleRemovableTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the button.
"
Class {
	#name : #ToAddTabButtonSkin,
	#superclass : #ToIconicAddButtonSkin,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'event handling' }
ToAddTabButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (e valueOfTokenNamed: #'border-paint') ]
]

{ #category : #'event handling' }
ToAddTabButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: Color transparent ]
]
