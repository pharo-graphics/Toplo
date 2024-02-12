Class {
	#name : #ToNodeHolder2,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'listElement',
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder2 >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToNodeHolder2 >> data: aData [ 

	self
		deprecated: 'Use dataItem: instead'
		transformWith: '`@receiver data: `@arg' -> '`@receiver dataItem: `@arg'.

	self dataItem: aData
]

{ #category : #accessing }
ToNodeHolder2 >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToNodeHolder2 >> dataItem: aData [ 

	dataItem := aData.
	infiniteElement nodeHolderBuilder value: self
]

{ #category : #accessing }
ToNodeHolder2 >> isSelected [

	^ self infiniteElement selectionModel containsIndex: self position
]

{ #category : #accessing }
ToNodeHolder2 >> listElement [

	^ listElement
]

{ #category : #accessing }
ToNodeHolder2 >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToNodeHolder2 >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder2 >> node: aNode [

	itemElement := aNode
]
