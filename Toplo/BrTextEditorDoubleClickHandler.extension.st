Extension { #name : #BrTextEditorDoubleClickHandler }

{ #category : #'*Toplo' }
BrTextEditorDoubleClickHandler >> doubleClickEvent: anEvent [
	| aScreenPosition aGlobalTextIndex aSelecter anEditorElement |
	
	"To not create an instance of me for each tiny text element"
	anEditorElement := anEvent currentTarget
		withAllParentsDetect: [ :anElement | (anElement isKindOf: BrEditorElement) or: [anElement isKindOf: ToEditorElement]]
		ifFound: #yourself
		ifNone: [ ^ self ].
		
	aScreenPosition := (anEditorElement localBoundsToMine: (BlBounds origin: anEvent localPosition extent: 0.0@0.0) fromChild: anEvent currentTarget) center.

	aGlobalTextIndex := anEditorElement editor navigator
		findTextIndexAtScreenPosition: aScreenPosition
		ifAbsent: [ ^ self ].
	
	aSelecter := anEditorElement editor selecter.

	anEvent modifiers isPrimaryModifier
		ifTrue: [ aSelecter withoutCursorUpdate ].

	aSelecter
		wordAt: aGlobalTextIndex;
		select
]
