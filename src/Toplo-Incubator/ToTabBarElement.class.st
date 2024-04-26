Class {
	#name : #ToTabBarElement,
	#superclass : #ToPane,
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'tabs',
		'tabRow',
		'tabRowContainer',
		'startContainer',
		'endContainer',
		'vertical'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #'t - orientable - orientation' }
ToTabBarElement >> beHorizontal [

	super beHorizontal.
	self tabs beHorizontal
]

{ #category : #'t - orientable - orientation' }
ToTabBarElement >> beVertical [

	super beVertical.
	self tabs beVertical
]

{ #category : #'tabs selection' }
ToTabBarElement >> dataEmptinessChangeEvent: anEvent [

	self tabs selectionModel ifEmpty: [ self selectIndex: 1 ]
]

{ #category : #initialization }
ToTabBarElement >> defaultNodeBuilder [

	^ [ :tabNode :holder |
	  | lab |
	  lab := ToLabeledIcon new labelText: holder dataItem data asString.
	  tabNode addChild: lab.
	  tabNode constraintsDo: [ :c | c horizontal fitContent ] ]
]

{ #category : #accessing }
ToTabBarElement >> endContainer [

	^ endContainer
]

{ #category : #orientation }
ToTabBarElement >> horizontal [

	^ self vertical not
]

{ #category : #orientation }
ToTabBarElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToTabBarElement >> initialize [

	super initialize.
	tabRowContainer := ToPane new
		                   fitContent;
		                   yourself.
	tabs := ToListElement new
		        nodeBuilder: self defaultNodeBuilder;
		        yourself.
	tabs nodeFactory: [ ToTabNode new ].
	tabs matchParent.
	tabs infinite matchParent.
	tabRowContainer addChild: tabs.
	tabRowContainer matchParent.
	startContainer := ToPane new
		                  fitContent;
		                  yourself.
	endContainer := ToPane new
		                fitContent;
		                yourself.
	self addChild: startContainer.
	self addChild: tabRowContainer.
	self addChild: endContainer.
	tabs
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :evt | self tabsSelectionChangedEvent: evt ].
	tabs dataAccessor
		addEventHandlerOn: ToCollectionEmptinessEvent
		do: [ :evt | self dataEmptinessChangeEvent: evt ]
]

{ #category : #orientation }
ToTabBarElement >> orientationChanged [

	self vertical
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]

{ #category : #'tabs selection' }
ToTabBarElement >> selectIndex: anInteger [

	self tabs selecter selectIndex: anInteger
]

{ #category : #initialization }
ToTabBarElement >> sharedEvents [

	^ { ToListPrimarySelectionChangedEvent. }
]

{ #category : #accessing }
ToTabBarElement >> startContainer [

	^ startContainer
]

{ #category : #accessing }
ToTabBarElement >> tabRow [

	^ tabRow 
]

{ #category : #accessing }
ToTabBarElement >> tabRowContainer [

	^ tabRowContainer
]

{ #category : #accessing }
ToTabBarElement >> tabs [ 

	^ tabs
]

{ #category : #'tabs selection' }
ToTabBarElement >> tabsSelectionChangedEvent: anEvent [

	anEvent selectionModel selectedIndexes traceCr.
]

{ #category : #orientation }
ToTabBarElement >> vertical [

	^ vertical
]

{ #category : #orientation }
ToTabBarElement >> vertical: aBoolean [

	vertical = aBoolean ifTrue: [ ^ self ].
	vertical := aBoolean.
	self orientationChanged

]
