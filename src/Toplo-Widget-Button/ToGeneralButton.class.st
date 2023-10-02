Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToClickable + TToWidgetWithTooltip + TToWidgetWithContextMenu',
	#classTraits : 'TToWidget classTrait + TToClickable classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithContextMenu classTrait',
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToGeneralButton >> defaultEventHandler [ 

	^ ToSkinableEventHandler new 
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self addEventHandler: self defaultEventHandler
]
