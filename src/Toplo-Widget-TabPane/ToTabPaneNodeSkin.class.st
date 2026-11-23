"
I am the raw skin of `ToTabPaneNode`. I give the selected foreground of the tab the color of the bar (`#'color-primary-checked'` token) when the list is not flowable, and let the theme decide otherwise.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the node.
"
Class {
	#name : #ToTabPaneNodeSkin,
	#superclass : #ToTabNodeSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabPaneNodeSkin >> configureSelectionTokensIn: anItemElement [

	anItemElement holder listElement toConfiguration isFlowable
		ifTrue: [
				anItemElement removeTokenNamed: #'selected-focused-foreground'.
				anItemElement removeTokenNamed: #'selected-unfocused-foreground' ]
		ifFalse: [
				anItemElement
					addTokenNamed: #'selected-focused-foreground'
					withValue:
					(anItemElement valueOfTokenNamed: #'color-primary-checked').
				anItemElement
					addTokenNamed: #'selected-unfocused-foreground'
					withValue:
					(anItemElement valueOfTokenNamed: #'color-primary-checked') ]
]

{ #category : #'event handling' }
ToTabPaneNodeSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | self configureSelectionTokensIn: e ]
]
