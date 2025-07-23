Class {
	#name : #ToTabPaneElement,
	#superclass : #ToPane,
	#traits : 'TToItemBarContainer',
	#classTraits : 'TToItemBarContainer classTrait',
	#instVars : [
		'bodyContainer',
		'headerContainer'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #adding }
ToTabPaneElement >> addTabItemData: aData [

	self tabGroup addTabItemData: aData
]

{ #category : #accessing }
ToTabPaneElement >> alignEnd [

	headerContainer alignEnd
]

{ #category : #accessing }
ToTabPaneElement >> alignMiddle [

	headerContainer alignMiddle
]

{ #category : #accessing }
ToTabPaneElement >> alignStart [

	headerContainer alignStart
]

{ #category : #configuration }
ToTabPaneElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.

	self tabGroup horizontal: self isHorizontal not.
	self atStartSide
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ].
	self isHorizontal
		ifTrue: [
				self header
					beVertical;
					vMatchParent;
					hFitContent ]
		ifFalse: [
				self header
					beHorizontal;
					hMatchParent;
					vFitContent ]
]

{ #category : #accessing }
ToTabPaneElement >> atStartSide [

	^ self tabGroup atStartSide
]

{ #category : #accessing }
ToTabPaneElement >> atStartSide: aBoolean [

	self tabGroup atStartSide: aBoolean.
	self requestNewConfiguration.
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

	headerContainer := ToTabPaneHeaderElement new.
	bodyContainer := ToPane new
		                 id: #body;
		                 yourself.
	bodyContainer matchParent.
	self setItemBar: self tabGroup itemBar.
	self addChildren: {
			headerContainer.
			bodyContainer }.
			
	self tabGroup
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event copy ].
	self tabGroup
		addEventHandlerOn: ToBarItemEvent
		do: [ :event | self dispatchEvent: event copy ].
	self tabGroup
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy ].

	self addEventHandler: self defaultEventHandler
]

{ #category : #accessing }
ToTabPaneElement >> itemBuilder: aValuable [
	" aValuable takes the new TabItemElement, the data and the TabGroupElement as arguments "
	
	self tabGroup itemBuilder: aValuable
]

{ #category : #accessing }
ToTabPaneElement >> noAlignment [

	headerContainer noAlignment
]

{ #category : #accessing }
ToTabPaneElement >> preservePane [
	self deprecated: 'Use ToTabButton>>#paneDestroyer: to set a destroyer to a particular button'.

	^ false
]

{ #category : #accessing }
ToTabPaneElement >> showAddTabItemButton [

	^ self tabGroup showAddTabItemButton
]

{ #category : #accessing }
ToTabPaneElement >> showAddTabItemButton: aBoolean [

	self tabGroup showAddTabItemButton: aBoolean
]

{ #category : #accessing }
ToTabPaneElement >> tabGroup [ 

	^ headerContainer tabGroup 
]

{ #category : #'t - checkable group owner' }
ToTabPaneElement >> withStrictCheckingStrategy [ 

	self tabGroup withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabPaneElement >> withWeakCheckingStrategy [ 

	self tabGroup withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabPaneElement >> withoutCheckingStrategy [ 

	self tabGroup withoutCheckingStrategy
]
