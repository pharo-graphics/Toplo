"
I'm a node that contains the elements built from the datasource. 
The listNodeManager has the responsibility to build myself with the datasource data.

I'm contained in a container whose responsibility is to control the way the node is presented. 
- nothing in simple list, 
- indicator '>' for a tree
- a checkbox for a checkable row. 
 
We have two types of list with or without infinite. This difference is reflected in their children. 
The element children of an infinite list are `ToListNode`, the other are `ToBarNode`.


"
Class {
	#name : #ToBasicListNode,
	#superclass : #ToElement,
	#traits : 'TToListNode',
	#classTraits : 'TToListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToBasicListNode >> applyConfiguration [

	super applyConfiguration.
	self listElement toConfiguration configureNode: self.
	self holder initializeNodeSelections
]

{ #category : #'t - list node' }
ToBasicListNode >> clickEventHandlerClass [

	^  ToListNodeSelectionEventHandler
]

{ #category : #initialization }
ToBasicListNode >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout new
]

{ #category : #initialization }
ToBasicListNode >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self initializeAsListNode 
]

{ #category : #accessing }
ToBasicListNode >> listElement [ 

	^ self holder listElement
]

{ #category : #skin }
ToBasicListNode >> newRawSkin [ 

	^ ToBasicListNodeSkin new
]

{ #category : #accessing }
ToBasicListNode >> nodeManager [ 

	^ self listElement nodeManager
]
