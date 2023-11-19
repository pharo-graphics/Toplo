Class {
	#name : #ToListSecondarySelectionElement,
	#superclass : #ToListSelectionElement,
	#category : 'Toplo-Widget-List-core'
}

{ #category : #initialization }
ToListSecondarySelectionElement >> defaultPadding [

	^ BlInsets all: 3
]

{ #category : #'secondary selection' }
ToListSecondarySelectionElement >> hideSecondarySelection [

	self removeFromParent
]

{ #category : #initialization }
ToListSecondarySelectionElement >> initialize [ 

	super initialize.
	"self background: Color red"


]
