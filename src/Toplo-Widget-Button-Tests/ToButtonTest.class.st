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
ToButtonTest >> testCheckable [

	| but handler |
	but := ToButton new.
	self deny: but isCheckable.
	self assert: but checkableData isNil.
	handler := but checkableEventHandler.
	self assert: handler isNil.
	but checkable: true.
	self assert: but checkableData notNil.
	handler := but checkableEventHandler.
	self assert: handler notNil.
	self assert: (but eventDispatcher handlers includes: handler).
	but checkable: false.
	self assert: but checkableData isNil.
	self deny: (but eventDispatcher handlers includes: handler).
	self assert: but checkableEventHandler isNil
]

{ #category : #'click handler' }
ToButtonTest >> testClickAborted [

	| but count |
	count := 0.
	but := ToButton new.
	but labelText: 'XXXXX'.
	but icon: (ToImage inner: (BlElement new
				  extent: 30 @ 30;
				  background: Color blue;
				  yourself)).
	but matchParent.
	but clickAction: [ count := count + 1 ].
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
	self assert: count equals: 4
]

{ #category : #'click handler' }
ToButtonTest >> testClickAborted2 [

	| but count |
	count := 0.
	but := ToButton new.
	but labelText: 'XXXXX'.
	but icon: (ToImage inner: (BlElement new
				  extent: 30 @ 30;
				  background: Color blue;
				  yourself)).
	but matchParent.
	but clickAction: [ count := count + 1 ].
	space root addChild: but.
	self waitTestingSpaces.
	BlSpace simulateMouseDownOn: but label.
	BlSpace simulateMouseUpOn: but icon.
	self waitTestingSpaces.
	self assert: count equals: 1
]

{ #category : #'click handler' }
ToButtonTest >> testClickWhenDisabled [

	| but done |
	but := ToButton new.
	but disable.
	done := 0.
	but clickAction: [ done := done +1 ].
	self assert: done equals: 0.
	
]

{ #category : #'click handler' }
ToButtonTest >> testClickWith1Action [

	| but done |
	but := ToButton new.
	space root addChild: but.
	done := 0.
	but clickAction: [ done := done +1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 1
	
]

{ #category : #'click handler' }
ToButtonTest >> testClickWith2Actions [

	| but done link1 link2 |
	but := ToButton new.
	space root addChild: but.
	done := 0.
	link1 := but newClickAction: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 1.
	link2 := but newClickAction: [ done := done + 10 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 12.
	link2 unlink.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 13.
	link1 unlink.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 13


	




	
	
]

{ #category : #'click handler' }
ToButtonTest >> testClickWithoutAction [

	| but |
	but := ToButton new.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	
]

{ #category : #'click handler' }
ToButtonTest >> testLinkClickAction [

	| but count |
	count := 0.
	but := ToButton new.
	but matchParent.
	but clickAction: [ count := count + 1 ].
	space root addChild: but.
	BlSpace simulateMouseDownOn: but.
	BlSpace simulateMouseUpOn: but.
	self waitTestingSpaces.
	self assert: count equals: 1
]

{ #category : #'click handler' }
ToButtonTest >> testRemoveClickAction [

	| but done link |
	but := ToButton new.
	space root addChild: but.
	done := 0.
	link := but newClickAction: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 1.
	link unlink.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self waitTestingSpaces.
	self assert: done equals: 1
]
