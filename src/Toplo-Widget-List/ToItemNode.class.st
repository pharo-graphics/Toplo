Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#instVars : [
		'item',
		'itemContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNode >> applyWidgetConfiguration [

	| list |
	super applyWidgetConfiguration.
	list := self holder listElement.
	list exactItemWidth ifNotNil: [ :w | item width: w ].
	list exactItemHeight ifNotNil: [ :h | item height: h ]
]

{ #category : #initialization }
ToItemNode >> initialize [

	super initialize.
	itemContainer := ToElement new
		                 id: #itemContainer;
		                 yourself.
	itemContainer layout: BlLinearLayout horizontal.
	self addChild: itemContainer.
	self fitContent
]

{ #category : #accessing }
ToItemNode >> item [

	^ item
]

{ #category : #accessing }
ToItemNode >> item: anElement [

	item = anElement ifTrue: [ ^ self ].
	item ifNotNil: [ item removeFromParent ].
	item := anElement.
	item ifNil: [ ^ self ].
	item removeFromParent.
	itemContainer addChild: item at: 1
]

{ #category : #accessing }
ToItemNode >> itemContainer [ 

	^ itemContainer 
]

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
