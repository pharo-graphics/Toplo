Class {
	#name : #ToImage,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithViewModel',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait',
	#instVars : [
		'innerImage'
	],
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #'form accessing' }
ToImage >> errorInnerFormNotFound [
	"Raise a NotFound exception."

	NotFound signalFor: self
]

{#category : #initialization }
ToImage >> initialize [

	super initialize.
	self fitContent.
	innerImage := self defaultInnerImage.
	self addChild: innerImage.
	" I ** must be ** considered as a leaf of a UI element tree. Otherwise, click may not work on me. This is why my children are not allowed to manage mouse events. Related to https://github.com/plantec/Toplo/issues/41"
	self preventChildrenMouseEvents
]
