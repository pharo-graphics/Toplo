Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToClickable + TToWidgetWithTooltip + TToWidgetWithViewModel + TToWidgetWithContextMenu',
	#classTraits : 'TToWidget classTrait + TToClickable classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithContextMenu classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	self class initializeSlots: self.
	super initialize.

]
