Class {
	#name : #ToSpaceThemeWithThemeStrategy,
	#superclass : #ToSpaceThemeStrategy,
	#instVars : [
		'theme'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #'buttons behavior' }
ToSpaceThemeWithThemeStrategy >> browseButtonAction [

	^ [ self theme browse ]
]

{ #category : #'as yet unclassified' }
ToSpaceThemeWithThemeStrategy >> browseButtonEnabled [

	^ true
]

{ #category : #accessing }
ToSpaceThemeWithThemeStrategy >> globalLabel [

	^ 'I have a ' , self theme name , ' installed.'.
]

{ #category : #'as yet unclassified' }
ToSpaceThemeWithThemeStrategy >> selectorColumns [

	^ {
		  ToSpaceThemeElementListSpec  nameColumn.
		  ToSpaceThemeElementListSpec tokenIconColumn.
		  ToSpaceThemeElementListSpec rulesCountColumn.
		  ToSpaceThemeElementListSpec stampsCountColumn.
		  ToSpaceThemeElementListSpec visibilityColumn }
]

{ #category : #'as yet unclassified' }
ToSpaceThemeWithThemeStrategy >> styleView [

	^ self theme inspectionThemeForElement
]

{ #category : #accessing }
ToSpaceThemeWithThemeStrategy >> theme [

	^ theme
]

{ #category : #accessing }
ToSpaceThemeWithThemeStrategy >> theme: anObject [

	theme := anObject
]
