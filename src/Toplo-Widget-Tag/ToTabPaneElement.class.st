Class {
	#name : #ToTabPaneElement,
	#superclass : #ToPane,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#instVars : [
		'tabGroup',
		'headContainer',
		'bodyContainer'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

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

{ #category : #'instance creation' }
ToTabPaneElement >> newWidgetConfiguration [ 

	^ ToTabPaneElementConfiguration new
]

{ #category : #accessing }
ToTabPaneElement >> tabGroup [ 

	^ tabGroup 
]
