Class {
	#name : #ToButtonTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Button-Tests-BasicButton'
}

{ #category : #tests }
ToButtonTest >> testButton [
	"Test default values of a new button"

	| button |
	button := ToButton new.

	self assert: button isHorizontal.

	self assert: button isIconFirst.
	self assert: button isLabelFirst equals: false.

	self assert: button icon isNil.
	self assert: button label isNil
]

{ #category : #'click handler' }
ToButtonTest >> testClickRemovingHandler [

	| but done |
	but := ToButton new.
	done := 0.
	but whenClickedDo: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1.
	but removeClickHandler.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1.

	
	
]

{ #category : #'click handler' }
ToButtonTest >> testClickReplacingHandler [

	| but done |
	but := ToButton new.
	done := 0.
	but whenClickedDo: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1.
	but whenClickedDo: [ done := done + 10 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 11.

	
	
]

{ #category : #'click handler' }
ToButtonTest >> testClickWithSimpleHandler [

	| but done |
	but := ToButton new.
	done := 0.
	but whenClickedDo: [ done := done +1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1
	
]

{ #category : #'click handler' }
ToButtonTest >> testClickWithoutHandler [

	| but |
	but := ToButton new.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	
]
