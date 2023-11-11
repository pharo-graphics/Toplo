Class {
	#name : #ToPopupWindowHandler,
	#superclass : #ToAnchoredWindowHandler,
	#instVars : [
		'autoCloseOnMouseUpDelay',
		'mouseButton'
	],
	#category : 'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindowHandler >> autoCloseOnMouseUpDelay [

	^ autoCloseOnMouseUpDelay ifNil: [ autoCloseOnMouseUpDelay := 300 milliSeconds ]
]

{ #category : #accessing }
ToPopupWindowHandler >> autoCloseOnMouseUpDelay: aDelay [

	autoCloseOnMouseUpDelay := aDelay asDelay
]

{ #category : #initialization }
ToPopupWindowHandler >> defaulPositionHook [

	^ [ :event :theElement | theElement bounds inSpace bounds bottomLeft ]
]

{ #category : #accessing }
ToPopupWindowHandler >> elementEventHandlerClass [ 

	^ ToElementWithPopupEventHandler
]

{ #category : #initialization }
ToPopupWindowHandler >> initialize [ 

	super initialize.
	self usePrimaryMouseButton 
]

{ #category : #'mouse handlers' }
ToPopupWindowHandler >> mouseDownInElementEvent: anEvent [

	builder ifNil: [ ^ self ].
	anEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNotNil: [
		^ self closeWindow ].
	self newWindowEvent: anEvent.
	element enqueueTask:
		(BlTaskAction new action: [ currentWindow popupEvent: anEvent ])
]

{ #category : #'mouse handlers' }
ToPopupWindowHandler >> mouseUpInElementEvent: anEvent [

	| delay |
	currentWindow ifNil: [ ^ self ].
	currentWindow popupTimestamp ifNil: [ ^ self ].
	" check a minimal delay between opening and closing.
		The mouse up can occur immediately after the window opening -> don't close the popup window.
		After a given delay between down and up, the popup window is closed "
	delay := anEvent timestamp - currentWindow popupTimestamp.
	delay > self autoCloseOnMouseUpDelay ifTrue: [ self closeWindow ]
]

{ #category : #initialization }
ToPopupWindowHandler >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #initialization }
ToPopupWindowHandler >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
