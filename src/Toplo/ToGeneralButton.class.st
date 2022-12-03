Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithClickBehavior + TToWidgetWithTooltip + TToWidgetWithViewModel',
	#classTraits : 'TToWidget classTrait + TToWidgetWithClickBehavior classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToGeneralButton >> defaultDresser [

	^ ToButtonDefaultDresser new
]

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self initializeClickBehavior.
	
	self initializeDresser 
]
