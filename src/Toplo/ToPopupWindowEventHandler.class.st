Class {
	#name : #ToPopupWindowEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - accessing' }
ToPopupWindowEventHandler >> eventsToHandle [

	^ { BlMouseDownOutsideEvent }
]

{ #category : #'event handling' }
ToPopupWindowEventHandler >> mouseDownOutsideEvent: anEvent [

	anEvent originalEvent target = anEvent currentTarget widget
		ifTrue: [ ^ self ].
	anEvent consumed: true.
	anEvent currentTarget close
]
