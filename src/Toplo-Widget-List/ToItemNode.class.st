Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

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
	self addChild: item at: 1
]

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
