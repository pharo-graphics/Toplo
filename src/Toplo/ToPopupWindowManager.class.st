Class {
	#name : #ToPopupWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#instVars : [
		'autoCloseOnMouseUpDelay',
		'mouseButton'
	],
	#category : 'Toplo-Core-Window'
}

{ #category : #accessing }
ToPopupWindowManager >> autoCloseOnMouseUpDelay [

	^ autoCloseOnMouseUpDelay ifNil: [ autoCloseOnMouseUpDelay := self defaultAutoCloseOnMouseUpDelay ]
]

{ #category : #accessing }
ToPopupWindowManager >> autoCloseOnMouseUpDelay: aDelay [

	autoCloseOnMouseUpDelay := aDelay ifNotNil: [:d| d asDuration ]
]

{ #category : #accessing }
ToPopupWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ 300 milliSeconds
]

{ #category : #initialization }
ToPopupWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position:
		  (theElement bounds inParent: self anchorRoot) bounds bottomLeft ]
]

{ #category : #accessing }
ToPopupWindowManager >> elementEventHandlerClass [ 

	^ ToElementWithPopupEventHandler
]

{ #category : #initialization }
ToPopupWindowManager >> initialize [ 

	super initialize.
	self usePrimaryMouseButton 
]

{ #category : #'mouse handlers' }
ToPopupWindowManager >> mouseDownInElementEvent: anEvent [

	builder ifNil: [ ^ self ].
	anEvent button = mouseButton ifFalse: [ ^ self ].
	currentWindow ifNotNil: [
		^ currentWindow close ].
	self newWindowEvent: anEvent.
	element enqueueTask:
		(BlTaskAction new action: [ currentWindow popupEvent: anEvent ])
]

{ #category : #'mouse handlers' }
ToPopupWindowManager >> mouseUpInElementEvent: anEvent [

	| delay |
	currentWindow ifNil: [ ^ self ].
	currentWindow popupTimestamp ifNil: [ ^ self ].
	" check a minimal delay between opening and closing.
		The mouse up can occur immediately after the window opening -> don't close the popup window.
		After a given delay between down and up, the popup window is closed "
	delay := anEvent timestamp - currentWindow popupTimestamp.
	delay > self autoCloseOnMouseUpDelay ifTrue: [ currentWindow close ]
]

{ #category : #initialization }
ToPopupWindowManager >> usePrimaryMouseButton [

	mouseButton := BlMouseButton primary
]

{ #category : #initialization }
ToPopupWindowManager >> useSecondaryMouseButton [

	mouseButton := BlMouseButton secondary
]
