Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TToResizable + TToEnableable + TToSkinable + TObservable + TToElementWithTooltip + TToElementWithContextMenu',
	#classTraits : 'TToResizable classTrait + TToEnableable classTrait + TToSkinable classTrait + TObservable classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToElement >> defaultLayout [

	^ BlLinearLayout horizontal

]

{ #category : #'t - skinable - initialization' }
ToElement >> defaultStyleStamps [

	^ #( )
]

{ #category : #initialization }
ToElement >> initialize [ 

	super initialize.
	self class initializeSlots: self.
	self initializeSkinInstallationPhaseChecker
]

{ #category : #initialization }
ToElement >> initializeSkinInstallationPhaseChecker [

	self addEventHandler: ToSpaceSkinInstallationPhaseCheckerEventHandler new
]

{ #category : #accessing }
ToElement >> innerElement [ 

	^ nil
]

{ #category : #'t - layout resizeable' }
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
