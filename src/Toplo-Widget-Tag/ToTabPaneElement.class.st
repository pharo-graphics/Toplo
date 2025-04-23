Class {
	#name : #ToTabPaneElement,
	#superclass : #ToPane,
	#traits : 'TToItemBarOwner',
	#classTraits : 'TToItemBarOwner classTrait',
	#instVars : [
		'tabGroup',
		'bodyContainer',
		'headerContainer'
	],
	#category : #'Toplo-Widget-Tag-Tab'
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
				vMatchParent;
				hFitContent.
			tabGroup
				vMatchParent;
				hFitContent ]
		ifFalse: [
			self header
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

{ #category : #accessing }
ToTabPaneElement >> header [ 

	^ headerContainer 
]

{ #category : #initialization }
ToTabPaneElement >> initialize [

	super initialize.
	headerContainer := ToElement new
		                 id: #header;
		                 yourself.
	bodyContainer := ToElement new
		                 id: #body;
		                 yourself.
	bodyContainer matchParent.
	bodyContainer background: Color red.
	tabGroup := self newTabGroupElement.
	self setItemBar: tabGroup itemBar.
	headerContainer addChild: tabGroup.
	self addChildren: {
			headerContainer.
			bodyContainer }
]

{ #category : #initialization }
ToTabPaneElement >> newTabGroupElement [

	| tg |
	tg := ToTabPaneGroupElement new.
	"tg
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | event checkedList traceCr ]."
	tg matchParent.
	^ tg

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
