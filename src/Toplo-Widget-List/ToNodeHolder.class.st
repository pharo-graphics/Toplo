Class {
	#name : #ToNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
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

	^ self infiniteElement selectionStrategy includes: self position
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]
