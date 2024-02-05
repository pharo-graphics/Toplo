Class {
	#name : #ToNodeHolder2,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder2 >> data [

	^ data
]

{ #category : #accessing }
ToNodeHolder2 >> data: aData [ 

	data := aData.
	infiniteElement nodeHolderBuilder value: self
]

{ #category : #accessing }
ToNodeHolder2 >> isSelected [

	^ self infiniteElement selectionModel containsIndex: self position
]

{ #category : #accessing }
ToNodeHolder2 >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder2 >> node: aNode [

	itemElement := aNode
]
