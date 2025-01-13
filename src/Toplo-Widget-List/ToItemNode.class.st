Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #accessing }
ToItemNode >> item [

	^ self firstChild
]

{ #category : #accessing }
ToItemNode >> item: aMenuItem [

	aMenuItem ifNil: [ ^ self ].
	aMenuItem parent = self ifTrue: [ ^ self ].
	aMenuItem removeFromParent.
	self addChild: aMenuItem at: 1
]

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
