Class {
	#name : #ToNodeHolder2,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'data',
		'eventDispatcher',
		'selected'
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

{ #category : #initialization }
ToNodeHolder2 >> initialize [ 

	super initialize.
	selected := false
]

{ #category : #accessing }
ToNodeHolder2 >> isSelected [

	self flag: ' has to update selected when a node is added'.

	^ selected
]

{ #category : #accessing }
ToNodeHolder2 >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder2 >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToNodeHolder2 >> selected: aBoolean [

	selected := aBoolean
]
