Class {
	#name : #ToAnchoredWindowStrategy,
	#superclass : #Object,
	#instVars : [
		'anchorRoot',
		'element',
		'positionHook',
		'heightHook',
		'widthHook'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowStrategy >> anchorRoot [
	" the root element in which the window is added "
	^ anchorRoot ifNil: [ anchorRoot := element space root ]
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> anchorRoot: anElement [

	anchorRoot := anElement
]

{ #category : #initialization }
ToAnchoredWindowStrategy >> defaultHeightHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window size according to the element and the (optional) received event"

	^ nil
]

{ #category : #initialization }
ToAnchoredWindowStrategy >> defaultPositionHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window position according to the element and the (optional) received event"

	^ [ :window :theElement :event |
		                  (theElement bounds inParent: self anchorRoot)
			                  bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindowStrategy >> defaultWidthHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window width according to the element and the (optional) received event"

	^ nil
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> element: anElement [
	" the element which has a window manager (a menu as an example) "

	element := anElement
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> heightHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window size according to the element and the (optional) received event"

	^ heightHook ifNil: [ heightHook := self defaultHeightHook ]
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> heightHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window size according to the element and the (optional) received event"

	heightHook := aValuable
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> positionHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window position according to the element and the (optional) received event"

	^ positionHook ifNil: [ positionHook := self defaultPositionHook ]
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> positionHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window position according to the element and the (optional) received event"

	positionHook := aValuable
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> widthHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window width according to the element and the (optional) received event"

	^ widthHook ifNil: [ widthHook := self defaultWidthHook ]
]

{ #category : #accessing }
ToAnchoredWindowStrategy >> widthHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window width according to the element and the (optional) received event"

	widthHook := aValuable 
]
