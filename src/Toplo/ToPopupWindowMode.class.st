Class {
	#name : #ToPopupWindowMode,
	#superclass : #ToWindowMode,
	#instVars : [
		'anchorRoot',
		'placement'
	],
	#category : #'Toplo-Core-Window'
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

{ #category : #'api - displaying' }
ToPopupWindowMode >> arrangeWindowOnEvent: anEvent [

	self placement arrangeWindowFromManager: manager onEvent: anEvent
]

{ #category : #accessing }
ToPopupWindowMode >> placement [ 

	^ placement ifNil: [ placement := manager defaultPlacement ] 
]

{ #category : #accessing }
ToPopupWindowMode >> placement: aPlacement [

	placement := aPlacement
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
