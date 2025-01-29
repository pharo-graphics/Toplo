"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes
"
Class {
	#name : #ToTreeElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleClassNames [ 

	<script>
	| l |
	l := self new.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).
	
	l openInSpace.
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [

	^ ToGenericTreeNodeManager  
]
