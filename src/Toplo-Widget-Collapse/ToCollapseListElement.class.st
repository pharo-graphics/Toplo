Class {
	#name : #ToCollapseListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-Collapse'
}

{ #category : #example }
ToCollapseListElement class >> example [

	<script>
	| list |
	list := ToCollapseListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToCollapseElement new labelText: 'coucou ' , i asString ]).
	list matchParent.
	list openInSpace
]

{ #category : #example }
ToCollapseListElement class >> exampleBasicCollapse [

	<script>
	| list |
	list := ToCollapseListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToBasicCollapseElement new button addChild:
				 (ToLabel text: 'coucou ' , i asString) ]).
	list matchParent.
	list openInSpace
]

{ #category : #example }
ToCollapseListElement class >> exampleCollapse [

	<script>
	| list |
	list := ToCollapseListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToCollapseElement new labelText: 'coucou ' , i asString ]).
	list matchParent.
	list openInSpace
]

{ #category : #example }
ToCollapseListElement class >> exampleWorkingSkinCollapse [

	<script>
	| list |
	list := ToCollapseListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToWorkingCollapseElement new builder: [ :h | h addChild: (ToLabel text:'coucou ' , i asString) ]]).
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
