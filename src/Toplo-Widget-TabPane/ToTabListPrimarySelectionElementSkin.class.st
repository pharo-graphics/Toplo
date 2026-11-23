"
I am the raw skin of `ToTabListPrimarySelectionElement`. I give it the visibility of the tab it belongs to, so that the bar of a hidden tab is hidden too.

## Examples

```
ToTabPaneElement exampleManyTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the selection element.
"
Class {
	#name : #ToTabListPrimarySelectionElementSkin,
	#superclass : #ToListPrimarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabListPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e visibility: e nodeContainer visibility ]
]
