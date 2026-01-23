Class {
	#name : #ToItemNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNodeContainer >> applyConfiguration [

	| list |
	super applyConfiguration.
	self node item ifNil: [ ^ self ].
	list := self holder listElement.
	list toConfiguration isFlowable ifTrue: [ ^ self ].
	self isHExact ifFalse: [ self hFitElement: self node item ].
	self isVExact ifFalse: [ self vFitElement: self node item ]
]
