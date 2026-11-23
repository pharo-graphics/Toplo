"
I am the raw skin of `ToAccordionElement`. I give the accordion its frame and the arrow that shows whether it is expanded.

When I am installed, I set the border (none when the accordion has the `#borderless` stamp, the `#'border-paint'` token otherwise) and the rounded corners (`border-radius` token). I also put in the header a `ToIconicArrowButton`, sized with the `#'iconic-arrow-breadth'` token, pointing down when the accordion is expanded and right when it is collapsed. On checked and unchecked skin events, `expandHeader:` and `collapseHeader:` turn the arrow.

## Examples

```
ToAccordionElement scriptAccordionsInPane
```

## Design Rationale

- The arrow belongs to the skin, not to the header: a theme decides how the expanded state looks, and the header only offers a place for the icon (`ToAccordionHeaderElement>>icon:`).
- The accordion expanded state is its checked state, so I react to the checkable skin events (`checkedSkinEvent:`, `uncheckedSkinEvent:`) rather than to a dedicated expansion event.

## Usage

1. `ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the accordion (`ToAccordionElement>>newRawSkin`), when the accordion gets a skin in a space.
2. The `ToSkinManager` of the accordion installs me and sends me the skin events of the accordion.
"
Class {
	#name : #ToAccordionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #'event handling' }
ToAccordionElementSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self expandHeader: e header ]
]

{ #category : #'event handling' }
ToAccordionElementSkin >> collapseHeader: anHeader [

	anHeader icon beRight
]

{ #category : #'event handling' }
ToAccordionElementSkin >> expandHeader: anHeader [

	anHeader icon beDown
]

{ #category : #'event handling' }
ToAccordionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| arrowIm |
			(e hasStamp: #borderless)
				ifTrue: [ e border: BlBorder empty ]
				ifFalse: [ e border: (e valueOfTokenNamed: #'border-paint') ].
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: 'border-radius')).
			arrowIm := e isExpanded
				           ifTrue: [ ToIconicArrowButton down ]
				           ifFalse: [ ToIconicArrowButton right ].
			arrowIm extent:
				(e valueOfTokenNamed: #'iconic-arrow-breadth') asPoint.
			e header icon: arrowIm ]
]

{ #category : #'event handling' }
ToAccordionElementSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e | self collapseHeader: e header ]
]
