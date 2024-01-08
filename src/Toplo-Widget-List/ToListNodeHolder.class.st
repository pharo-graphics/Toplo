Class {
	#name : #ToListNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'data',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToListNodeHolder >> data: aData [ 

	data := aData.
	infiniteElement nodeHolderBuilder value: self
]

{ #category : #accessing }
ToListNodeHolder >> isSelected [

	^ self infiniteElement isSelectedAtIndex: self position
]

{ #category : #accessing }
ToListNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToListNodeHolder >> node: aNode [

	itemElement := aNode
]
