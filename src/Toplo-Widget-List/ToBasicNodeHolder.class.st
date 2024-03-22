Class {
	#name : #ToBasicNodeHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToBasicNodeHolder >> bindDataItem: aData [ 

	self listElement nodeHolderBuilder value: self value: aData.
	self node: (self listElement nodeFactory cull: self).
	self listElement nodeBuilder cull: self node cull: self
]

{ #category : #accessing }
ToBasicNodeHolder >> data [


	self
		deprecated: 'Use dataItem instead'
		transformWith: '`@receiver data' -> '`@receiver dataItem'.

	^ self dataItem
]

{ #category : #accessing }
ToBasicNodeHolder >> dataItem [

	^ dataItem
]

{ #category : #accessing }
ToBasicNodeHolder >> dataItem: aData [ 

	dataItem := aData
]

{ #category : #testing }
ToBasicNodeHolder >> isSelected [

	^ self listElement
		  ifNil: [ false ]
		  ifNotNil: [ :le | le selectionModel containsIndex: self position ]
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

{ #category : #accessing }
ToBasicNodeHolder >> unbindDataItem [

	self listElement nodeReleaser cull: self node cull: self.
	self listElement nodeHolderReleaser value: self
]
