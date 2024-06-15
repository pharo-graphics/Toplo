Class {
	#name : #ToButtonTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Button-Tests-Core'
}

{ #category : #tests }
ToButtonTest >> testButton [
	"Test default values of a new button"

	| button |
	button := ToButton new.

	self assert: button isHorizontal.

	self assert: button isStartToEnd.
	self assert: button isEndToStart equals: false.

	self assert: button icon isNil.
	self assert: button label isNil
]

{ #category : #'click handler' }
ToButtonTest >> testClickAborted [

	| but count |
	count := 0.
	but := ToButton new.
	but labelText: 'XXXXX'.
	but icon: (ToImage inner: (BlElement new
				  size: 30 @ 30;
				  background: Color blue;
				  yourself)).
	but matchParent.
	but whenClickedDo: [ count := count + 1 ].
	space root addChild: but.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but icon.
	self waitTestingSpaces.
	self assert: count equals: 1.
	BlSpace simulateMouseDownOn: but icon.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: count equals: 2.
	BlSpace simulateMouseDownOn: but label.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: count equals: 3.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but label.
	self waitTestingSpaces.
	self assert: count equals: 4.




]

{ #category : #'click handler' }
ToButtonTest >> testClickAborted2 [

	| but count |
	count := 0.
	but := ToButton new.
	but labelText: 'XXXXX'.
	but icon: (ToImage inner: (BlElement new
				  size: 30 @ 30;
				  background: Color blue;
				  yourself)).
	but matchParent.
	but whenClickedDo: [ count := count + 1 ].
	space root addChild: but.
	BlSpace simulateMouseDownOn: but label.
	BlSpace simulateMouseUpOn: but icon.
	self waitTestingSpaces.
	self assert: count equals: 1
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
ToButtonTest >> testClickWhenDisabled [

	| but done |
	but := ToButton new.
	but disable.
	done := 0.
	but whenClickedDo: [ done := done +1 ].
	self assert: done equals: 0.
	
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

{ #category : #'click handler' }
ToButtonTest >> testWhenClickedDo [

	| but count |
	count := 0.
	but := ToButton new.
	but matchParent.
	but whenClickedDo: [ count := count + 1 ].
	space root addChild: but.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: count equals: 1
]
