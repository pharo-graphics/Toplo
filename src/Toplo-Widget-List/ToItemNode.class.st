Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToItemNode >> item [

	^ self firstChild
]

{ #category : #accessing }
ToItemNode >> item: anItemElement [

	anItemElement ifNil: [ ^ self ].
	anItemElement parent = self ifTrue: [ ^ self ].
	anItemElement removeFromParent.
	self addChild: anItemElement at: 1.
	anItemElement nodeHolder: self holder
]

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
