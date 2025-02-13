Class {
	#name : #ToPopupWindowMode,
	#superclass : #ToWindowMode,
	#instVars : [
		'anchorRoot',
		'placement',
		'measurement'
	],
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #accessing }
ToPopupWindowMode >> anchorRoot [

	" the root element in which the window is placed "
	^ anchorRoot ifNil: [ anchorRoot := manager element space root ]
]

{ #category : #accessing }
ToPopupWindowMode >> anchorRoot: anElement [

	" the root element in which the window is placed "
	anchorRoot := anElement
]

{ #category : #accessing }
ToPopupWindowMode >> measurement [ 

	^ measurement ifNil: [ measurement := manager defaultMeasurement ] 
]

{ #category : #accessing }
ToPopupWindowMode >> measurement: aMeasurement [

	measurement := aMeasurement 
]

{ #category : #'api - displaying' }
ToPopupWindowMode >> onMeasure: anExtentMeasurementSpec window: aWindow onEvent: anEvent [

	self measurement onMeasure: anExtentMeasurementSpec window: aWindow onEvent: anEvent
]

{ #category : #accessing }
ToPopupWindowMode >> placement [ 

	^ placement ifNil: [ placement := manager defaultPlacement ] 
]

{ #category : #accessing }
ToPopupWindowMode >> placement: aPlacement [

	placement := aPlacement
]

{ #category : #'api - displaying' }
ToPopupWindowMode >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	self placement positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext
]

{ #category : #'window handling' }
ToPopupWindowMode >> startWindow: aWindow [

	self anchorRoot addChild: aWindow
]

{ #category : #'window handling' }
ToPopupWindowMode >> stopWindow: aWindow [

	aWindow removeFromParent
]

{ #category : #accessing }
ToPopupWindowMode >> windowClass [ 

	^ manager popupWindowClass 
]
