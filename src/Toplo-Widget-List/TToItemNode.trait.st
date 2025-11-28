Trait {
	#name : #TToItemNode,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - item node' }
TToItemNode >> initializeAsItemNode [

	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent
]

{ #category : #'t - item node' }
TToItemNode >> item [

	^ item
]

{ #category : #'t - item node' }
TToItemNode >> item: anElement [

	item = anElement ifTrue: [ ^ self ].
	item ifNotNil: [ item removeFromParent ].
	item := anElement.
	item ifNil: [ ^ self ].
	item removeFromParent.
	self addChild: item at: 1.
	self requestNewSkin
]

{ #category : #'t - item node' }
TToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
