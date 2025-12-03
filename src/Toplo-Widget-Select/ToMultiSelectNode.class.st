Class {
	#name : #ToMultiSelectNode,
	#superclass : #ToTagElement,
	#traits : 'TToListNode + TToFiniteListNode',
	#classTraits : 'TToListNode classTrait + TToFiniteListNode classTrait',
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #configuration }
ToMultiSelectNode >> applyConfiguration [

	super applyConfiguration.
	self holderDo: [ :h |
		h listElement autoDistribute ifTrue: [ self hMatchParent ] ]
]

{ #category : #initialization }
ToMultiSelectNode >> initialize [ 

	super initialize.
	self constraintsDo: [ :c | c linear vertical alignCenter ].

	self initializeAsBarNode 
]
