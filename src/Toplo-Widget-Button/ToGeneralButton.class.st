Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToItem + TToClickable',
	#classTraits : 'TToItem classTrait + TToClickable classTrait',
	#instVars : [
		'takeFocusOnClick'
	],
	#category : #'Toplo-Widget-Button-Clickable'
}

{ #category : #configuration }
ToGeneralButton >> applyConfiguration [ 

	super applyConfiguration.
]

{ #category : #initialization }
ToGeneralButton >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self initializeAsClickable.
	takeFocusOnClick := false
]

{ #category : #testing }
ToGeneralButton >> isMenuButton [

	^ self
		  withAllParentsDetect: [ :p | p isMenuItem ]
		  ifFound: [ :p | true ]
		  ifNone: [ false ]
]

{ #category : #skin }
ToGeneralButton >> newRawSkin [

	^ ToGeneralButtonSkin new
]

{ #category : #accessing }
ToGeneralButton >> takeFocusOnClick [

	^ takeFocusOnClick
]

{ #category : #accessing }
ToGeneralButton >> takeFocusOnClick: aBoolean [

	takeFocusOnClick := aBoolean
]
