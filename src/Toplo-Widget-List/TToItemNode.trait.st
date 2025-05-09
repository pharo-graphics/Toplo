Trait {
	#name : #TToItemNode,
	#instVars : [
		'itemContainer'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - item node' }
TToItemNode >> applyItemNodeConfiguration [

	| list |
	list := self holder listElement.
	list exactItemWidth ifNotNil: [ :w | self item width: w ].
	list exactItemHeight ifNotNil: [ :h | self item height: h ]
]

{ #category : #'t - item node' }
TToItemNode >> initializeAsItemNode [

	itemContainer := ToItemContainer new
		                 id: #itemContainer;
		                 yourself.
	itemContainer layout: BlLinearLayout horizontal.
	self addChild: itemContainer.
	self fitContent
]

{ #category : #'t - item node' }
TToItemNode >> item [

	^ itemContainer item
]

{ #category : #'t - item node' }
TToItemNode >> item: anElement [

	itemContainer item: anElement
]

{ #category : #'t - item node' }
TToItemNode >> itemContainer [ 

	^ itemContainer 
]

{ #category : #'t - item node' }
TToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
