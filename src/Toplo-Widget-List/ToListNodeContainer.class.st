Class {
	#name : #ToListNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToListNodeContainer >> applyConfiguration [

	| l |
	super applyConfiguration.
	l := self holder listElement.
	l isHorizontal
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].
	self vFitContent
]
