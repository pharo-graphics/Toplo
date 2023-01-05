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
		'codePane'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToMiniBrowser class >> open [
	<script>
	self new open
]

{ #category : #initialization }
ToMiniBrowser >> changeCodeInEditor [

	| selected cls sel codeText |

	selected := selectors list at: selectors selectedIndexes anyOne.
	cls := selected key.
	sel := selected value.
	codeModel styler classOrMetaClass: cls.
	codeText := cls sourceCodeAt: sel.
	codeModel text: codeText copy
]

{ #category : #initialization }
ToMiniBrowser >> classSelectionChangedEvent: aToSelectionChanged [

	| selectedClasses allProtocols |
	protocols selectionStrategy clearSelection.
	protocols list removeAll.
	selectedClasses := aToSelectionChanged newSelectedIndexes collect: [ :idx | classes list at: idx ].
	allProtocols := Array streamContents: [ :stream | 
		                selectedClasses do: [ :cls | 
			                (cls organization allProtocols sort: [ :a :b | a name < b name ]) do: [ :prot | 
				                prot name = AllProtocol defaultName
					                ifTrue: [ 
						                | fake |
						                fake := Protocol new name:
							                        (String streamContents: [ :str | 
								                         str nextPutAll:
									                         AllProtocol defaultName.
								                         selectedClasses size > 1 ifTrue: [ 
									                         str nextPut: Character space.
									                         str nextPutAll: cls name ] ]).
						                fake addAllMethodsFrom: prot.
						                stream nextPut: cls -> fake ]
					                ifFalse: [ stream nextPut: cls -> prot ] ] ] ].

	protocols list addAll: allProtocols
]

{ #category : #initialization }
ToMiniBrowser >> clearCodeInEditor [

	codeModel styler classOrMetaClass: nil.
	codeModel text: ''

]

{ #category : #initialization }
ToMiniBrowser >> initialize [

	| codeMenu |
	super initialize.
	listsPane := ToHorizontalPane new margin: (BlInsets top: 5 bottom: 5).
	listsPane layout: (BlLinearLayout horizontal cellSpacing: 5).
	listsPane matchParent.
	mainPane := ToVerticalPane new.
	mainPane matchParent.

	packages := ToList new nodeFactory: [ :pkg | 
		            ToLabeledNode new
			            labelText: pkg name;
			            hMatchParent ].

	packages
		when: ToSelectionChanged
		do: [ :event | self packageSelectionChangedEvent: event ].
	packages list addAll:	(RPackage organizer packages asSortedCollection: [ :p1 :p2 | p1 name < p2 name ]).

	classes := ToList new nodeFactory: [ :cls | 
		           ToLabeledNode new
			           labelText: cls name;
			           hMatchParent ].
	classes
		when: ToSelectionChanged
		do: [ :event | self classSelectionChangedEvent: event ].
	classes list whenRemoveChangeDo: [ protocols list removeAll ].

	protocols := ToList new nodeFactory: [ :assoc | 
		             ToLabeledNode new
			             labelText: assoc value name;
			             hMatchParent ].

	protocols
		when: ToSelectionChanged
		do: [ :event | self protocolSelectionChangedEvent: event ].
	protocols list whenRemoveChangeDo: [ selectors list removeAll ].

	selectors := ToList new nodeFactory: [ :assoc | 
		             ToLabeledNode new
			             labelText: assoc value asString;
			             hMatchParent ].
	selectors
		when: ToSelectionChanged
		do: [ :event | self selectorSelectionChangedEvent: event ].
	selectors list whenRemoveChangeDo: [ self clearCodeInEditor ].

	codeModel := ToAlbumModel new withRowNumbers.
	codeModel styler: BlRBTextStyler new.
	codePane := codeModel onWidget margin: (BlInsets all: 5).
	
	codeMenu := ToContextMenu new globalLeftColumnWidth: 0.
	codeMenu addItem: (ToButtonMenuItem new labelText: 'Accept').
	codePane contextMenu: codeMenu.
	
	packages withRowNumbers.
	classes withRowNumbers.
	protocols withRowNumbers.
	selectors withRowNumbers.

	listsPane addChild: packages.
	listsPane addChild: classes.
	listsPane addChild: protocols.
	listsPane addChild: selectors.

	mainPane addChild: listsPane.
	mainPane addChild: codePane
]

{ #category : #'instance creation' }
ToMiniBrowser >> open [

	mainPane openInOBlSpace title: 'Mini browser'
]

{ #category : #initialization }
ToMiniBrowser >> packageSelectionChangedEvent: aToSelectionChanged [

	| selectedPackages clsList |
	classes selectionStrategy clearSelection.
	classes list removeAll.
	selectedPackages := aToSelectionChanged newSelectedIndexes collect: [ :idx | packages list at: idx ].
	clsList := Array streamContents: [:stream | selectedPackages do: [ :pkg | stream nextPutAll: pkg definedClasses ] ].
	clsList := clsList asSortedCollection: [ :a :b | a name < b name ].
	classes list addAll: clsList
]

{ #category : #initialization }
ToMiniBrowser >> protocolNodeFromClassProtocolAssoc: assoc [

	

	^ ToLabeledNode new
		  labelText: assoc value name;
		  hMatchParent
]

{ #category : #initialization }
ToMiniBrowser >> protocolSelectionChangedEvent: aToSelectionChanged [

	| selectedProtocols |
	selectors selectionStrategy clearSelection.
	selectors list removeAll.
	selectedProtocols := aToSelectionChanged newSelectedIndexes collect: [ :idx | protocols list at: idx ].
	selectedProtocols do: [ :assoc | selectors list addAll: ((assoc value methodSelectors) collect: [:sel | assoc key -> sel] ) ]
		

]

{ #category : #initialization }
ToMiniBrowser >> selectorSelectionChangedEvent: aToSelectionChanged [

	aToSelectionChanged newSelectedIndexes size = 1 ifTrue: [ ^ self changeCodeInEditor ].
	self clearCodeInEditor
]
