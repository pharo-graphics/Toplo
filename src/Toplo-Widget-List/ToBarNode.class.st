Class {
	#name : #ToBarNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToElement + TToBarNode',
	#classTraits : 'TToElement classTrait + TToBarNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
ToBarNode >> clickEventHandlerClasses [

	^  { ToListNodeMultiSelectionClickEventHandler } 
]

{ #category : #initialization }
ToBarNode >> initialize [ 

	super initialize.
	self initializeForToplo 
]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
