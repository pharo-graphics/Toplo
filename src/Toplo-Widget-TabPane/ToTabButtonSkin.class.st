"
I am the raw skin of `ToTabButton`. When the list is not flowable, I define the `#'color-list-primary-selection-focused'` token of the tab as its container background, which is the color of the shrink feedback layer of its label. I remove the token when I am uninstalled. See `ToTabItemElementSkin` for the rest.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the button.
"
Class {
	#name : #ToTabButtonSkin,
	#superclass : #ToTabItemElementSkin,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e | "setup the selection color for the ShrinkFeedbackLayer of the TabButton "
			e holder listElement toConfiguration isFlowable ifFalse: [
					e
						addTokenNamed: #'color-list-primary-selection-focused'
						withValue: (e valueOfTokenNamed: #'color-bg-container') ] ]
]

{ #category : #'event handling' }
ToTabButtonSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		"setup the selection color for the ShrinkFeedbackLayer of the TabButton "
		e removeTokenNamed: #'color-list-primary-selection-focused' ]
]
