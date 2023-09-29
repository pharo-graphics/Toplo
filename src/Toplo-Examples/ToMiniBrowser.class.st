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
		'codeModel',
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
		         ifTrue: [ aClass organization allProtocols select: [ :p | aClass isLocalMethodsProtocol: p ] ]
		         ifFalse: [ aClass organization allProtocols ].
	^ prots sort: [ :a :b | a name < b name ]
]

{ #category : #'code editor' }
ToMiniBrowser >> changeCodeInEditor [

	| selected cls sel codeText |
	selected := selectors data at: selectors primarySelectionIndexes anyOne.
	selected = selectedSelector ifTrue: [ ^ self ].
	selectedSelector := selected.
	cls := selectedSelector key.
	sel := selectedSelector value.
	codeModel styler classOrMetaClass: cls.
	codeText := cls sourceCodeAt: sel.
	codeModel text: codeText copy
]

{ #category : #'class selection' }
ToMiniBrowser >> classSelectionChangedEvent: aToSelectionChanged [

	| selectedClasses allProtocols |
	protocols deselectAll.
	protocols data removeAll.
	selectedClasses := aToSelectionChanged newSelectedIndexes collect: [
		                   :idx | classes data at: idx ].
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
	protocols data addAll: allProtocols.

]

{ #category : #accessing }
ToMiniBrowser >> classSide [

	^ classSide ifNil: [ classSide := false ]

]

{ #category : #'code editor' }
ToMiniBrowser >> clearCodeInEditor [

	codeModel styler classOrMetaClass: nil.
	codeModel text: ''

]

{ #category : #'class selection' }
ToMiniBrowser >> filteredProtocolsFrom: aListOfProtocols [

	^ aListOfProtocols collect: [ :assoc | 
		  | p |
		  p := assoc value.
		  p name = AllProtocol defaultName
			  ifTrue: [ 
				  | fake |
				  fake := Protocol new name: p name , ' ' , assoc key name.
				  fake addAllMethodsFrom: p.
				  assoc key -> fake ]
			  ifFalse: [ assoc ] ]
]

{ #category : #'class selection' }
ToMiniBrowser >> finalProtocolsFrom: aListOfProtocols forClass: aClass [

	^ Array streamContents: [ :stream | 
		  aListOfProtocols do: [ :prot | 
			  prot name = AllProtocol defaultName
				  ifTrue: [ 
					  | fake |
					  fake := Protocol new name: (String streamContents: [ :str | str nextPutAll: AllProtocol defaultName ]).
					  fake addAllMethodsFrom: prot.
					  stream nextPut: aClass -> fake ]
				  ifFalse: [ stream nextPut: aClass -> prot ] ] ]
]

{ #category : #initialization }
ToMiniBrowser >> initialize [

	| codeMenu classesPane classesButtonPane sideToggle |
	super initialize.
	
	listsPane := ToPane new id: #listPane; margin: (BlInsets top: 0 bottom: 5).
	listsPane layout: (BlLinearLayout horizontal cellSpacing: 0).
	listsPane matchParent.
	
	mainPane := ToPane new beVertical.
	mainPane matchParent.

	packages := ToListElement new 
		id: #packages;
		nodeFactory: [ :pkg | 
			ToLabeledNode new
				labelText: pkg name;
			 	hMatchParent;
				yourself].

	packages infinite when: ToListStrongSelectionEvent do: [ :event | event traceCr ].

	packages margin: (BlInsets all: 2).

	"packages hasFixedSize: true."
	"packages selectionStrategy beWithoutSelection."
	"packages selectionStrategy beSingleSelection."
	packages
		infinite when: ToInfiniteSelectionChangedEvent
		do: [ :event | self packageSelectionChangedEvent: event ].
	packages data addAll:
		(RPackage organizer packages asSortedCollection: [ :p1 :p2 |
			 p1 name < p2 name ]).

	classes := ToListElement new 
		id: #classes; 
		nodeFactory: ToClassToNodeConverterExample new.

	classes infinite
		when: ToInfiniteSelectionChangedEvent
		do: [ :event | self classSelectionChangedEvent: event ].
	classes data whenRemoveChangeDo: [ protocols data removeAll ].
	classesPane := ToPane new id: #classesPane; beVertical; matchParent.
	classesPane margin: (BlInsets all: 2).
	classesPane addChild: classes.
	classesButtonPane := ToPane new
		                     hMatchParent;
		                     vFitContent.
	classesButtonPane addChild: (sideToggle := ToToggleButton new
			               label: (ToLabel text: 'Class side');
			               beLabelFirst;
			               margin: (BlInsets top: 5);
			               padding: (BlInsets all: 0)).
	sideToggle layout cellSpacing: 5.
	classesPane addChild: classesButtonPane.

	sideToggle checked: self classSide.
	sideToggle when: ToCheckableCheckEvent do: [ :event |
		classes infinite dispatchSelectionChangedAfter: [ classSide := event current. classes deselectAll. ] ].

	protocols := ToListElement new id: #protocols; nodeFactory: [ :assoc |
		             ToLabeledNode new
			             labelText: assoc value name;
			             hMatchParent ].
	protocols margin: (BlInsets all: 2).

	protocols infinite
		when: ToInfiniteSelectionChangedEvent
		do: [ :event | self protocolSelectionChangedEvent: event ].
	protocols data whenRemoveChangeDo: [ selectors data removeAll ].

	selectors := ToListElement new id: #selectors; nodeFactory: [ :assoc |
		             ToLabeledNode new
			             labelText: assoc value asString;
			             hMatchParent ].
	
	selectors margin: (BlInsets all: 2).
	selectors
		infinite when: ToInfiniteSelectionChangedEvent
		do: [ :event | self selectorSelectionChangedEvent: event ].
	selectors data whenRemoveChangeDo: [ self clearCodeInEditor ].

	"selectors hasFixedSize: true."

	codeModel := ToAlbumModel new withRowNumbers.
	codeModel styler: BlRBTextStyler new.
	codePane := codeModel onWidget margin: (BlInsets top: 8 left: 3 bottom: 3 right: 3).

	codeMenu := ToContextMenu new columnWidth: 0.
	codeMenu addItem: (ToMenuItem new labelText: 'Accept').
	codePane contextMenuFactory: [ codeMenu ].

	"packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers."

	listsPane addChild: packages.
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
	classes deselectAll.
	classes data removeAll.
	selectedPackages := aToSelectionChanged newSelectedIndexes collect: [
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
	selectors deselectAll.
	selectors data removeAll.
	selectedProtocols := aToSelectionChanged newSelectedIndexes collect: [
		                     :idx | protocols data at: idx ].
	selectedProtocols do: [ :assoc |
		selectors data addAll:
			(assoc value methodSelectors asSortedCollection collect: [ :sel |
				 assoc key -> sel ]) ]
]

{ #category : #initialization }
ToMiniBrowser >> selectorSelectionChangedEvent: aToSelectionChanged [

	aToSelectionChanged newSelectedIndexes size = 1 ifTrue: [ ^ self changeCodeInEditor ].
	self clearCodeInEditor
]
