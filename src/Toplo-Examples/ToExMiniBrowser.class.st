Class {
	#name : #ToExMiniBrowser,
	#superclass : #Object,
	#instVars : [
		'packages',
		'classes',
		'protocols',
		'selectors',
		'codePane',
		'classSide',
		'selectedSelector'
	],
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #'instance creation' }
ToExMiniBrowser class >> open [
	<script>
	self new open
]

{ #category : #'code editor' }
ToExMiniBrowser >> changeCodeInEditor [

	| selected cls sel codeText |
	selected := selectors dataAccessor at: selectors selectionModel firstIndex.
	selected = selectedSelector ifTrue: [ ^ self ].
	selectedSelector := selected.
	cls := selectedSelector key.
	sel := selectedSelector value.
	codePane styler classOrMetaClass: cls.
	codeText := cls sourceCodeAt: sel.
	codePane text: codeText copy
]

{ #category : #'class selection' }
ToExMiniBrowser >> classSelectionChangedEvent: aToSelectionChanged [

	self refreshClassSelectionWithSelectedIndexes:
		aToSelectionChanged selectedIndexes
]

{ #category : #'code editor' }
ToExMiniBrowser >> clearCodeInEditor [

	codePane styler classOrMetaClass: nil.
	codePane text: ''

]

{ #category : #initialization }
ToExMiniBrowser >> initialize [

	super initialize.
	
	classSide := false
]

{ #category : #initialization }
ToExMiniBrowser >> newClassPane [

	| classesPane classesButtonPane sideToggle |
	classes := ToListElement new.
	classes
		nodeFactory: [ ToClassNameViewExamplePart new ];
		id: #classes;
		nodeBuilder: [ :node :dataItem :holder |
			node class: dataItem position: holder position ].
	classes
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | self classSelectionChangedEvent: event ].

	classesPane := ToPane new
		               id: #classesPane;
		               beVertical;
		               matchParent;
		               yourself.
	classesPane addChild: classes.

	classesButtonPane := ToPane new
		                     hMatchParent;
		                     vFitContent;
		                     yourself.
	classesButtonPane addChild: (sideToggle := ToCheckbox new
			               label: (ToLabel text: 'Class side');
			               hMatchParent;
			               yourself).
	classesPane addChild: classesButtonPane.

	sideToggle checked: classSide.
	sideToggle checkAction: [ :evt :target :value |
			classSide := value.
			self refreshClassSelectionWithSelectedIndexes:
				classes selectionModel selectedIndexes ].

	^ classesPane
]

{ #category : #initialization }
ToExMiniBrowser >> newCodePane [

	codePane := ToAlbum new.
	codePane withRowNumbers.

	codePane styler: BlPharoCodeStyler new.

	codePane contextMenuBuilder: [ :codeMenu :element |
		codeMenu addItem: (ToMenuItem new labelText: 'Accept') ].

	^ codePane
]

{ #category : #initialization }
ToExMiniBrowser >> newMainPane [

	| pane |
	pane := ToPane new.
	pane beVertical.
	pane addChild: self newPackageToSelectorListPane.
	pane addChild: self newCodePane.
	pane matchParent.
	pane layout cellSpacing: 3.
	pane addDividers.
	^ pane
]

{ #category : #initialization }
ToExMiniBrowser >> newPackagePane [

	| packagesPane pkgFilterField pkgSieve packageBottomPane |
	packagesPane := ToPane new.
	packagesPane
		id: #packagesPane;
		beVertical;
		matchParent.

	pkgFilterField := ToTextField new.
	pkgFilterField placeholderText:
		('Packages filter' asRopedText foreground: Color lightGray).

	packages := ToListElement new.
	packages
		id: #packages;
		nodeBuilder: [ :node :dataItem :holder |
				node addChild: (ToLabel new
							 text: dataItem name;
							 hMatchParent;
							 yourself) ].
	packages
		addEventHandlerOn: ToListStrongSelectionEvent
		do: [ :event | event traceCr ].
	packages
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | self packageSelectionChangedEvent: event ].
	packages dataAccessor addAll:
		(self packageOrganizer packages asSortedCollection: [ :p1 :p2 |
			 p1 name < p2 name ]).



	pkgSieve := packages newSieve.
	pkgSieve onInstalledIn: packages.

	pkgSieve dataFilter: [ :aPackage :aPattern |
			aPackage name
				includesSubstring: aPattern asString
				caseSensitive: false ].

	pkgFilterField whenTextEditedDo: [
			| pattern |
			pattern := pkgFilterField text asString.
			pkgSieve pattern: pattern ].

	packageBottomPane := ToPane new.
	packageBottomPane
		hMatchParent;
		vFitContent.
	packageBottomPane addChild: pkgFilterField.

	packagesPane addChild: packages.
	packagesPane addChild: packageBottomPane.

	^ packagesPane
]

{ #category : #initialization }
ToExMiniBrowser >> newPackageToSelectorListPane [

	| listsPane packagesPane classesPane |
	listsPane := ToPane new.
	listsPane id: #listPane.
	listsPane matchParent.
	listsPane layout cellSpacing: 3.

	packagesPane := self newPackagePane.
	classesPane := self newClassPane.
	protocols := self newProtocolPane.
	selectors := self newSelectorPane.

"	packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers."

	listsPane addChild: packagesPane.
	listsPane addChild: classesPane.
	listsPane addChild: protocols.
	listsPane addChild: selectors.
	listsPane addDividers.

	^ listsPane
]

{ #category : #initialization }
ToExMiniBrowser >> newProtocolPane [

	^ ToListElement new
		  id: #protocols;
		  nodeBuilder: [ :node :dataItem :holder |
				  node addChild: (ToLabel new
							   text: dataItem value name;
							   hMatchParent;
							   yourself) ];
		  addEventHandlerOn: ToListPrimarySelectionChangedEvent
		  do: [ :event | self protocolSelectionChangedEvent: event ];
		  yourself
]

{ #category : #initialization }
ToExMiniBrowser >> newSelectorPane [

	^ ToListElement new
		  id: #selectors;
		  nodeBuilder: [ :node :dataItem :holder |
				  node addChild: (ToLabel new
							   text: dataItem value asString;
							   hMatchParent;
							   yourself) ];
		  addEventHandlerOn: ToListPrimarySelectionChangedEvent
		  do: [ :event | self selectorSelectionChangedEvent: event ];
		  yourself
]

{ #category : #opening }
ToExMiniBrowser >> open [

	self newMainPane openInSpace title: 'Mini browser'
]

{ #category : #initialization }
ToExMiniBrowser >> packageSelectionChangedEvent: aToSelectionChanged [

	| selectedPackages clsList |
	classes dataAccessor removeAll.
	protocols dataAccessor removeAll.
	selectors dataAccessor removeAll.
	self clearCodeInEditor.

	selectedPackages :=
		aToSelectionChanged selectedIndexes
			collect: [ :idx | packages dataAccessor at: idx ].

	clsList := Array streamContents: [ :stream |
		           selectedPackages do: [ :pkg |
			           stream nextPutAll: pkg definedClasses ] ].

	clsList sort: [ :a :b | a name < b name ].

	classes dataAccessor addAll: clsList
]

{ #category : #initialization }
ToExMiniBrowser >> protocolSelectionChangedEvent: aToSelectionChanged [

	| selectedProtocols |
	selectors dataAccessor removeAll.
	self clearCodeInEditor.

	selectedProtocols :=
		aToSelectionChanged selectedIndexes
			collect: [ :idx | protocols dataAccessor at: idx ].

	selectedProtocols do: [ :assoc |
		selectors dataAccessor addAll:
			(assoc value methodSelectors asSortedCollection collect: [ :sel |
				 assoc key -> sel ]) ]
]

{ #category : #'class selection' }
ToExMiniBrowser >> refreshClassSelectionWithSelectedIndexes: aCollection [

	| selectedClasses allProtocols |
	protocols dataAccessor removeAll.
	selectors dataAccessor removeAll.
	self clearCodeInEditor.

	selectedClasses :=
		aCollection collect: [ :idx |
			classes dataAccessor at: idx ].

	allProtocols :=
		Array streamContents: [ :stream |
			selectedClasses do: [ :cls |
				cls protocols do: [ :each | stream nextPut: cls -> each ] ] ].

	allProtocols sort: [ :a :b | a name < b name ].

	protocols dataAccessor addAll: allProtocols
]

{ #category : #initialization }
ToExMiniBrowser >> selectorSelectionChangedEvent: aToSelectionChanged [

	aToSelectionChanged selectedIndexes size = 1 ifTrue: [
		^ self changeCodeInEditor ].
	self clearCodeInEditor
]
