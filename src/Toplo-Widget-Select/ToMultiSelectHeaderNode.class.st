Class {
	#name : #ToMultiSelectHeaderNode,
	#superclass : #ToTagElement,
	#traits : 'TToListNode',
	#classTraits : 'TToListNode classTrait',
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectHeaderNode >> initialize [ 

	super initialize.
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self initializeAsListNode 
]

{ #category : #skin }
ToMultiSelectHeaderNode >> newRawSkin [ 

	^ ToMultiSelectHeaderNodeSkin new
]
