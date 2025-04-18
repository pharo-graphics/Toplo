Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#instVars : [
		'item',
		'itemContainer'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemNode >> initialize [ 

	super initialize.
	itemContainer := ToElement new.
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

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
