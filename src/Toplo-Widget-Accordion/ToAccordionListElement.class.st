Class {
	#name : #ToAccordionListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #examples }
ToAccordionListElement class >> example1 [

	<script>
	| list |
	list := ToAccordionListElement new.
	"list group withoutCheckingStrategy."
	list addAllItems: ((1 to: 1000) collect: [ :i |
			 ToAccordionItemElement new
				 headerBuilder: [ :header |
					 header addChild: (ToLabel text: 'Header ' , i asString) ];
				 bodyBuilder: [ :body |
					 body addChild: (BlElement new
								  margin: (BlInsets all: 5);
								  border: Color random;
								  background: Color random;
								  size: 50 @ 50) ];
				 yourself ]).
	list matchParent.
	list openInSpace
]

{ #category : #examples }
ToAccordionListElement class >> example2WithAlbumInBody [

	<script>
	| list rand |
	rand := Random new.
	list := ToAccordionListElement new.
	list addAllItems: ((1 to: 500) collect: [ :i |
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
	list matchParent.
	list openInSpace
]

{ #category : #examples }
ToAccordionListElement class >> example2WithClassComments [

	<script>
	| list pane filterField sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	filterField margin: (BlInsets all: 2).
	filterField placeholderBuilder: [ :placeholder :e |
		placeholder addChild:
			((ToAttributedLabel text: 'Class name filter')
				 foreground: Color lightGray;
				 yourself) ].
	list := ToAccordionListElement new.
	list withRowNumbers.

	sieve := ToListElementSieve new.
	sieve onInstalledIn: list.
	sieve dataFilter: [ :item :aPattern |
		(item userData at: #class) name
			beginsWith: aPattern
			caseSensitive: false ].

	filterField whenTextEditedDo: [
		| pattern |
		pattern := filterField text asString.
		sieve pattern: pattern ].

	list placeholderBuilder: [ :ph :e |
		| lab |
		ph layout alignCenter.
		lab := (ToAttributedLabel text: 'No Data')
			       foreground: Color lightGray;
			       fontSize: 24;
			       yourself.
		ph addChild: lab ].

	"list group withoutCheckingStrategy."
	list addAllItems:
		((Smalltalk globals allClasses reject: [ :cls | cls comment isEmpty ])
			 collect: [ :cls |
				 ToAccordionItemElement new
					 in: [ :item | item userData at: #class put: cls ];
					 headerBuilder: [ :header |
						 header addChild: (ToLabel text: cls name) ];
					 bodyBuilder: [ :body |
						 | album |
						 body margin: (BlInsets all: 5).
						 album := ToAlbum new
							          withSaveCapability;
							          whenSaveRequestedDo: [ :saveRequested |
								          saveRequested accepted: true ];
							          whenCancelRequestedDo: [ :cancelRequested |
								          cancelRequested editorElement text: cls comment ];
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
						 album text: cls comment.
						 body addChild: album ];
					 yourself ]).
	list matchParent.

	pane addChild: list.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #examples }
ToAccordionListElement class >> example2WithClassComments2 [

	<script>
	| list pane filterField sieve |
	pane := ToPane new
		        beVertical;
		        matchParent.
	filterField := ToTextField new.
	filterField margin: (BlInsets all: 2).
	filterField placeholderBuilder: [ :placeholder :e |
		placeholder addChild:
			((ToAttributedLabel text: 'Class name filter')
				 foreground: Color lightGray;
				 yourself) ].
	list := ToListElement new.
	list selectionOption withEmbeddedRepresentation.
	list withRowNumbers.

	sieve := ToListElementSieve new.
	sieve onInstalledIn: list.
	sieve dataFilter: [ :item :aPattern |
		item name beginsWith: aPattern caseSensitive: false ].

	filterField whenTextEditedDo: [
		| pattern |
		pattern := filterField text asString.
		sieve pattern: pattern ].

	list placeholderBuilder: [ :ph :e |
		| lab |
		ph layout alignCenter.
		lab := (ToAttributedLabel text: 'No Data')
			       foreground: Color lightGray;
			       fontSize: 24;
			       yourself.
		ph addChild: lab ].

	list nodeBuilder: [ :node :cls :holder |
		| item |
		item := ToAccordionItemElement new
			        headerBuilder: [ :header |
				        header addChild: (ToLabel text: cls name) preventSelectionSkinEvents ];
			        bodyBuilder: [ :body |
				        | album |
				        body margin: (BlInsets all: 5).
				        album := ToAlbum new
					                 withSaveCapability;
					                 whenSaveRequestedDo: [ :saveRequested |
						                 saveRequested accepted: true ];
					                 whenCancelRequestedDo: [ :cancelRequested |
						                 cancelRequested editorElement text: cls comment ];
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
				        album text: cls comment.
				        body addChild: album ];
			        yourself.
		node hMatchParent.
		node vFitContent.
		(holder listElement selectionModel containsIndex: holder position)
			ifTrue: [ item checked: true ].
		item addEventHandlerOn: ToAccordionItemCheckedEvent do: [ :event |
			item isExpanded
				ifTrue: [
				holder listElement selecter selectIndex: holder position ]
				ifFalse: [
				holder listElement selecter deselectIndex: holder position ] ].
		node addChild: item ].

	list dataAccessor addAll: Smalltalk globals allClasses. "reject: [ :cls | cls comment isEmpty ]"
	"list selectionOption masked: true."
	list matchParent.

	pane addChild: list.
	pane addChild: filterField.
	pane openInSpace
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
