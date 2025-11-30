Class {
	#name : #ToBarNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToBarNode',
	#classTraits : 'TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToBarNode >> applyConfiguration [

	super applyConfiguration.
	self holder initializeNode
]

{ #category : #'t - list node' }
ToBarNode >> clickEventHandlerClass [

	^  ToListNodeSelectionEventHandler
]

{ #category : #initialization }
ToBarNode >> initialize [

	super initialize.
	self initializeAsBarNode 

]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
