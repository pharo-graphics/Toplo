Class {
	#name : 'ToElement',
	#superclass : 'BlElement',
	#traits : 'TToResizable + TToEnableable + TToSkinable + TToElementWithTooltip + TToElementWithContextMenu',
	#classTraits : 'TToResizable classTrait + TToEnableable classTrait + TToSkinable classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'initialization' }
ToElement >> addSkinInstallerPhaseChecker [

	self skinInstallerPhaseChecker ifNotNil: [ ^ self ].
	self addEventHandler: ToSpaceSkinInstallerPhaseCheckerEventHandler new
]

{ #category : 'skin' }
ToElement >> disabledBackground [

	^ Color lightGray alpha: 0.2 
]

{ #category : 'skin' }
ToElement >> disabledBorder [

	^ Color lightGray alpha: 0.5 
]

{ #category : 'initialization' }
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
ToElement >> onAddedToSceneGraph [

	super onAddedToSceneGraph.
	self requestDefaultSkin
]

{ #category : 't - element with tooltip - private' }
ToElement >> privateTooltipContent [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : 't - element with tooltip - private' }
ToElement >> privateTooltipContent: arg1 [

	arg1
		ifNil: [
			self userData removeKey: #tooltip ifAbsent: [  ].
			^ self ]
		ifNotNil: [ arg1 ].
	self userData at: #tooltip put: arg1
]

{ #category : 'initialization' }
ToElement >> removeSkinInstallerPhaseChecker [

	self skinInstallerPhaseChecker ifNotNil: [ :checker |
		self removeEventHandler: checker ]
]

{ #category : 't - resizeable' }
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

{ #category : 'initialization' }
ToElement >> skinInstallerPhaseChecker [

	^ self eventDispatcher handlers
		  detect: [ :handler |
			  handler isKindOf: ToSpaceSkinInstallerPhaseCheckerEventHandler ]
		  ifNone: [  ]
]

{ #category : 't - element with tooltip - accessing' }
ToElement >> tooltipContent [

	^ self privateTooltipContent 
]
