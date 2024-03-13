Class {
	#name : #ToBasicNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToBasicNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToBasicNodeHolder >> data: aData [ 

	self
		deprecated: 'Use dataItem: instead'
		transformWith: '`@receiver data: `@arg' -> '`@receiver dataItem: `@arg'.

	self dataItem: aData
]

{ #category : #accessing }
ToBasicNodeHolder >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToBasicNodeHolder >> dataItem: aData [ 

	dataItem := aData.
	self node: (self listElement nodeFactory cull: self).
	self listElement nodeBuilder cull: self node cull: self
]

{ #category : #testing }
ToBasicNodeHolder >> isHidden [

	^ false
]

{ #category : #accessing }
ToBasicNodeHolder >> listElement [

	^ infiniteElement listElement
]

{ #category : #accessing }
ToBasicNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToBasicNodeHolder >> node: aNode [

	itemElement := aNode
]
