Class {
	#name : #ToListSecondarySelectionDecorationElement,
	#superclass : #ToListNodesDecorationElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSecondarySelectionDecorationElement >> defaultPadding [

	^ BlInsets all: 3
]

{ #category : #initialization }
ToListSecondarySelectionDecorationElement >> initialize [ 

	super initialize.
	self background: Color white
]
