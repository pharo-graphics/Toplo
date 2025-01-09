Class {
	#name : #ToCollapseListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #example }
ToCollapseListElement class >> example [
	<sampleInstance>
	
	| list |
	list := ToCollapseListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i | ToCollapseElement new  ]).
	list matchParent.
	list openInSpace
		
]

{ #category : #initialization }
ToCollapseListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToCollapseListElement >> defaultNodeManagerClass [
	"The object responsible to populate the list nodes."

	^ ToCollapseListNodeManager 
]
