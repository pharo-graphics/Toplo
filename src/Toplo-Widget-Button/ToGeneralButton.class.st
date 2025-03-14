Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToClickable',
	#classTraits : 'TToClickable classTrait',
	#instVars : [
		'takeFocusOnClick'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToGeneralButton >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToGeneralButton >> initialize [

	super initialize.
	self initializeAsClickable.
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

{ #category : #accessing }
ToGeneralButton >> takeFocusOnClick [

	^ takeFocusOnClick
]

{ #category : #accessing }
ToGeneralButton >> takeFocusOnClick: aBoolean [

	takeFocusOnClick := aBoolean
]
