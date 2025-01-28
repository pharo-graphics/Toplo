Class {
	#name : #ToAccordionListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'Xp to trash' }
ToAccordionListElement class >> exampleBasicAccordion [

	<script>
	| list |
	list := ToAccordionListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToBasicAccordionElement new button addChild:
				 (ToLabel text: 'coucou ' , i asString) ]).
	list matchParent.
	list openInSpace
]

{ #category : #'Xp to trash' }
ToAccordionListElement class >> exampleCollapse [

	<script>
	| list |
	list := ToAccordionListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToAccordionXPElement new labelText: 'coucou ' , i asString ]).
	list matchParent.
	list openInSpace
]

{ #category : #example }
ToAccordionListElement class >> exampleSkinAccordion [

	<script>
	| list |
	list := self new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToAccordionElement new builder: [ :h | h addChild: (ToLabel text:'coucou ' , i asString) ]]).
	list matchParent.
	list openInSpace
]

{ #category : #'Xp to trash' }
ToAccordionListElement class >> exampleToAccordionXPElement [

	<script>
	| list |
	list := ToAccordionListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToAccordionXPElement new labelText: 'coucou ' , i asString ]).
	list matchParent.
	list openInSpace
]

{ #category : #initialization }
ToAccordionListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToAccordionListElement >> defaultNodeManagerClass [
	"The object responsible to populate the list nodes."

	^ ToAccordionListNodeManager 
]
