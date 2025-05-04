Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#instVars : [
		'itemContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNode >> applyWidgetConfiguration [

	| list |
	super applyWidgetConfiguration.
	list := self holder listElement.
	list exactItemWidth ifNotNil: [ :w | self item width: w ].
	list exactItemHeight ifNotNil: [ :h | self item height: h ]
]

{ #category : #initialization }
ToItemNode >> initialize [

	super initialize.
	itemContainer := ToItemContainer new
		                 id: #itemContainer;
		                 yourself.
	itemContainer layout: BlLinearLayout horizontal.
	self addChild: itemContainer.
	self fitContent
]

{ #category : #accessing }
ToItemNode >> item [

	^ itemContainer item
]

{ #category : #accessing }
ToItemNode >> item: anElement [

	itemContainer item: anElement
]

{ #category : #accessing }
ToItemNode >> itemContainer [ 

	^ itemContainer 
]

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
