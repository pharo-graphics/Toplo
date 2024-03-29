Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#instVars : [
		'clickHandler',
		'clickEventClass'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - clickable' }
ToGeneralButton >> clickHandler [

	^ clickHandler
]

{ #category : #'t - clickable' }
ToGeneralButton >> clickHandler: anEventHandler [

	clickHandler := anEventHandler 
]

{ #category : #initialization }
ToGeneralButton >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self allowMousePickOutsideEvent
]

{ #category : #skin }
ToGeneralButton >> newRawSkin [

	^ ToGeneralButtonSkin new
]

{ #category : #'t - clickable' }
ToGeneralButton >> rawClickEventClass [

	^ clickEventClass
]

{ #category : #'t - clickable' }
ToGeneralButton >> rawClickEventClass: anEventClass [

	clickEventClass := anEventClass 
]
