"
I'm a special node container. My role is to ensure a given size when no element are added the list. 
I'm a sibling of the inner element of a list.  
"
Class {
	#name : #ToFiniteListFakeNodeContainer,
	#superclass : #ToFiniteListNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToFiniteListFakeNodeContainer >> applyConfiguration [
	"in case my orientation changes the original size must be stored.
	The original size has to be stored before setting the height or the width to zero.
	see also addFakeNode:"
	
	super applyConfiguration.

	self holder listElement isHorizontal
		ifTrue: [
				self width: 0 ]
		ifFalse: [
				self height: 0 ].
	
]

{ #category : #initialization }
ToFiniteListFakeNodeContainer >> initialize [

	super initialize.
	self visibility: BlVisibility hidden
]

{ #category : #testing }
ToFiniteListFakeNodeContainer >> isFake [

	^ true
]
