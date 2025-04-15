Class {
	#name : #ToTabPaneElement,
	#superclass : #ToPane,
	#traits : 'TToItemBarOwner',
	#classTraits : 'TToItemBarOwner classTrait',
	#instVars : [
		'tabGroup',
		'headContainer',
		'bodyContainer'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

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

	^ headContainer 
]

{ #category : #initialization }
ToTabPaneElement >> initialize [

	super initialize.
	headContainer := ToElement new
		                 id: #header;
		                 yourself.
	bodyContainer := ToElement new
		                 id: #body;
		                 yourself.
	bodyContainer matchParent.
	bodyContainer background: Color red.
	tabGroup := ToTabGroupElement new.
	tabGroup matchParent.
	self wrapItemBar: tabGroup itemBar.
	headContainer addChild: tabGroup.
	self addChildren: {
			headContainer.
			bodyContainer }
]

{ #category : #configuration }
ToTabPaneElement >> newWidgetConfiguration [ 

	^ ToTabPaneElementConfiguration new
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
