Class {
	#name : #ToAccordionListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-Accordion-Core'
}

{ #category : #'Xp to trash' }
ToAccordionListElement class >> example1 [

	<script>
	| list |
	list := ToAccordionListElement new.
	list dataAccessor addAll: ((1 to: 5) collect: [ :i |
			 ToAccordionElement new
				 headerBuilder: [ :header |
					 header addChild: (ToLabel text: 'Header ' , i asString) ];
				 bodyBuilder: [ :body |
					 body background: Color white.
					 body addChild: (BlElement new
								  margin: (BlInsets all: 5);
								  border: Color random;
								  background: Color random;
								  size: 50 @ 50) ] ]).
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
