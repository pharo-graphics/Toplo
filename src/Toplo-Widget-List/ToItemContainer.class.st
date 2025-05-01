Class {
	#name : #ToItemContainer,
	#superclass : #ToElement,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToItemContainer >> item [

	^ item
]

{ #category : #accessing }
ToItemContainer >> item: anElement [

	item = anElement ifTrue: [ ^ self ].
	item ifNotNil: [ item removeFromParent ].
	item := anElement.
	item ifNil: [ ^ self ].
	item removeFromParent.
	self addChild: item at: 1.
	self requestNewSkin
]
