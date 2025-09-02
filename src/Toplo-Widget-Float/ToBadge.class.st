Class {
	#name : #ToBadge,
	#superclass : #ToBaseBadge,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToBadge >> defaultBackground [

	^ Color red
]

{ #category : #initialization }
ToBadge >> defaultMinWidth [

	^ 16
]

{ #category : #initialization }
ToBadge >> initialize [

	super initialize.
	self minWidth: self defaultMinWidth.
	self background: self defaultBackground 
]

{ #category : #layout }
ToBadge >> onMeasure: anExtentMeasurementSpec [

	| prevHeight |
	prevHeight := self measuredHeight.
	super onMeasure: anExtentMeasurementSpec.
	prevHeight ~= self measuredHeight ifFalse: [ ^ self ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 self measuredHeight - self margin height / 2)
]
