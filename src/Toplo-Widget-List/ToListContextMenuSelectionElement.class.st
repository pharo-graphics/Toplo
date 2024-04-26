Class {
	#name : #ToListContextMenuSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'inner'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListContextMenuSelectionElement >> beneath [

	^ false
]

{ #category : #initialization }
ToListContextMenuSelectionElement >> initialize [

	super initialize.
	inner := ToElement new
		         id: #inner;
		         yourself.
	inner matchParent.
	self addChild: inner
]

{ #category : #accessing }
ToListContextMenuSelectionElement >> inner [

	^ inner
]

{ #category : #skin }
ToListContextMenuSelectionElement >> newRawSkin [ 

	^ ToListContextMenuSelectionElementSkin new
]
