"
I am the raw skin of `ToTabListSecondarySelectionElement`. In a list that is not flowable, I give it the visibility of its tab and the color of the `#'tab-color-secondary-selection'` token.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the selection element.
"
Class {
	#name : #ToTabListSecondarySelectionElementSkin,
	#superclass : #ToListSecondarySelectionElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabListSecondarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e listElement toConfiguration isFlowable ifFalse: [
					e visibility: e nodeContainer visibility.
					e background:
						(e valueOfTokenNamed: #'tab-color-secondary-selection') ] ]
]
