"
I am the raw skin of `ToAccordionBodyElement`. When I am installed, I set the padding of the body content (`padding-content-HS` and `padding-content-V` tokens).

## Examples

```
ToAccordionBodyElement exampleExpanded
```

## Design Rationale

- I put the padding on the content element of the body, not on the body itself. The content is gone when the accordion is collapsed, so the padding disappears with it and a collapsed body takes no height.

## Usage

`ToRawTheme>>newSkinFor:` creates me through `ToAccordionBodyElement>>newRawSkin`, and the `ToSkinManager` of the body installs me, as `ToAccordionElementSkin` describes for the accordion.
"
Class {
	#name : #ToAccordionBodyElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionBodyElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e content padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
				 vertical: (e valueOfTokenNamed: #'padding-content-V')) ]
]
