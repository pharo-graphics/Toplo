Class {
	#name : 'ToGeneralButton',
	#superclass : 'ToElement',
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#instVars : [
		'clickHandler',
		'clickEventClass'
	],
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 't - clickable' }
ToGeneralButton >> clickHandler [

	^ clickHandler
]

{ #category : 't - clickable' }
ToGeneralButton >> clickHandler: anEventHandler [

	clickHandler := anEventHandler 
]

{ #category : 'skin' }
ToGeneralButton >> defaultBackground [

	^ Color transparent 
]

{ #category : 'skin' }
ToGeneralButton >> defaultBorder [

	^ Color transparent 
]

{ #category : 'skin' }
ToGeneralButton >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 4 
]

{ #category : 'initialization' }
ToGeneralButton >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : 'skin' }
ToGeneralButton >> defaultPadding [

	^ BlInsets
		  top: 5
		  left: 10
		  bottom: 5
		  right: 10
]

{ #category : 'skin' }
ToGeneralButton >> hoveredBackground [

	^ Color transparent 
]

{ #category : 'skin' }
ToGeneralButton >> hoveredBorder [

	^ Color lightGray alpha: 0.2 
]

{ #category : 'initialization' }
ToGeneralButton >> initialize [

	super initialize.
	self allowMousePickOutsideEvent
]

{ #category : 'skin' }
ToGeneralButton >> installRawStyle [ 

	super installRawStyle.
	self padding: self defaultPadding.
	self geometry: self defaultGeometry.
	self border: self defaultBorder
]

{ #category : 'skin' }
ToGeneralButton >> newRawSkin [

	^ ToGeneralButtonSkin new
]

{ #category : 'skin' }
ToGeneralButton >> pressedBackground [

	^ Color transparent 
]

{ #category : 'skin' }
ToGeneralButton >> pressedBorder [

	^ Color lightGray alpha: 0.6 
]

{ #category : 't - clickable' }
ToGeneralButton >> rawClickEventClass [

	^ clickEventClass
]

{ #category : 't - clickable' }
ToGeneralButton >> rawClickEventClass: anEventClass [

	clickEventClass := anEventClass 
]
