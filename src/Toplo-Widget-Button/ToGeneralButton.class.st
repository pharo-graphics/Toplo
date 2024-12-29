Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#instVars : [
		'clickHandler',
		'clickEventClass',
		'takeFocusOnClick'
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

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self addEventHandler: ToClickableFocusEventHandler new.
	self applySkinInstallerOnFirstRequest: true.
	takeFocusOnClick := true
]

{ #category : #testing }
ToGeneralButton >> isMenuButton [ 

	^ self hasAnyInParentChainSatisfying: [ :p | p isMenuItem ]
]

{ #category : #testing }
ToGeneralButton >> menuButton [ 

	^ self firstInParentChainSatisfying: [ :p | p isMenuItem ]
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

{ #category : #accessing }
ToGeneralButton >> takeFocusOnClick [

	^ takeFocusOnClick
]

{ #category : #accessing }
ToGeneralButton >> takeFocusOnClick: aBoolean [

	takeFocusOnClick := aBoolean
]
