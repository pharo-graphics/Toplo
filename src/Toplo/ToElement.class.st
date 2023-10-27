Class {
	#name : 'ToElement',
	#superclass : 'BlElement',
	#traits : 'TBlLayoutResizable + TToEnableable + TToElementWithTooltip + TToElementWithContextMenu',
	#classTraits : 'TBlLayoutResizable classTrait + TToEnableable classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'event management' }
ToElement >> addEventFilter: anEventHandler [

	self checkEventHandler: anEventHandler.
	self checkEventFilter: anEventHandler.
	super addEventFilter: anEventHandler
]

{ #category : 'event management' }
ToElement >> addEventHandler: anEventHandler [

	self checkEventHandler: anEventHandler.
	self checkEventFilter: anEventHandler.
	super addEventHandler: anEventHandler
]

{ #category : 'skin - private' }
ToElement >> addSkinInstallerPhaseChecker [

	self skinInstallerPhaseChecker ifNotNil: [ ^ self ].
	self addEventHandler: ToSpaceSkinInstallerPhaseCheckerEventHandler new
]

{ #category : 'event management' }
ToElement >> checkEventFilter: anEventHandler [

	(anEventHandler isKindOf: ToSkinStateGenerator) ifTrue: [
		(self eventDispatcher hasEventFilterSuchThat: [ :eh |
			 eh isKindOf: ToSkinStateGenerator ]) ifTrue: [
			Error signal: 'Only one ' , ToSkinStateGenerator name , ' is allowed' ] ]
]

{ #category : 'event management' }
ToElement >> checkEventHandler: anEventHandler [

	(anEventHandler isKindOf: ToSkinStateGenerator) ifTrue: [
		(self eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToSkinStateGenerator ]) ifTrue: [
			Error signal: 'Only one ' , ToSkinStateGenerator name , ' is allowed' ] ]
]

{ #category : 'initialization' }
ToElement >> defaultLayout [ 

	^ BlFrameLayout new
]

{ #category : 'skin' }
ToElement >> disabledBackground [

	^ Color lightGray alpha: 0.2 
]

{ #category : 'skin' }
ToElement >> disabledBorder [

	^ Color lightGray alpha: 0.5 
]

{ #category : 'skin - private' }
ToElement >> hasSkinInstallerPhaseChecker [

	^ self skinInstallerPhaseChecker notNil
]

{ #category : 'initialization' }
ToElement >> initialize [

	super initialize.
	self layout: self defaultLayout.
	self addSkinInstallerPhaseChecker
]

{ #category : 'hooks - children' }
ToElement >> onAddedToParent [

	super onAddedToParent.
	self hasEnablementFlag ifFalse: [
		self enabled: self parent isEnabled ].
	self parent isWithoutSkin
		ifFalse: [ self parent requestSkin ]
		ifTrue: [ self withoutSkin ]
]

{ #category : 'hooks - children' }
ToElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self skinInstaller
		ifNil: [ self requestSkin ]
		ifNotNil: [ self space elementWithSkinInstaller: self ]
]

{ #category : 'skin - private' }
ToElement >> removeSkinInstallerPhaseChecker [

	self skinInstallerPhaseChecker ifNotNil: [ :checker |
		self removeEventHandler: checker ]
]

{ #category : 't  - layout resizeable' }
ToElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self constraintsDo: aBlock.
	self dispatchEvent: ToLayoutConstraintsChangedEvent new
	
]

{ #category : 'skin - private' }
ToElement >> skinInstallerPhaseChecker [

	^ self eventDispatcher handlers
		  detect: [ :handler |
			  handler isKindOf: ToSpaceSkinInstallerPhaseCheckerEventHandler ]
		  ifNone: [  ]
]
