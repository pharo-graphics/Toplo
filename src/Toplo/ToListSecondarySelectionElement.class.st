Class {
	#name : #ToListSecondarySelectionElement,
	#superclass : #ToListSelectionElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - initialization dresser' }
ToListSecondarySelectionElement >> defaultDresser [ 

	^ ToListDefaultSecondarySelectionDresser new
]

{ #category : #initialization }
ToListSecondarySelectionElement >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 5
]
