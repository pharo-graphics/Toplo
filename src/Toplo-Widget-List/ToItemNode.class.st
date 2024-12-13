Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - bar node' }
ToItemNode >> autoDistribute: aBoolean [

	super autoDistribute: aBoolean.
	aBoolean ifTrue: [
		self item constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #accessing }
ToItemNode >> item [

	^ self firstChild
]

{ #category : #accessing }
ToItemNode >> item: aMenuItem [

	aMenuItem ifNil: [ ^ self ].
	aMenuItem parent = self ifTrue: [ ^ self ].
	aMenuItem removeFromParent.
	self addChild: aMenuItem
]

{ #category : #skin }
ToItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
