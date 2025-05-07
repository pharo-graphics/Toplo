Trait {
	#name : #TToItemNode,
	#instVars : [
		'itemContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

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
