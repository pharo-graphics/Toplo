Trait {
	#name : #TToListItemNode,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - item node' }
TToListItemNode >> initializeAsItemNode [

	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent
]

{ #category : #'t - item node' }
TToListItemNode >> item [

	^ item
]

{ #category : #'t - item node' }
TToListItemNode >> item: anElement [
	" bind or re-bind an item element"

	item = anElement ifTrue: [ ^ self ].
	item ifNotNil: [ item removeFromParent ].
	item := anElement.
	item ifNil: [ ^ self ].
	" in case of a rebinding, the argument is already a child of a node "
	item removeFromParent.
	self addChild: item at: 1.
	self requestNewSkin
]

{ #category : #'t - item node' }
TToListItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
