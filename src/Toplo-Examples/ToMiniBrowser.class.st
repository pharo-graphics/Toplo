Class {
	#name : #ToMiniBrowser,
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
ToMiniBrowser class >> open [
	<script>
	self new open
]

{ #category : #'code editor' }
ToMiniBrowser >> changeCodeInEditor [

	| selected cls sel codeText |
	selected := selectors dataAccessor at: selectors selectionModel firstIndex.
	selected = selectedSelector ifTrue: [ ^ self ].
	selectedSelector := selected.
	cls := selectedSelector key.
	sel := selectedSelector value.
	self flag: #todo. #BlPharoCodeStyler."	codePane styler classOrMetaClass: cls."
	codeText := cls sourceCodeAt: sel.
	codePane text: codeText copy
]

{ #category : #'class selection' }
ToMiniBrowser >> classSelectionChangedEvent: aToSelectionChanged [

	self refreshClassSelectionWithSelectedIndexes:
		aToSelectionChanged selectedIndexes
]

{ #category : #'code editor' }
ToMiniBrowser >> clearCodeInEditor [

	self flag: #todo. #BlPharoCodeStyler. "	codePane styler classOrMetaClass: nil."
	codePane text: ''

]

{ #category : #accessing }
ToMiniBrowser >> isClassSide [

	^ classSide ifNil: [ classSide := false ]

]

{ #category : #initialization }
ToMiniBrowser >> mainPane [

	| pane |
	pane := ToPane new beVertical.
	pane addChild: self newPackageToSelectorListPane.
	pane addChild: self newCodePane.
	pane matchParent.
	pane layout cellSpacing: 3.
	pane addDividers.
	^ pane
]

{ #category : #initialization }
ToMiniBrowser >> newClassPane [

	| classesPane classesButtonPane sideToggle |
	classes := ToListElement new
		           nodeFactory: [ ToClassNameViewExamplePart new ];
		           id: #classes;
		           nodeBuilder: [ :node :dataItem :holder |
			           node class: dataItem position: holder position ].

	classes addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self classSelectionChangedEvent: event ]).

	classesPane := ToPane new
		               id: #classesPane;
		               beVertical;
		               matchParent.
	classesPane addChild: classes.
	classesButtonPane := ToPane new
		                     hMatchParent;
		                     vFitContent.
	classesButtonPane addChild: (sideToggle := ToCheckbox new
			               label: (ToLabel text: 'Class side');
			               hMatchParent;
			               yourself).
	classesPane addChild: classesButtonPane.

	sideToggle checked: self isClassSide.
	sideToggle checkAction: [ :evt :target :value |
				 classSide := value.
				 self refreshClassSelectionWithSelectedIndexes:
					 classes selectionModel selectedIndexes ].
	^ classesPane
]

{ #category : #initialization }
ToMiniBrowser >> newCodePane [

	codePane := ToAlbum new.
	codePane withRowNumbers.

	self flag: #todo. #BlPharoCodeStyler. "	codePane styler: BlPharoCodeStyler new."

	codePane contextMenuBuilder: [ :codeMenu :element |
		codeMenu addItem: (ToMenuItem new labelText: 'Accept') ].

	^ codePane
]

{ #category : #initialization }
ToMiniBrowser >> newPackagePane [

	| packagesPane pkgFilterField pkgSieve packageBottomPane |
	packagesPane := ToPane new
		                id: #packagesPane;
		                beVertical;
		                matchParent.

	pkgFilterField := ToTextField new.
	pkgFilterField placeholderText:
		('Packages filter' asRopedText foreground: Color lightGray).

	packages := ToListElement new
		            id: #packages;
		            nodeBuilder: [ :node :dataItem :holder |
			            node addChild: (ToLabel new
						             text: dataItem name;
						             hMatchParent;
						             yourself) ].

	pkgSieve := ToListElementSieve new.
	pkgSieve onInstalledIn: packages.

	pkgSieve dataFilter: [ :aPackage :aPattern |
		aPackage name
			includesSubstring: aPattern asString
			caseSensitive: false ].

	pkgFilterField whenTextEditedDo: [
				 | pattern |
				 pattern := pkgFilterField text asString.
				 pkgSieve pattern: pattern ].

	packageBottomPane := ToPane new
		                     hMatchParent;
		                     vFitContent.
	packageBottomPane addChild: pkgFilterField.

	packages addEventHandler: (BlEventHandler
			 on: ToListStrongSelectionEvent
			 do: [ :event | event traceCr ]).

	packagesPane addChild: packages.
	packagesPane addChild: packageBottomPane.

	packages addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self packageSelectionChangedEvent: event ]).
	packages dataAccessor addAll:
		(self packageOrganizer packages
			asSortedCollection: [ :p1 :p2 | p1 name < p2 name ]).

	^ packagesPane
]

{ #category : #initialization }
ToMiniBrowser >> newPackageToSelectorListPane [

	| listsPane packagesPane classesPane |
	listsPane := ToPane new id: #listPane.
	listsPane matchParent.
	listsPane layout cellSpacing: 3.

	packagesPane := self newPackagePane.
	classesPane := self newClassPane.
	protocols := self newProtocolPane.
	selectors := self newSelectorPane.

	packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers.

	listsPane addChild: packagesPane.
	listsPane addChild: classesPane.
	listsPane addChild: protocols.
	listsPane addChild: selectors.
	listsPane addDividers.

	^ listsPane
]

{ #category : #initialization }
ToMiniBrowser >> newProtocolPane [

	protocols := ToListElement new
		             id: #protocols;
		             nodeBuilder: [ :node :dataItem :holder |
			             node addChild: (ToLabel new
						              text: dataItem value;
						              hMatchParent) ].

	protocols addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self protocolSelectionChangedEvent: event ]).
	^ protocols
]

{ #category : #initialization }
ToMiniBrowser >> newSelectorPane [

	selectors := ToListElement new
		             id: #selectors;
		             nodeBuilder: [ :node :dataItem :holder |
			             node addChild:
					             (ToLabel text: dataItem value asString)
						             hMatchParent ].

	selectors addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | self selectorSelectionChangedEvent: event ]).
	^ selectors
]

{ #category : #opening }
ToMiniBrowser >> open [

	self mainPane openInSpace title: 'Mini browser'
]

{ #category : #initialization }
ToMiniBrowser >> packageSelectionChangedEvent: aToSelectionChanged [

	| selectedPackages clsList |

	classes dataAccessor removeAll.
	selectedPackages := aToSelectionChanged selectedIndexes collect: [
		                    :idx | packages dataAccessor at: idx ].
	clsList := Array streamContents: [ :stream |
		           selectedPackages do: [ :pkg |
			           stream nextPutAll: pkg definedClasses ] ].
	clsList := clsList asSortedCollection: [ :a :b | a name < b name ].
	classes dataAccessor addAll: clsList
]

{ #category : #initialization }
ToMiniBrowser >> protocolSelectionChangedEvent: aToSelectionChanged [

	| selectedProtocols |
	selectors dataAccessor removeAll.
	selectedProtocols := aToSelectionChanged selectedIndexes collect: [
		                     :idx | protocols dataAccessor at: idx ].
	selectedProtocols do: [ :assoc |
		selectors dataAccessor addAll:
			(assoc value methodSelectors asSortedCollection collect: [ :sel |
				 assoc key -> sel ]) ]
]

{ #category : #'class selection' }
ToMiniBrowser >> refreshClassSelectionWithSelectedIndexes: aCollection [

	| selectedClasses allProtocols |
	protocols dataAccessor removeAll.

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
ToMiniBrowser >> selectorSelectionChangedEvent: aToSelectionChanged [

	aToSelectionChanged selectedIndexes size = 1 ifTrue: [
		^ self changeCodeInEditor ].
	self clearCodeInEditor
]
