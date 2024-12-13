Class {
	#name : #ToItemNode,
	#superclass : #ToBarNode,
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #'t - bar node' }
ToItemNode >> autoDistribute: aBoolean [

	super autoDistribute: aBoolean.
	aBoolean ifTrue: [
		self item constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #'as yet unclassified' }
ToItemNode >> item [

	^ self firstChild
]

{ #category : #'as yet unclassified' }
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
