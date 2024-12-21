Class {
	#name : #ToWindowPopupMode,
	#superclass : #ToWindowMode,
	#instVars : [
		'anchorRoot',
		'placement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToWindowPopupMode >> anchorRoot [

	" the root element in which the window is placed "
	^ anchorRoot ifNil: [ anchorRoot := manager element space root ]
]

{ #category : #accessing }
ToWindowPopupMode >> anchorRoot: anElement [

	" the root element in which the window is placed "
	anchorRoot := anElement
]

{ #category : #'api - displaying' }
ToWindowPopupMode >> arrangeWindowOnEvent: anEvent [

	self placement arrangeWindowFromManager: manager onEvent: anEvent
]

{ #category : #accessing }
ToWindowPopupMode >> placement [ 

	^ placement ifNil: [ placement := manager defaultPlacement ] 
]

{ #category : #accessing }
ToWindowPopupMode >> placement: aPlacement [

	placement := aPlacement
]

{ #category : #'window handling' }
ToWindowPopupMode >> showWindow: aWindow [

	self anchorRoot addChild: aWindow
]

{ #category : #accessing }
ToWindowPopupMode >> windowClass [ 

	^ manager popupWindowClass 
]
