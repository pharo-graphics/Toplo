Trait {
	#name : #TToItem,
	#instVars : [
		'parentItemContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item' }
TToItem >> itemBuilder: aBlock [

	self in: aBlock
]

{ #category : #'t - item' }
TToItem >> parentItemContainer [

	^ parentItemContainer
]

{ #category : #'t - item' }
TToItem >> parentItemContainer: anItemContainer [

	parentItemContainer := anItemContainer
]

{ #category : #'t - item' }
TToItem >> parentItemContainerDo: aBlock [

	parentItemContainer ifNil: [ ^ self ].
	aBlock value: parentItemContainer
]

{ #category : #'t - item' }
TToItem >> positionInItemContainer [

	self parentItemContainerDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
]
