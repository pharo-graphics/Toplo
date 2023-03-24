Class {
	#name : #ToListSecondarySelectionElement,
	#superclass : #ToListNodesDecorationElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSecondarySelectionElement >> defaultPadding [

	^ BlInsets all: 3
]

{ #category : #initialization }
ToListSecondarySelectionElement >> initialize [ 

	super initialize.
	self background: Color white
]
