Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToEnableable + TToClickable + TToWidgetWithTooltip + TToWidgetWithViewModel + TToWidgetWithContextMenu',
	#classTraits : 'TToWidget classTrait + TToEnableable classTrait + TToClickable classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'client'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - click behavior' }
ToGeneralButton >> client [

	^ client
]

{ #category : #accessing }
ToGeneralButton >> client: anObject [

	client := anObject
]

{ #category : #'t - initialization dresser' }
ToGeneralButton >> defaultDresser [

	^ ToGeneralButtonDresser new
]

{ #category : #initialization }
ToGeneralButton >> defaultLook [ 

	^ ToButtonDefaultLook new
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	" I ** must be ** considered as a leaf of a UI element tree. Otherwise, click may not work on me. This is why my children are not allowed to manage mouse events. Related to https://github.com/plantec/Toplo/issues/41"
	self preventChildrenMouseEvents.
]
