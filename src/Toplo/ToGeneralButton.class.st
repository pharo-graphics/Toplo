Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithState + TToClickableWidget + TToWidgetWithTooltip + TToWidgetWithViewModel',
	#classTraits : 'TToWidget classTrait + TToWidgetWithState classTrait + TToClickableWidget classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self initializeClickBehavior
]
