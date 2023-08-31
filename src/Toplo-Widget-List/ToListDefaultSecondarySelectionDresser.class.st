Class {
	#name : #ToListDefaultSecondarySelectionDresser,
	#superclass : #ToListSecondarySelectionDresser,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDefaultSecondarySelectionDresser >> borderWidth [

	^ 2
]

{ #category : #initialization }
ToListDefaultSecondarySelectionDresser >> defaultPadding [

	^ BlInsets all: 3
]
