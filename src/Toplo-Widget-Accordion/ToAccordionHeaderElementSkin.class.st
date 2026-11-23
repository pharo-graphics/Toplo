"
I am the raw skin of `ToAccordionHeaderElement`. When I am installed, I set the padding of the header (`padding-content-HS` and `padding-content-V` tokens) and its rounded corners (`border-radius` token).

## Examples

```
ToAccordionElement scriptAccordionsInPane
```

## Design Rationale

- When the accordion is a selected item of a list such as `ToCheckableListElement`, the header receives the selected skin events too. I then set the `#'selected-focused-foreground'` and `#'selected-unfocused-foreground'` tokens to the `color-text` token, so the header text keeps its normal color on the selection background. I remove them when the header is deselected.

## Usage

`ToRawTheme>>newSkinFor:` creates me through `ToAccordionHeaderElement>>newRawSkin`, and the `ToSkinManager` of the header installs me, as `ToAccordionElementSkin` describes for the accordion.

## Implementation Notes

- `installSkinEvent:` tests the `#ghost` stamp of the accordion, but the background it would set is commented out: a ghost accordion looks the same as a plain one.
"
Class {
	#name : #ToAccordionHeaderElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e removeTokenNamed: #'selected-focused-foreground'.
			e removeTokenNamed: #'selected-unfocused-foreground' ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e padding: (BlInsets
					 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
					 vertical: (e valueOfTokenNamed: #'padding-content-V')).
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: 'border-radius')).
			(e parent hasStamp: #ghost) ifFalse: [
				"e background: (e valueOfTokenNamed: #'color-secondary-selection')" ] ]
]

{ #category : #'event handling' }
ToAccordionHeaderElementSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e
				addTokenNamed: #'selected-focused-foreground'
				withValue: (e valueOfTokenNamed: #'color-text').
			e
				addTokenNamed: #'selected-unfocused-foreground'
				withValue: (e valueOfTokenNamed: #'color-text') ]
]
