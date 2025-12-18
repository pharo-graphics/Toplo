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
	"self applyResizerConfiguration."
	self holder initializeNodeSelections
]

{ #category : #configuration }
ToFiniteListNode >> applyResizerConfiguration [

	| container |
	container := self holder nodeContainer.
	container isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].
	container isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ]
]

{ #category : #initialization }
ToFiniteListNode >> initialize [

	super initialize.
	self initializeAsFiniteListNode 

]

{ #category : #skin }
ToFiniteListNode >> newRawSkin [ 

	^ ToFiniteListNodeSkin new
]
