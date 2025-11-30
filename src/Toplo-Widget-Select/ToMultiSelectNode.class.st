Class {
	#name : #ToMultiSelectNode,
	#superclass : #ToTagElement,
	#traits : 'TToListNode + TToBarNode',
	#classTraits : 'TToListNode classTrait + TToBarNode classTrait',
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectNode >> initialize [ 

	super initialize.
	self constraintsDo: [ :c | c linear vertical alignCenter ].

	self initializeAsBarNode 
]
