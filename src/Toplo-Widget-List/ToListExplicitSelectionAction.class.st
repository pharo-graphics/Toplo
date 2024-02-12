Class {
	#name : #ToListExplicitSelectionAction,
	#superclass : #ToListSelectionAction,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #testing }
ToListExplicitSelectionAction class >> isDeprecated [ 

	^ true
]

{ #category : #hook }
ToListExplicitSelectionAction >> applyOn: anObject [

	anObject listExplicitSelectionAction: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListExplicitSelectionAction >> indexes [

	^ indexes
]

{ #category : #accessing }
ToListExplicitSelectionAction >> indexes: anArray [

	indexes := anArray
]
