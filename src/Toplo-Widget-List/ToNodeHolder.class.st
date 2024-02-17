Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'listElement',
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToNodeHolder >> data: aData [ 

	self
		deprecated: 'Use dataItem: instead'
		transformWith: '`@receiver data: `@arg' -> '`@receiver dataItem: `@arg'.

	self dataItem: aData
]

{ #category : #accessing }
ToNodeHolder >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToNodeHolder >> dataItem: aData [ 

	dataItem := aData.
	infiniteElement nodeHolderBuilder value: self
]

{ #category : #accessing }
ToNodeHolder >> isSelected [


	^ self listElement ifNil: [false] ifNotNil: [:le | le selectionModel containsIndex: self position]
]

{ #category : #accessing }
ToNodeHolder >> listElement [

	^ listElement
]

{ #category : #accessing }
ToNodeHolder >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]
