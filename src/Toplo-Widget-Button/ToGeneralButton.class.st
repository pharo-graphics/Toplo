Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToClickable + TToElementWithTooltip + TToElementWithContextMenu',
	#classTraits : 'TToWidget classTrait + TToClickable classTrait + TToElementWithTooltip classTrait + TToElementWithContextMenu classTrait',
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToGeneralButton >> defaultEventHandler [ 

	^ ToSkinnableEventHandler new 
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self addEventHandler: self defaultEventHandler
]
