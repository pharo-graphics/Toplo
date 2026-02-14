Class {
	#name : #ToItemNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNodeContainer >> applyConfiguration [

	| list |
	super applyConfiguration.
	self item ifNil: [ ^ self ].
	list := self holder listElement.
	list isOrientable ifFalse: [ ^ self ].
	list toConfiguration isFlowable ifTrue: [ ^ self ].
	self isHExact ifFalse: [ self hFitElement: self item ].
	self isVExact ifFalse: [ self vFitElement: self item ]
]

{ #category : #accessing }
ToItemNodeContainer >> item [ 

	^ self node item
]
