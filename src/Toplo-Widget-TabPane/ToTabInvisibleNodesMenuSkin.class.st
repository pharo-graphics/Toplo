"
I am the raw skin of `ToTabInvisibleNodesMenu`. I give the menu an icon with three dots, horizontal or vertical according to the orientation of the tab group.

## Examples

```
ToTabPaneElement exampleManyTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the menu.
"
Class {
	#name : #ToTabInvisibleNodesMenuSkin,
	#superclass : #ToMenuSkin,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'event handling' }
ToTabInvisibleNodesMenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e iconImage: (self menuImageIn: e tabGroupElement).
			e icon extent: 20 @ 20 ]
]

{ #category : #private }
ToTabInvisibleNodesMenuSkin >> menuImageIn: aTabGroupElement [

	^ aTabGroupElement isHorizontal
		  ifTrue: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morehoriz' ]
		  ifFalse: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morevert' ]
]
