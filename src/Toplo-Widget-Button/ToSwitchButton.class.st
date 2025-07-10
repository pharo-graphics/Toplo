Class {
	#name : #ToSwitchButton,
	#superclass : #ToButton,
	#instVars : [
		'wishedTrackExtent'
	],
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'t - checkable - accessing' }
ToSwitchButton >> allowIndeterminate: aBoolean [

	self shouldNotImplement 
]

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
	self initializeAsCheckable.
	self checked: false.
	self clickEventClass: ToCheckableChangedEvent.

]

{ #category : #skin }
ToSwitchButton >> newRawSkin [ 

	^ ToSwitchButtonSkin new
]

{ #category : #layout }
ToSwitchButton >> onMeasure: anExtentMeasurementSpec [

	wishedTrackExtent ifNotNil: [
		self icon size:
			wishedTrackExtent - (self padding left + self padding right
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
ToSwitchButton >> wishedTrackExtent: aPoint [

	wishedTrackExtent := aPoint.
	self requestLayout
]

{ #category : #accessing }
ToSwitchButton >> wishedTrackSize: aPoint [

		self
		deprecated: 'Use #wishedTrackExtent: instead. See: https://github.com/pharo-graphics/Bloc/issues/802'
		transformWith:
			'`@receiver wishedTrackSize: `@arg' ->
			'`@receiver wishedTrackExtent: `@arg'.

	self wishedTrackExtent: aPoint
]
