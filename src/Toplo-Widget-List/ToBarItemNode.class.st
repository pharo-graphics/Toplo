Class {
	#name : #ToBarItemNode,
	#superclass : #ToBarNode,
	#instVars : [
		'itemContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToBarItemNode >> applyWidgetConfiguration [

	| list |
	super applyWidgetConfiguration.
	list := self holder listElement.
	list exactItemWidth ifNotNil: [ :w | self item width: w ].
	list exactItemHeight ifNotNil: [ :h | self item height: h ]
]

{ #category : #initialization }
ToBarItemNode >> initialize [

	super initialize.
	itemContainer := ToItemContainer new
		                 id: #itemContainer;
		                 yourself.
	itemContainer layout: BlLinearLayout horizontal.
	self addChild: itemContainer.
	self fitContent
]

{ #category : #accessing }
ToBarItemNode >> item [

	^ itemContainer item
]

{ #category : #accessing }
ToBarItemNode >> item: anElement [

	itemContainer item: anElement
]

{ #category : #accessing }
ToBarItemNode >> itemContainer [ 

	^ itemContainer 
]

{ #category : #skin }
ToBarItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
