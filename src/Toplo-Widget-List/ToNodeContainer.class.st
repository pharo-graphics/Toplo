"
I'm abstract a triplet (start, middle, end) for list. 
I'm one of the children of the inner element of a list.
I hold a kind of `ToAbstractListNode` as my middle container.  
I refer to the nodeHolder (a kind of `ToNodeHolder`).
"
Class {
	#name : #ToNodeContainer,
	#superclass : #ToTripletContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToNodeContainer >> applyConfiguration [ 

	super applyConfiguration.
	self node applyConfiguration 
]

{ #category : #accessing }
ToNodeContainer >> holder: aNodeHolder [

	super holder: aNodeHolder.
	self createMiddleContainer 
]

{ #category : #accessing }
ToNodeContainer >> item [

	^ self node item
]

{ #category : #'t - triplet container - instance creation' }
ToNodeContainer >> newMiddleContainer [

	| node |
	node := self nodeManager newNodeForHolder: self holder.
	node holder: self holder.
	^ node
]

{ #category : #'t - triplet container - instance creation' }
ToNodeContainer >> newStartContainer [

	^ self newLinearContainer 
]

{ #category : #accessing }
ToNodeContainer >> node [

	^ self middleContainer 
]

{ #category : #accessing }
ToNodeContainer >> nodeManager [ 

	^ self holder listElement nodeManager
]
