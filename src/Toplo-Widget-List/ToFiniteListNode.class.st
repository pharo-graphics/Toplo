"
I'm a node that contains the elements built from the datasource. See superclass comments.
In addition I'm in bar (a finite list by opposition to infinite). 
"
Class {
	#name : #ToFiniteListNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToFiniteListNode',
	#classTraits : 'TToFiniteListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToFiniteListNode >> applyConfiguration [

	super applyConfiguration.
	self holder initializeNode
]

{ #category : #'t - list node' }
ToFiniteListNode >> clickEventHandlerClass [

	^  ToListNodeSelectionEventHandler
]

{ #category : #initialization }
ToFiniteListNode >> initialize [

	super initialize.
	self matchParent.
	self addEventHandlerOn: ToRemoveButtonClickedEvent do: [ :event |
			| target listElement |
			" since the event is fired, on should stop it dispatching here "
			event consume.
			target := event currentTarget.
			listElement := target holder listElement.
			target removeFromBar.
			" Now the mouse move should be replayed because the mouse can be over the same remove button after the removal.
			It is postponed to let the node be re-built and configured before replaying "
			listElement postponeAction: [ :l | l requestMouseMoveReplay ] ]
]

{ #category : #skin }
ToFiniteListNode >> newRawSkin [ 

	^ ToFiniteListNodeSkin new
]
