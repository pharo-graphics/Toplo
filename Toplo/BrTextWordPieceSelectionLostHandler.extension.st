Extension { #name : #BrTextWordPieceSelectionLostHandler }

{ #category : #'*Toplo' }
BrTextWordPieceSelectionLostHandler >> handleEvent: anEvent [
	| aTextEditElement anEditorElement |
	
	"To not create an instance of me for each tiny text element"
	anEditorElement := anEvent currentTarget
		allParentsDetect: [ :anElement | (anElement isKindOf: BrEditorElement) or: [anElement isKindOf: ToEditorElement] ]
		ifFound: #yourself
		ifNone: [ ^ self ].

	anEvent consumed: true.

	aTextEditElement := anEvent currentTarget.

	aTextEditElement selection do: [ :aMonotoneSelection |
		| aGlobalFrom aGlobalTo |

		aGlobalFrom := self localTextIndexToGlobal: aMonotoneSelection from in: aTextEditElement textStart.
		aGlobalTo := self localTextIndexToGlobal: aMonotoneSelection to in: aTextEditElement textStart.
		anEditorElement editor recordDeselection: (BlMonotoneSelection from: aGlobalFrom to: aGlobalTo) ]
]
