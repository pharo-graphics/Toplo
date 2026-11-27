"
I am the raw skin of `ToTabListElement`. I remove border and padding, and clear the secondary selection when the pointer leaves the list.

## Examples

```
ToTabListElement exampleTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the list.
"
Class {
	#name : #ToTabListElementSkin,
	#superclass : #ToItemListElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e border: BlBorder empty.
			e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToTabListElementSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e secondarySelecter deselectAll ]
]
