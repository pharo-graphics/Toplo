Class {
	#name : #ToSwitchButton,
	#superclass : #ToButton,
	#instVars : [
		'wishedTrackSize'
	],
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'t - checkable  - protocol' }
ToSwitchButton >> checkableEventHandlerClass [

	^ ToSwitchButtonEventHandler
]

{ #category : #accessing }
ToSwitchButton >> checkedContainer [ 

	^ self icon checkedContainer
]

{ #category : #accessing }
ToSwitchButton >> handleCheckedBuilder: aValuable [

	self icon handleCheckedBuilder: aValuable
]

{ #category : #initialization }
ToSwitchButton >> initialize [

	super initialize.
	self icon: ToSwitchIcon new.
	self initializeCheckable.
	self checked: false
]

{ #category : #skin }
ToSwitchButton >> newRawSkin [ 

	^ ToSwitchButtonSkin new
]

{ #category : #layout }
ToSwitchButton >> onMeasure: anExtentMeasurementSpec [

	wishedTrackSize ifNotNil: [
		self icon size:
			wishedTrackSize - (self padding left + self padding right
			 @ (self padding top + self padding bottom)) ].

	super onMeasure: anExtentMeasurementSpec
]

{ #category : #accessing }
ToSwitchButton >> track [

	^ self icon
]

{ #category : #accessing }
ToSwitchButton >> uncheckedContainer [ 

	^ self icon uncheckedContainer
]

{ #category : #accessing }
ToSwitchButton >> wishedTrackSize: aPoint [

	wishedTrackSize := aPoint.
	self requestLayout
]

{ #category : #'t - checkable - accessing' }
ToSwitchButton >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
