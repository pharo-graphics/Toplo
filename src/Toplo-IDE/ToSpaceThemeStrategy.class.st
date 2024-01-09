Class {
	#name : #ToSpaceThemeStrategy,
	#superclass : #Object,
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #accessing }
ToSpaceThemeStrategy >> applyOn: aTarget [

	aTarget themeLabel label: self globalLabel.
	aTarget browseClassButton enabled: self browseButtonEnabled.
	aTarget browseClassButton action: self browseButtonAction.

	aTarget elementSelector elementsTree columns: self selectorColumns.
	aTarget elementView skinPageProvider: self styleView
]

{ #category : #'buttons behavior' }
ToSpaceThemeStrategy >> browseButtonAction [

	^ [  ]
]

{ #category : #'as yet unclassified' }
ToSpaceThemeStrategy >> browseButtonEnabled [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToSpaceThemeStrategy >> globalLabel [

	^ self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
ToSpaceThemeStrategy >> selectorColumns [

	^ self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
ToSpaceThemeStrategy >> styleView [

	^ self shouldBeImplemented
]
