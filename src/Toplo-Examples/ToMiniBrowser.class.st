Class {
	#name : #ToMiniBrowser,
	#superclass : #Object,
	#instVars : [
		'listsPane',
		'mainPane',
		'packages',
		'classes',
		'protocols',
		'selectors',
		'codePane',
		'classSide',
		'selectedSelector'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToMiniBrowser class >> open [
	<script>
	self new open
]

{ #category : #'class selection' }
ToMiniBrowser >> candidateProtocolsForClass: aClass [

	| prots |
	prots := classSide
		         ifTrue: [
			         aClass organization allProtocols select: [ :p |
				         aClass isLocalMethodsProtocol: p ] ]
		         ifFalse: [ aClass organization allProtocols ].
	^ prots sort: [ :a :b | a name < b name ]
]

{ #category : #'code editor' }
ToMiniBrowser >> changeCodeInEditor [

	| selected cls sel codeText |
	selected := selectors data at:
		            selectors selectionStrategy selectedIndexes anyOne.
	selected = selectedSelector ifTrue: [ ^ self ].
	selectedSelector := selected.
	cls := selectedSelector key.
	sel := selectedSelector value.
	codePane styler classOrMetaClass: cls.
	codeText := cls sourceCodeAt: sel.
	codePane text: codeText copy
]

{ #category : #'class selection' }
ToMiniBrowser >> classSelectionChangedEvent: aToSelectionChanged [

	| selectedClasses allProtocols |
	protocols selectionStrategy deselectAll.
	protocols data removeAll.
	selectedClasses := aToSelectionChanged currentIndexes collect: [ :idx |
		                   classes data at: idx ].
	allProtocols := Array streamContents: [ :stream |
		                selectedClasses do: [ :cls |
			                | side prots |
			                side := classSide
				                        ifTrue: [ cls classSide ]
				                        ifFalse: [ cls instanceSide ].
			                prots := self candidateProtocolsForClass: side.
			                prots := self
				                         finalProtocolsFrom: prots
				                         forClass: side.
			                stream nextPutAll: prots ] ].

	selectedClasses size > 1 ifTrue: [
		allProtocols := self filteredProtocolsFrom: allProtocols ].
	protocols data addAll: allProtocols
]

{ #category : #accessing }
ToMiniBrowser >> classSide [

	^ classSide ifNil: [ classSide := false ]

]

{ #category : #'code editor' }
ToMiniBrowser >> clearCodeInEditor [

	codePane styler classOrMetaClass: nil.
	codePane text: ''

]

{ #category : #'class selection' }
ToMiniBrowser >> filteredProtocolsFrom: aListOfProtocols [

	^ aListOfProtocols collect: [ :assoc | 
		  | p |
		  p := assoc value.
		   assoc ]
]

{ #category : #'class selection' }
ToMiniBrowser >> finalProtocolsFrom: aListOfProtocols forClass: aClass [

	^ Array streamContents: [ :stream | 
		  aListOfProtocols do: [ :prot | 
			  stream nextPut: aClass -> prot ] ]
]

{ #category : #initialization }
ToMiniBrowser >> initialize [

	| classesPane packagesPane classesButtonPane sideToggle pkgFilterField pkgSieve packageBottomPane |
	super initialize.

	listsPane := ToPane new
		             id: #listPane;
		             margin: (BlInsets top: 0 bottom: 5).
	listsPane layout: (BlLinearLayout horizontal cellSpacing: 0).
	listsPane matchParent.

	mainPane := ToPane new beVertical.
	mainPane matchParent.

	packagesPane := ToPane new
		                id: #packagesPane;
		                beVertical;
		                matchParent.

	pkgFilterField := ToTextField new.
	pkgFilterField placeholderText:
		('Packages filter' asRopedText foreground: Color lightGray).
	packages := ToListElement new
		            id: #packages;
		            nodeBuilder: [ :node :holder |
			            node addChild: (ToLabel new
						             text: holder data name;
						             defaultRawSkin: ToLabelInListSkin new;
						             hMatchParent;
						             yourself) ].
	pkgSieve := ToListElementSieve new.
	pkgSieve onInstalledIn: packages.

	pkgSieve dataFilter: [ :aPackage :aPattern |
		aPackage name
			includesSubstring: aPattern asString
			caseSensitive: false ].

	pkgFilterField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [
				 | pattern |
				 pattern := pkgFilterField text asString.
				 pkgSieve pattern: pattern ]).
			
	packageBottomPane := ToPane new
		                     hMatchParent;
		                     vFitContent.
	packageBottomPane addChild: pkgFilterField;
			               margin: (BlInsets top: 5);
			               padding: (BlInsets all: 0).

	packages infinite addEventHandler: (BlEventHandler
			 on: ToStrongSelectionEvent
			 do: [ :event | event traceCr ]).

	packagesPane margin: (BlInsets all: 2).
	packagesPane addChild: packages.
	packagesPane addChild: packageBottomPane.

	packages addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | self packageSelectionChangedEvent: event ]).
	packages data addAll:
		(RPackage organizer packages asSortedCollection: [ :p1 :p2 |
			 p1 name < p2 name ]).

	classes := ToListElement new
		           id: #classes;
		           nodeBuilder: [ :node :holder |
			           node addChild: (ToClassNameViewExample new
						            class: holder data position: holder position;
						            yourself) ].

	classes infinite addEventHandler: (BlEventHandler
			 on: ToInfiniteSelectionChangedEvent
			 do: [ :event | self classSelectionChangedEvent: event ]).
	classes data whenRemoveChangeDo: [ protocols data removeAll ].
	classesPane := ToPane new
		               id: #classesPane;
		               beVertical;
		               matchParent.
	classesPane margin: (BlInsets all: 2).
	classesPane addChild: classes.
	classesButtonPane := ToPane new
		                     hMatchParent;
		                     vFitContent.
	classesButtonPane addChild: (sideToggle := ToCheckbox new
			               label: (ToLabel text: 'Class side');
			               margin: (BlInsets top: 5);
			               padding: (BlInsets all: 0)).
	classesPane addChild: classesButtonPane.

	sideToggle checked: self classSide.
	sideToggle addEventHandler: (BlEventHandler
			 on: ToCheckableCheckEvent
			 do: [ :event |
				 classes infinite dispatchSelectionChangedAfter: [
					 classSide := event current.
					 classes selectionStrategy deselectAll ] ]).

	protocols := ToListElement new
		             id: #protocols;
		             nodeBuilder: [ :node :holder |
			             node addChild: (ToLabel new
						              text: holder data value name;
						              defaultRawSkin: ToLabelInListSkin new;
						              hMatchParent) ].
	protocols margin: (BlInsets all: 2).

	protocols infinite addEventHandler: (BlEventHandler
			 on: ToInfiniteSelectionChangedEvent
			 do: [ :event | self protocolSelectionChangedEvent: event ]).
	protocols data whenRemoveChangeDo: [ selectors data removeAll ].

	selectors := ToListElement new
		             id: #selectors;
		             nodeBuilder: [ :node :holder |
			             node addChild: (ToLabel new
						              text: holder data value asString;
						              defaultRawSkin: ToLabelInListSkin new;
						              hMatchParent) ].

	selectors margin: (BlInsets all: 2).
	selectors infinite addEventHandler: (BlEventHandler
			 on: ToInfiniteSelectionChangedEvent
			 do: [ :event | self selectorSelectionChangedEvent: event ]).
	selectors data whenRemoveChangeDo: [ self clearCodeInEditor ].

	"selectors hasFixedSize: true."

	codePane := ToAlbum new withRowNumbers.
	codePane styler: BlRBTextStyler new.
	codePane margin: (BlInsets
			 top: 8
			 left: 3
			 bottom: 3
			 right: 3).

	codePane contextMenuBuilder: [ :codeMenu :element |
		codeMenu addItem: (ToMenuItem new labelText: 'Accept') ].

	packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers.

	listsPane addChild: packagesPane.
	listsPane addChild: classesPane.
	listsPane addChild: protocols.
	listsPane addChild: selectors.
	listsPane addDividers.

	mainPane addChild: listsPane.
	mainPane addChild: codePane.
	mainPane addDividers
]

{ #category : #opening }
ToMiniBrowser >> open [

	mainPane openInSpace title: 'Mini browser'
]

{ #category : #initialization }
ToMiniBrowser >> packageSelectionChangedEvent: aToSelectionChanged [

	| selectedPackages clsList |
	classes selectionStrategy deselectAll.
	classes data removeAll.
	selectedPackages := aToSelectionChanged currentIndexes collect: [
		                    :idx | packages data at: idx ].
	clsList := Array streamContents: [ :stream |
		           selectedPackages do: [ :pkg |
			           stream nextPutAll: pkg definedClasses ] ].
	clsList := clsList asSortedCollection: [ :a :b | a name < b name ].
	classes data addAll: clsList
]

{ #category : #initialization }
ToMiniBrowser >> protocolSelectionChangedEvent: aToSelectionChanged [

	| selectedProtocols |
	selectors selectionStrategy deselectAll.
	selectors data removeAll.
	selectedProtocols := aToSelectionChanged currentIndexes collect: [
		                     :idx | protocols data at: idx ].
	selectedProtocols do: [ :assoc |
		selectors data addAll:
			(assoc value methodSelectors asSortedCollection collect: [ :sel |
				 assoc key -> sel ]) ]
]

{ #category : #initialization }
ToMiniBrowser >> selectorSelectionChangedEvent: aToSelectionChanged [

	aToSelectionChanged currentIndexes size = 1 ifTrue: [
		^ self changeCodeInEditor ].
	self clearCodeInEditor
]
