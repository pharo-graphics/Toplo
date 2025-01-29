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
			 ToAccordionItemElement new
				 headerBuilder: [ :header |
					 header addChild: (ToLabel text: 'Header ' , i asString) ];
				 bodyBuilder: [ :body |
					 body addChild: (BlElement new
								  margin: (BlInsets all: 5);
								  border: Color random;
								  background: Color random;
								  size: 50 @ 50) ] ]).
	list matchParent.
	list openInSpace
]

{ #category : #'Xp to trash' }
ToAccordionListElement class >> example2WithAlbumInBody [

	<script>
	| list rand |
	rand := Random new.
	list := ToListElement new.
	list dataAccessor addAll: ((1 to: 500) collect: [ :i |
			 String loremIpsum: (rand nextIntegerBetween: 100 and: 600) ]).
	list nodeBuilder: [ :node :loremString :holder |
		| accordeon |
		accordeon := ToAccordionItemElement new
			             headerBuilder: [ :header |
				             header addChild:
						             (ToLabel text: 'Lorem ' , holder position asString) ];
			             bodyBuilder: [ :body |
				             | album |
				             album := ToAlbum new
					                      withSaveCapability;
					                      whenSaveRequestedDo: [ :saveRequested |
						                      saveRequested accepted: true ];
					                      whenCancelRequestedDo: [ :cancelRequested |
						                      cancelRequested editorElement text:
								                      loremString ];
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
			             yourself.
		node addChild: accordeon ].
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
