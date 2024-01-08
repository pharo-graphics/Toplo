Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'data',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToNodeHolder >> data: aData [ 

	data := aData.
	infiniteElement nodeHolderBuilder value: self
]

{ #category : #accessing }
ToNodeHolder >> isSelected [

	^ self infiniteElement isSelectedAtIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]
