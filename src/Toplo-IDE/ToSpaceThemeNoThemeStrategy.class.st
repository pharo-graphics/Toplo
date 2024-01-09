Class {
	#name : #ToSpaceThemeNoThemeStrategy,
	#superclass : #ToSpaceThemeStrategy,
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #'as yet unclassified' }
ToSpaceThemeNoThemeStrategy >> browseButtonEnabled [

	^ false
]

{ #category : #accessing }
ToSpaceThemeNoThemeStrategy >> globalLabel [.
	^ 'I have no theme installed.'
]

{ #category : #'as yet unclassified' }
ToSpaceThemeNoThemeStrategy >> selectorColumns [

	^ {
		  ToSpaceThemeElementListSpec nameColumn.
		  ToSpaceThemeElementListSpec visibilityColumn }
]

{ #category : #'as yet unclassified' }
ToSpaceThemeNoThemeStrategy >> styleView [

	^ self shouldBeImplemented
]
