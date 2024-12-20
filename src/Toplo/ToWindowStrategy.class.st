Class {
	#name : #ToWindowStrategy,
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
ToWindowStrategy >> anchorRoot [

	^ anchorRoot ifNil: [ anchorRoot := element space root ]
]

{ #category : #accessing }
ToWindowStrategy >> anchorRoot: anElement [

	anchorRoot := anElement
]

{ #category : #accessing }
ToWindowStrategy >> element: anElement [

	element := anElement
]

{ #category : #accessing }
ToWindowStrategy >> heightHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window size according to the element and the (optional) received event"

	^ heightHook 
]

{ #category : #accessing }
ToWindowStrategy >> heightHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window size according to the element and the (optional) received event"

	heightHook := aValuable
]

{ #category : #accessing }
ToWindowStrategy >> positionHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window position according to the element and the (optional) received event"

	^ positionHook ifNil: [
		  positionHook := [ :window :theElement :event |
		                  (theElement bounds inParent: self anchorRoot)
			                  bounds topLeft ] ]
]

{ #category : #accessing }
ToWindowStrategy >> positionHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window position according to the element and the (optional) received event"

	positionHook := aValuable
]

{ #category : #accessing }
ToWindowStrategy >> widthHook [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window width according to the element and the (optional) received event"

	^ widthHook 
]

{ #category : #accessing }
ToWindowStrategy >> widthHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	return the new window width according to the element and the (optional) received event"

	widthHook := aValuable 
]
