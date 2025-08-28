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
ToTabPaneElement >> applyConfiguration [

	super applyConfiguration.

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
	self requestConfiguration.
]

{ #category : #accessing }
ToTabPaneElement >> body [ 

	^ bodyContainer 
]

{ #category : #accessing }
ToTabPaneElement >> compactHeaderLayoutMode: aBoolean [

	self header compactLayoutMode: aBoolean.
	self requestConfiguration 
]

{ #category : #accessing }
ToTabPaneElement >> header [ 

	^ headerContainer 
]

{ #category : #accessing }
ToTabPaneElement >> headerAlignment [

	^ headerContainer alignment
]

{ #category : #accessing }
ToTabPaneElement >> headerAlignment: anElementAlignment [ 

	headerContainer alignment: anElementAlignment 
]

{ #category : #accessing }
ToTabPaneElement >> hidePartlyVisibleNodes: aBoolean [

	self tabGroup hidePartlyVisibleNodes: aBoolean
]

{ #category : #initialization }
ToTabPaneElement >> initialize [

	super initialize.

	headerContainer := ToTabPaneHeaderElement new.
	bodyContainer := BlElement new
		                 id: #body;
		                 yourself.
	bodyContainer constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ].
	self setItemBar: self tabGroup itemBar.
	self addChildren: {
			headerContainer.
			bodyContainer }.
	self tabGroup addEventHandler: (ToTabGroupInTabPaneEventHandler new
			 tabPane: self;
			 yourself)
]

{ #category : #accessing }
ToTabPaneElement >> isAlignEnd [

	^ headerContainer isAlignEnd
]

{ #category : #accessing }
ToTabPaneElement >> isAlignMiddle [

	^ headerContainer isAlignMiddle
]

{ #category : #accessing }
ToTabPaneElement >> isAlignStart [

	^ headerContainer isAlignStart
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

{ #category : #'hooks - layout' }
ToTabPaneElement >> requestLayoutModeCheck [

	headerContainer requestLayoutModeCheck
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

{ #category : #accessing }
ToTabPaneElement >> tabGroupDynamicLayoutMode: aBoolean [

	self
		deprecated: 'Use compactHeaderLayoutMode: instead'
		transformWith: '`@rcvr tabGroupDynamicLayoutMode: `@arg'
			-> '`@rcvr compactHeaderLayoutMode: `@arg'.
	self compactHeaderLayoutMode: aBoolean
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
