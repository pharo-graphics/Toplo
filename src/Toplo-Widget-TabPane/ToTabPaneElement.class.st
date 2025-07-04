Class {
	#name : #ToTabPaneElement,
	#superclass : #ToPane,
	#traits : 'TToItemBarContainer + TToItemBarOwner',
	#classTraits : 'TToItemBarContainer classTrait + TToItemBarOwner classTrait',
	#instVars : [
		'tabGroup',
		'bodyContainer',
		'headerContainer'
	],
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #configuration }
ToTabPaneElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.

	tabGroup horizontal: self isHorizontal not.
	self atStartSide
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ].
	self isHorizontal
		ifTrue: [
			self header
				beVertical;
				vMatchParent;
				hFitContent.
			tabGroup
				vMatchParent;
				hFitContent ]
		ifFalse: [
			self header
				beHorizontal;
				hMatchParent;
				vFitContent.
			tabGroup
				hMatchParent;
				vFitContent ]
]

{ #category : #accessing }
ToTabPaneElement >> atStartSide [

	^ tabGroup atStartSide
]

{ #category : #accessing }
ToTabPaneElement >> atStartSide: aBoolean [

	tabGroup atStartSide: aBoolean.
	self requestNewConfiguration 
]

{ #category : #accessing }
ToTabPaneElement >> body [ 

	^ bodyContainer 
]

{ #category : #initialization }
ToTabPaneElement >> defaultEventHandler [ 

	^ ToTabPaneEventHandler new
]

{ #category : #accessing }
ToTabPaneElement >> header [ 

	^ headerContainer 
]

{ #category : #initialization }
ToTabPaneElement >> initialize [

	super initialize.
	headerContainer := ToPane new
		                 id: #header;
		                 yourself.
	bodyContainer := ToPane new
		                 id: #body;
		                 yourself.
	bodyContainer matchParent.
	tabGroup := self newTabGroupElement.
	self setItemBar: tabGroup itemBar.
	headerContainer addChild: tabGroup.
	self addChildren: {
			headerContainer.
			bodyContainer }.
	self addEventHandler: self defaultEventHandler
]

{ #category : #initialization }
ToTabPaneElement >> newTabGroupElement [

	| tg |
	tg := ToTabPaneGroupElement new.
	tg matchParent.
	^ tg

]

{ #category : #accessing }
ToTabPaneElement >> preservePane [
	self deprecated: 'Use ToTabButton>>#paneDestroyer: to set a destroyer to a particular button'.

	^ false
]

{ #category : #accessing }
ToTabPaneElement >> showAddTabItemButton [

	^ tabGroup showAddTabItemButton
]

{ #category : #accessing }
ToTabPaneElement >> showAddTabItemButton: aBoolean [

	tabGroup showAddTabItemButton: aBoolean
]

{ #category : #accessing }
ToTabPaneElement >> tabGroup [ 

	^ tabGroup 
]

{ #category : #'t - checkable group owner' }
ToTabPaneElement >> withStrictCheckingStrategy [ 

	tabGroup withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabPaneElement >> withWeakCheckingStrategy [ 

	tabGroup withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabPaneElement >> withoutCheckingStrategy [ 

	tabGroup withoutCheckingStrategy
]
