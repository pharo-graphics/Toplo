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
	list itemBuilder: [ :item :anInteger :holder |
		item
			headerBuilder: [ :header |
				header addChild: (ToLabel text: 'Header ' , anInteger asString)
							preventSelectionSkinEvents ];
			bodyBuilder: [ :body |
				body addChild: (BlElement new
							 margin: (BlInsets all: 5);
							 border: Color random;
							 background: Color random;
							 size: 50 @ 50) ] ].
	list dataAccessor addAll: (1 to: 1000).
	list matchParent.
	list openInSpace
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
		item addEventHandlerOn: ToAccordionCheckedEvent do: [ :event |
			item isExpanded
				ifTrue: [
				holder listElement selecter selectIndex: holder position ]
				ifFalse: [
				holder listElement selecter deselectIndex: holder position ] ].
		node addChild: item ].

	list dataAccessor addAll: Smalltalk globals allClasses.
	list selectionOption masked: true.
	list matchParent.

	pane addChild: list.
	pane addChild: filterField.
	pane openInSpace
]

{ #category : #examples }
ToAccordionListElement class >> example2WithClassComments3 [

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
	list selectionMode multiple: false.
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

	list itemBuilder: [ :item :cls :holder |
		item
			headerBuilder: [ :header |
				header addChild:
						(ToLabel text: cls name) preventSelectionSkinEvents ];
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
			yourself ].

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

{ #category : #initialization }
ToAccordionListElement >> initialize [ 

	super initialize.
	self selectionOption withEmbeddedRepresentation.
]

{ #category : #initialization }
ToAccordionListElement >> itemBuilder: aValuable [
	" aValuable has 3 arguments: the ccordionElement (the item), the data and the holder "

	self nodeManager itemBuilder: aValuable
]

{ #category : #initialization }
ToAccordionListElement >> itemFactory: aValuable [
	" aValuable has the node as argument"

	self nodeManager itemFactory: aValuable
]
