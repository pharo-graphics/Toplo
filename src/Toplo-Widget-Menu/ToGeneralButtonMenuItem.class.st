Class {
	#name : #ToGeneralButtonMenuItem,
	#superclass : #ToMenuItemElement,
	#instVars : [
		'button'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToGeneralButtonMenuItem >> button [

	^ button 
]

{ #category : #accessing }
ToGeneralButtonMenuItem >> button: aButton [

	self button = aButton ifTrue: [ ^ self ].
	button ifNotNil: [ button removeFromParent ].
	button := aButton.
	button ifNotNil: [
		self addChild: button at: 1.
		aButton hMatchParent ]
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> buttonClass [

	^ ToGeneralButton 
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> buttonClickEventClass [

	^ BlMouseUpEvent
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> clickEventClass [

	^ button clickEventClass
]

{ #category : #testing }
ToGeneralButtonMenuItem >> closeOnMouseEvent [

	^ true
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToGeneralButtonMenuItem >> initialize [ 

	super initialize.
	self button: self buttonClass new.
	"self button withNullSkin."
	self button takeFocusOnClick: false.
	self button clickEventClass: self buttonClickEventClass.
	self layout: self defaultLayout
]

{ #category : #skin }
ToGeneralButtonMenuItem >> newRawSkin [

	^ ToGeneralButtonMenuItemSkin new
]

{ #category : #'t - clickable - click behavior' }
ToGeneralButtonMenuItem >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	self button whenClickedDo: aBlock
]
