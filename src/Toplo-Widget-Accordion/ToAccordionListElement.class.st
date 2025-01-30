Class {
	#name : #ToAccordionListElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #examples }
ToAccordionListElement class >> example1 [

	<script>
	| list |
	list := ToAccordionListElement new.
	list dataAccessor addAll: ((1 to: 50) collect: [ :i |
			 ToAccordionItemElement new
				 headerBuilder: [ :header |
					 header addChild: (ToLabel text: 'Header ' , i asString) ];
				 bodyBuilder: [ :body |
					 body addChild: (BlElement new
								  margin: (BlInsets all: 5);
								  border: Color random;
								  background: Color random;
								  size: 50 @ 50) ];
							expand ]).
	list nodeBuilder: [ :node :accordionElement :holder | node addChild: accordionElement ].
	list matchParent.
	list openInSpace.
	"list inspect"
]

{ #category : #examples }
ToAccordionListElement class >> example2WithAlbumInBody [

	<script>
	| list rand |
	rand := Random new.
	list := ToAccordionListElement new.
	list dataAccessor addAll: ((1 to: 500) collect: [ :i |
			 | loremString |
			 loremString := String loremIpsum:
				                (rand nextIntegerBetween: 100 and: 600).
			 ToAccordionItemElement new
				 headerBuilder: [ :header |
					 header addChild: (ToLabel text: 'Lorem ' , i asString) ];
				 bodyBuilder: [ :body |
					 | album |
					body margin: (BlInsets all: 5).
					 album := ToAlbum new
						          withSaveCapability;
						          whenSaveRequestedDo: [ :saveRequested |
							          saveRequested accepted: true ];
						          whenCancelRequestedDo: [ :cancelRequested |
							          cancelRequested editorElement text: loremString ];
						          yourself.
					 album hMatchParent.
					 album vFitContent.
					 album next constraintsDo: [ :c |
						 c vertical fitContent.
						 c horizontal matchParent ].
					 album infinite constraintsDo: [ :c |
						 c vertical fitContent.
						 c horizontal matchParent ].
					 album minHeight: 50.
					 album text: loremString.
					 body addChild: album ];
				 yourself ]).
	list nodeBuilder: [ :node :accordion :holder |
		node addChild: accordion ].
	list matchParent.
	list openInSpace
]

{ #category : #initialization }
ToAccordionListElement >> defaultEventHandler [

	^ ToAccordionListElementEventHandler new
]

{ #category : #initialization }
ToAccordionListElement >> defaultNodeManagerClass [
	"The object responsible to populate the list nodes."

	^ ToAccordionListNodeManager 
]

{ #category : #initialization }
ToAccordionListElement >> initialize [ 

	super initialize.
	self primarySelectionMode selectOnPressed: true.
	self primarySelectionMode deselectOnPressed: true.
	self primarySelectionMode makeDisabledUnselectable: true

]
