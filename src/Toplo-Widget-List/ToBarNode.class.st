Class {
	#name : #ToBarNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
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

{ #category : #'t - list node' }
ToBarNode >> isFake [

	^ self holder listElement fakeNode = self
]

{ #category : #skin }
ToBarNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
